#============================================================
# Cryptocurrency Market Sentiment and Inflation Dynamics: Evidence from Bolivia
# Model: Daily‐Frequency BSVAR with Sign/Zero Restrictions
# Author: Osmar Bolivar
# Endogenous variables: s (sentiment), e (exchange), inf (inflation)
# Sample: 2023-01-01 to 2025-04-11
# 9 lags, default priors, impact-only restrictions
#============================================================

# 1. Install & load packages
# install.packages("bsvarSIGNs")    # if needed
#install.packages("openxlsx")
library(bsvarSIGNs)
library(zoo)
library(ggplot2)
library(vars)
library(tidyverse)
library(openxlsx)

#============================================================
# 2. Load and prepare the data
df <- read.csv("data_bsvar.csv", stringsAsFactors = FALSE)
names(df)[names(df) == "X"] <- "date"
df$date <- as.Date(df$date)
# Build a numeric matrix of endogenous variables (no header column)
data_mat <- as.matrix(df[, c("inf", "e", "s")])


#============================================================
# 3. Build the sign/zero‐restriction array (impact only: horizon = 1)
vars   <- c("inf", "e", "s")
shocks <- c("InflationShock", "ExchangeShock", "SentimentShock")
H      <- 1

sign_irf <- array(NA, dim = c(3, 3, H),
                  dimnames = list(vars, shocks, NULL))

# (a) InflationShock (col 1): + on inf, 0 on e, 0 on s
sign_irf["inf", "InflationShock", 1] <-  1
sign_irf["e",   "InflationShock", 1] <-  0
sign_irf["s",   "InflationShock", 1] <-  0
# (b) ExchangeShock (col 2): + on inf, + on e, 0 on s
sign_irf["inf", "ExchangeShock",    1] <-  1
sign_irf["e",   "ExchangeShock",    1] <-  1
sign_irf["s",   "ExchangeShock",    1] <-  0
# (c) SentimentShock (col 3): NA on inf, + on e, + on s
sign_irf["inf", "SentimentShock",   1] <-  NA
sign_irf["e",   "SentimentShock",   1] <-  1
sign_irf["s",   "SentimentShock",   1] <-  1
sign_irf


#============================================================
# 4. Determine optimal VAR lags using information criteria
lag_selection <- VARselect(data_mat, lag.max = 30, type = "const")
#print(lag_selection$criteria)
optimal_lag <- lag_selection$selection["AIC(n)"]  # Using AIC as the selection criterion
cat("Optimal number of lags based on AIC:", optimal_lag, "\n")


#============================================================
# 5. BSVAR model specification 
# 7-lag BSVAR model
spec_9 <- specify_bsvarSIGN$new(
  data        = data_mat,
  p           = 9,                          # 9 (AIC) optimal lags
  sign_irf    = sign_irf,                   # impact restrictions
  stationary  = rep(FALSE, ncol(data_mat))  # all series allowed near‐unit‐root
)

spec_30 <- specify_bsvarSIGN$new(
  data        = data_mat,
  p           = 30,                         # 30 lags for monthly, weekly and daily seasonality
  sign_irf    = sign_irf,                   # impact restrictions
  stationary  = rep(FALSE, ncol(data_mat))  # all series allowed near‐unit‐root
)


#============================================================
# 5. Estimate via Gibbs sampler
set.seed(123)
posterior_9 <- estimate(
  specification = spec_9,
  S             = 50000,
  thin          = 1,
  show_progress = TRUE
)

posterior_30 <- estimate(
  specification = spec_30,
  S             = 50000,
  thin          = 1,
  show_progress = TRUE
)

# Save results for later use
#saveRDS(posterior_9, file = "bsvar_posterior_9.rds")
#saveRDS(posterior_30, file = "bsvar_posterior_30.rds")



#============================================================
# 6. Compute Impulse Response Functions (IRFs)
# 365‐day horizon, default (no standardization)
irf_9    <- compute_impulse_responses(posterior_9, horizon = 365, standardise = TRUE)
plot(irf_9, probability = 0.68)

irf_30    <- compute_impulse_responses(posterior_30, horizon = 365, standardise = TRUE)
plot(irf_30, probability = 0.68)

# Save IRFs
#saveRDS(irf_9, file = "bsvar_irf_9.rds")
#saveRDS(irf_30, file = "bsvar_irf_30.rds")



#============================================================
# Extract structured IRFs (9-lag BSVAR)
inf_sentiment_9 <- irf_9[1, 3, 1:365, 5000:50000]  ## Response: Inflation; Shock: Sentiment (1000 Burn-in)
inf_exchange_9 <- irf_9[1, 2, 1:365, 5000:50000]  ## Response: Inflation; Shock: FX (1000 Burn-in)
e_sentiment_9 <- irf_9[2, 3, 1:365, 5000:50000]  ## Response: BOB/USDT; Shock: Sentiment (1000 Burn-in)
e_inflation_9 <- irf_9[2, 1, 1:365, 5000:50000]  ## Response: BOB/USDT; Shock: Inflation (1000 Burn-in)
s_exchange_9 <- irf_9[3, 2, 1:365, 5000:50000]  ## Response: Sentiment Index; Shock: FX (1000 Burn-in)
s_inflation_9 <- irf_9[3, 1, 1:365, 5000:50000]  ## Response: Sentiment Index; Shock: Inflation (1000 Burn-in)

results_irf_9 <- data.frame(
  Day = 1:365,
  p50_inf_sent = apply(inf_sentiment_9, 1, median),
  p68_inf_sent = apply(inf_sentiment_9, 1, function(x) quantile(x, 0.68)),
  p32_inf_sent = apply(inf_sentiment_9, 1, function(x) quantile(x, 0.32)),
  p50_inf_fx = apply(inf_exchange_9, 1, median),
  p68_inf_fx = apply(inf_exchange_9, 1, function(x) quantile(x, 0.68)),
  p32_inf_fx = apply(inf_exchange_9, 1, function(x) quantile(x, 0.32)),
  p50_e_sent = apply(e_sentiment_9, 1, median),
  p68_e_sent = apply(e_sentiment_9, 1, function(x) quantile(x, 0.68)),
  p32_e_sent = apply(e_sentiment_9, 1, function(x) quantile(x, 0.32)),
  p50_e_inf = apply(e_inflation_9, 1, median),
  p68_e_inf = apply(e_inflation_9, 1, function(x) quantile(x, 0.68)),
  p32_e_inf = apply(e_inflation_9, 1, function(x) quantile(x, 0.32)),
  p50_s_fx = apply(s_exchange_9, 1, median),
  p68_s_fx = apply(s_exchange_9, 1, function(x) quantile(x, 0.68)),
  p32_s_fx = apply(s_exchange_9, 1, function(x) quantile(x, 0.32)),
  p50_s_inf = apply(s_inflation_9, 1, median),
  p68_s_inf = apply(s_inflation_9, 1, function(x) quantile(x, 0.68)),
  p32_s_inf = apply(s_inflation_9, 1, function(x) quantile(x, 0.32))
)
View(results_irf_9)
# Cumulative IRFs
results_irf_9_cum <- results_irf_9 %>% mutate(across(-Day, cumsum))
View(results_irf_9_cum)
# export to excel
write.xlsx(results_irf_9, file = "results_irf_9.xlsx", rowNames = FALSE)
write.xlsx(results_irf_9_cum, file = "results_irf_9_cum.xlsx", rowNames = FALSE)


#============================================================
# Extract structured IRFs (30-lag BSVAR)
inf_sentiment_30 <- irf_30[1, 3, 1:365, 5000:50000]  ## Response: Inflation; Shock: Sentiment (1000 Burn-in)
inf_exchange_30 <- irf_30[1, 2, 1:365, 5000:50000]  ## Response: Inflation; Shock: FX (1000 Burn-in)
e_sentiment_30 <- irf_30[2, 3, 1:365, 5000:50000]  ## Response: BOB/USDT; Shock: Sentiment (1000 Burn-in)
e_inflation_30 <- irf_30[2, 1, 1:365, 5000:50000]  ## Response: BOB/USDT; Shock: Inflation (1000 Burn-in)
s_exchange_30 <- irf_30[3, 2, 1:365, 5000:50000]  ## Response: Sentiment Index; Shock: FX (1000 Burn-in)
s_inflation_30 <- irf_30[3, 1, 1:365, 5000:50000]  ## Response: Sentiment Index; Shock: Inflation (1000 Burn-in)

results_irf_30 <- data.frame(
  Day = 1:365,
  p50_inf_sent = apply(inf_sentiment_30, 1, median),
  p68_inf_sent = apply(inf_sentiment_30, 1, function(x) quantile(x, 0.68)),
  p32_inf_sent = apply(inf_sentiment_30, 1, function(x) quantile(x, 0.32)),
  p50_inf_fx = apply(inf_exchange_30, 1, median),
  p68_inf_fx = apply(inf_exchange_30, 1, function(x) quantile(x, 0.68)),
  p32_inf_fx = apply(inf_exchange_30, 1, function(x) quantile(x, 0.32)),
  p50_e_sent = apply(e_sentiment_30, 1, median),
  p68_e_sent = apply(e_sentiment_30, 1, function(x) quantile(x, 0.68)),
  p32_e_sent = apply(e_sentiment_30, 1, function(x) quantile(x, 0.32)),
  p50_e_inf = apply(e_inflation_30, 1, median),
  p68_e_inf = apply(e_inflation_30, 1, function(x) quantile(x, 0.68)),
  p32_e_inf = apply(e_inflation_30, 1, function(x) quantile(x, 0.32)),
  p50_s_fx = apply(s_exchange_30, 1, median),
  p68_s_fx = apply(s_exchange_30, 1, function(x) quantile(x, 0.68)),
  p32_s_fx = apply(s_exchange_30, 1, function(x) quantile(x, 0.32)),
  p50_s_inf = apply(s_inflation_30, 1, median),
  p68_s_inf = apply(s_inflation_30, 1, function(x) quantile(x, 0.68)),
  p32_s_inf = apply(s_inflation_30, 1, function(x) quantile(x, 0.32))
)
View(results_irf_30)

# Cumulative IRFs
results_irf_30_cum <- results_irf_30 %>% mutate(across(-Day, cumsum))
View(results_irf_30_cum)
# export to excel
write.xlsx(results_irf_30, file = "results_irf_30.xlsx", rowNames = FALSE)
write.xlsx(results_irf_30_cum, file = "results_irf_30_cum.xlsx", rowNames = FALSE)







#============================================================
# 7. Forecast Error Variance Decomposition (FEVD)
#fevd <- compute_variance_decompositions(posterior, horizon = 90)
#plot(fevd, probability = 0.68)

# 8. (Optional) Historical Decompositions & Fitted Values
# hist_dec <- compute_historical_decompositions(posterior)
# fitted   <- compute_fitted_values(posterior)

#saveRDS(fevd,      file = "bsvr_fevd.rds")
#============================================================