#============================================================
# Cryptocurrency Market Sentiment and Inflation Dynamics: Evidence from Bolivia
# Model: Daily‐Frequency BSVAR with Sign/Zero Restrictions
# Author: Osmar Bolivar
# Endogenous variables: s (sentiment), e (exchange), inf (inflation), i (interest rate)
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
df_2 <- read.csv("data_bsvar_2.csv", stringsAsFactors = FALSE)
names(df_2)[names(df_2) == "X"] <- "date"
df_2$date <- as.Date(df_2$date)
# Build a numeric matrix of endogenous variables (no header column)
data_mat_2 <- as.matrix(df_2[, c("inf", "e", "s", "i")])


#============================================================
# 3. Build the sign/zero‐restriction array (impact only: horizon = 1)
vars_2   <- c("inf", "e", "s", "i")
shocks_2 <- c("InflationShock", "ExchangeShock", "SentimentShock", "MonetaryShock")
H      <- 1

sign_irf_2 <- array(NA, dim = c(4, 4, H),
                  dimnames = list(vars_2, shocks_2, NULL))

# (a) InflationShock (col 1): + on inf, 0 on e, 0 on s, 0 on i
sign_irf_2["inf", "InflationShock", 1] <-  1
sign_irf_2["e",   "InflationShock", 1] <-  0
sign_irf_2["s",   "InflationShock", 1] <-  0
sign_irf_2["i",   "InflationShock", 1] <-  0
# (b) ExchangeShock (col 2): + on inf, + on e, 0 on s, 0 on i
sign_irf_2["inf", "ExchangeShock",    1] <-  1
sign_irf_2["e",   "ExchangeShock",    1] <-  1
sign_irf_2["s",   "ExchangeShock",    1] <-  0
sign_irf_2["i",   "ExchangeShock",    1] <-  0
# (c) SentimentShock (col 3): NA on inf, + on e, + on s, 0 on i
sign_irf_2["inf", "SentimentShock",   1] <-  NA
sign_irf_2["e",   "SentimentShock",   1] <-  1
sign_irf_2["s",   "SentimentShock",   1] <-  1
sign_irf_2["i",   "SentimentShock",   1] <-  0
# (d) MonetaryShock (col 4): NA on inf, NA on e, NA on s, + on i
sign_irf_2["inf", "MonetaryShock",   1] <-  NA
sign_irf_2["e",   "MonetaryShock",   1] <-  NA
sign_irf_2["s",   "MonetaryShock",   1] <-  NA
sign_irf_2["i",   "MonetaryShock",   1] <-  1
sign_irf_2


#============================================================
# 4. Determine optimal VAR lags using information criteria
lag_selection_2 <- VARselect(data_mat_2, lag.max = 30, type = "const")
#print(lag_selection_2$criteria)
optimal_lag_2 <- lag_selection_2$selection["AIC(n)"]  # Using AIC as the selection criterion
cat("Optimal number of lags based on AIC:", optimal_lag_2, "\n")


#============================================================
# 5. BSVAR model specification 
# 7-lag BSVAR model
spec_9_i <- specify_bsvarSIGN$new(
  data        = data_mat_2,
  p           = 9,                          # 9 (AIC) optimal lags
  sign_irf    = sign_irf_2,                   # impact restrictions
  stationary  = rep(FALSE, ncol(data_mat_2))  # all series allowed near‐unit‐root
)

spec_30_i <- specify_bsvarSIGN$new(
  data        = data_mat_2,
  p           = 30,                         # 30 lags for monthly, weekly and daily seasonality
  sign_irf    = sign_irf_2,                   # impact restrictions
  stationary  = rep(FALSE, ncol(data_mat_2))  # all series allowed near‐unit‐root
)


#============================================================
# 5. Estimate via Gibbs sampler
set.seed(123)
posterior_9_i <- estimate(
  specification = spec_9_i,
  S             = 50000,
  thin          = 1,
  show_progress = TRUE
)

#posterior_30_i <- estimate(
#  specification = spec_30_i,
#  S             = 50000,
#  thin          = 1,
#  show_progress = TRUE
#)




#============================================================
# 6. Compute Impulse Response Functions (IRFs)
# 365‐day horizon, default (no standardization)
irf_9_i    <- compute_impulse_responses(posterior_9_i, horizon = 365, standardise = TRUE)
plot(irf_9_i, probability = 0.68)

#irf_30_i    <- compute_impulse_responses(posterior_30_i, horizon = 365, standardise = TRUE)
#plot(irf_30_i, probability = 0.68)



#============================================================
# Extract structured IRFs (9-lag BSVAR)
inf_sentiment_9_i <- irf_9_i[1, 3, 1:365, 5000:50000]  ## Response: Inflation; Shock: Sentiment (1000 Burn-in)
inf_exchange_9_i <- irf_9_i[1, 2, 1:365, 5000:50000]  ## Response: Inflation; Shock: FX (1000 Burn-in)
inf_monetary_9_i <- irf_9_i[1, 4, 1:365, 5000:50000]  ## Response: Inflation; Shock: Mon. Pol. (1000 Burn-in)

e_sentiment_9_i <- irf_9_i[2, 3, 1:365, 5000:50000]  ## Response: BOB/USDT; Shock: Sentiment (1000 Burn-in)
e_inflation_9_i <- irf_9_i[2, 1, 1:365, 5000:50000]  ## Response: BOB/USDT; Shock: Inflation (1000 Burn-in)
e_monetary_9_i <- irf_9_i[2, 4, 1:365, 5000:50000]  ## Response: Inflation; Shock: Mon. Pol. (1000 Burn-in)

s_exchange_9_i <- irf_9_i[3, 2, 1:365, 5000:50000]  ## Response: Sentiment Index; Shock: FX (1000 Burn-in)
s_inflation_9_i <- irf_9_i[3, 1, 1:365, 5000:50000]  ## Response: Sentiment Index; Shock: Inflation (1000 Burn-in)
s_monetary_9_i <- irf_9_i[3, 4, 1:365, 5000:50000]  ## Response: Sentiment Index; Shock: Mon. Pol. (1000 Burn-in)

i_inflation_9_i <- irf_9_i[4, 1, 1:365, 5000:50000]  ## Response: Interest Rate; Shock: Inflation (1000 Burn-in)
i_exchange_9_i <- irf_9_i[4, 2, 1:365, 5000:50000]  ## Response: Interest Rate; Shock: FX (1000 Burn-in)
i_sentiment_9_i <- irf_9_i[4, 3, 1:365, 5000:50000]  ## Response: Interest Rate; Shock: Sentiment (1000 Burn-in)

results_irf_9_i <- data.frame(
  Day = 1:365,
  p50_inf_sent = apply(inf_sentiment_9_i, 1, median),
  p68_inf_sent = apply(inf_sentiment_9_i, 1, function(x) quantile(x, 0.68)),
  p32_inf_sent = apply(inf_sentiment_9_i, 1, function(x) quantile(x, 0.32)),
  p50_inf_fx = apply(inf_exchange_9_i, 1, median),
  p68_inf_fx = apply(inf_exchange_9_i, 1, function(x) quantile(x, 0.68)),
  p32_inf_fx = apply(inf_exchange_9_i, 1, function(x) quantile(x, 0.32)),
  p50_inf_i = apply(inf_monetary_9_i, 1, median),
  p68_inf_i = apply(inf_monetary_9_i, 1, function(x) quantile(x, 0.68)),
  p32_inf_i = apply(inf_monetary_9_i, 1, function(x) quantile(x, 0.32)),
  p50_e_sent = apply(e_sentiment_9_i, 1, median),
  p68_e_sent = apply(e_sentiment_9_i, 1, function(x) quantile(x, 0.68)),
  p32_e_sent = apply(e_sentiment_9_i, 1, function(x) quantile(x, 0.32)),
  p50_e_inf = apply(e_inflation_9_i, 1, median),
  p68_e_inf = apply(e_inflation_9_i, 1, function(x) quantile(x, 0.68)),
  p32_e_inf = apply(e_inflation_9_i, 1, function(x) quantile(x, 0.32)),
  p50_e_i = apply(e_monetary_9_i, 1, median),
  p68_e_i = apply(e_monetary_9_i, 1, function(x) quantile(x, 0.68)),
  p32_e_i = apply(e_monetary_9_i, 1, function(x) quantile(x, 0.32)),
  p50_s_fx = apply(s_exchange_9_i, 1, median),
  p68_s_fx = apply(s_exchange_9_i, 1, function(x) quantile(x, 0.68)),
  p32_s_fx = apply(s_exchange_9_i, 1, function(x) quantile(x, 0.32)),
  p50_s_inf = apply(s_inflation_9_i, 1, median),
  p68_s_inf = apply(s_inflation_9_i, 1, function(x) quantile(x, 0.68)),
  p32_s_inf = apply(s_inflation_9_i, 1, function(x) quantile(x, 0.32)),
  p50_s_i = apply(s_monetary_9_i, 1, median),
  p68_s_i = apply(s_monetary_9_i, 1, function(x) quantile(x, 0.68)),
  p32_s_i = apply(s_monetary_9_i, 1, function(x) quantile(x, 0.32)),
  p50_i_inf = apply(i_inflation_9_i, 1, median),
  p68_i_inf = apply(i_inflation_9_i, 1, function(x) quantile(x, 0.68)),
  p32_i_inf = apply(i_inflation_9_i, 1, function(x) quantile(x, 0.32)),
  p50_i_fx = apply(i_exchange_9_i, 1, median),
  p68_i_fx = apply(i_exchange_9_i, 1, function(x) quantile(x, 0.68)),
  p32_i_fx = apply(i_exchange_9_i, 1, function(x) quantile(x, 0.32)),
  p50_i_sent = apply(i_sentiment_9_i, 1, median),
  p68_i_sent = apply(i_sentiment_9_i, 1, function(x) quantile(x, 0.68)),
  p32_i_sent = apply(i_sentiment_9_i, 1, function(x) quantile(x, 0.32))
)
View(results_irf_9_i)
# Cumulative IRFs
results_irf_9_i_cum <- results_irf_9_i %>% mutate(across(-Day, cumsum))
View(results_irf_9_i_cum)
# export to excel
write.xlsx(results_irf_9_i, file = "results_irf_9_i.xlsx", rowNames = FALSE)
write.xlsx(results_irf_9_i_cum, file = "results_irf_9_i_cum.xlsx", rowNames = FALSE)



