

# Pseudocode for sign/zero restriction matrix construction
sign_irf <- matrix(NA, nrow=3, ncol=3)
rownames(sign_irf) <- c("sentiment","exchange","inflation")
colnames(sign_irf) <- c("SentimentShock","ExchangeShock","InflationShock")
# Sentiment shock: exchange positive, (sentiment positive), inflation unrestricted
sign_irf["exchange","SentimentShock"]   <- 1    # + sign on exchange
sign_irf["sentiment","SentimentShock"]  <- 1    # + sign on sentiment itself (optional, to set shock = increase in uncertainty)
# (inflation remains NA for SentimentShock = unrestricted)
# Exchange rate shock: sentiment zero, exchange positive, inflation positive
sign_irf["sentiment","ExchangeShock"]   <- 0    # 0 restriction (no impact on sentiment)
sign_irf["exchange","ExchangeShock"]    <- 1    # + sign on exchange
sign_irf["inflation","ExchangeShock"]   <- 1    # + sign on inflation
# Inflation shock: sentiment zero, exchange zero, (inflation free or positive)
sign_irf["sentiment","InflationShock"]  <- 0    # 0 restriction on sentiment
sign_irf["exchange","InflationShock"]   <- 0    # 0 restriction on exchange
# (inflation can be NA or 1 if we want to specifically identify a positive inflation shock)



