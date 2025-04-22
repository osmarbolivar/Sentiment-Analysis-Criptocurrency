#============================================================
# Cryptocurrency Market Sentiment and Inflation Dynamics: Evidence from Bolivia
# Model: Daily‐Frequency BSVAR with Sign/Zero Restrictions
# Author: Osmar Bolivar
# Endogenous variables: s (sentiment), e (exchange), inf (inflation)
# Sample: 2023-01-01 to 2025-04-11
# 7 lags, default priors, impact-only restrictions
#============================================================

# 1. Install & load packages
# install.packages("bsvarSIGNs")    # if needed
library(bsvarSIGNs)
library(zoo)

# 2. Load and prepare the data
df <- read.csv("data_bsvar.csv", stringsAsFactors = FALSE)
names(df)[names(df) == "X"] <- "date"
df$date <- as.Date(df$date)
# Build a numeric matrix of endogenous variables (no header column)
data_mat <- as.matrix(df[, c("inf", "e", "s")])

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

# 4. Specify the BSVAR model
spec <- specify_bsvarSIGN$new(
  data        = data_mat,
  p           = 7,                          # 7 lags for weekly seasonality
  sign_irf    = sign_irf,                   # impact restrictions
  stationary  = rep(FALSE, ncol(data_mat))  # all series allowed near‐unit‐root
)

# 5. Estimate via Gibbs sampler
set.seed(123)
posterior <- estimate(
  specification = spec,
  S             = 10000,
  thin          = 1,
  show_progress = TRUE
)

# 6. Compute Impulse Response Functions (IRFs)
#    30‐day horizon, default (no standardization)
irf    <- compute_impulse_responses(posterior, horizon = 30)
# Plot IRFs for both structural shocks
plot(irf, shock = "SentimentShock",  probability = 0.68,
     main = "IRFs to Sentiment (Uncertainty) Shock")
plot(irf, shock = "ExchangeShock",   probability = 0.68,
     main = "IRFs to Exchange Rate Shock")

# 7. Forecast Error Variance Decomposition (FEVD)
fevd <- compute_variance_decompositions(posterior, horizon = 30)
plot(fevd, probability = 0.68,
     main = "FEVD: Sentiment vs. Exchange vs. Inflation Shocks")

# 8. (Optional) Historical Decompositions & Fitted Values
# hist_dec <- compute_historical_decompositions(posterior)
# fitted   <- compute_fitted_values(posterior)

# 9. Save results for later use
saveRDS(posterior, file = "bsvr_posterior.rds")
saveRDS(irf,       file = "bsvr_irfs.rds")
saveRDS(fevd,      file = "bsvr_fevd.rds")
#============================================================