// Dynare model: Small Open Economy DSGE with Sentiment and Sticky Expectations (Monthly)
var y pi i e s rp;               // Endogenous state variables
var pi_obs y_obs e_obs s_obs;    // Observed counterparts (measurement variables)
varexo eps_s eps_rp eps_u eps_i; // Exogenous shocks: sentiment, risk premium, cost-push, monetary

parameters beta sigma phi_pi phi_y rho_i alpha kappa phi_e chi psi_s rho_s rho_rp; 
parameters sigma_s sigma_rp sigma_u sigma_i;  // std dev of shocks (for priors)


// 1. Calibrate fixed parameters
beta   = 0.997;    // Monthly discount factor (approx 0.99^1/3, implying ~4% annual real rate)
sigma  = 1.0;      // CRRA (intertemporal elasticity = 1)
                   // (sigma=1 is a common assumption for log utility)
 
// 2. Initial guesses for parameters to be estimated (will be used as starting values)
phi_pi = 1.5;      // Taylor rule inflation coefficient 
phi_y  = 0.25;     // Taylor rule output coefficient 
rho_i  = 0.8;      // Interest rate smoothing (high due to quasi-peg) 
alpha  = 0.5;      // Weight on lagged inflation (sticky expectations)
kappa  = 0.05;     // Phillips curve slope (low => sticky prices)
phi_e  = 0.2;      // Exchange rate pass-through to inflation (import share ~20%)
chi    = 0.5;      // Impact of sentiment on demand (output drops % per 1 unit sentiment)
psi_s  = 0.2;      // Impact of sentiment on risk premium (depreciation per sentiment unit)
rho_s  = 0.85;     // Persistence of sentiment shock (high) 
rho_rp = 0.5;      // Persistence of risk premium shock (moderate)

// 3. Model equations (linearized)
model(linear);
  // IS Curve: y_t = E[y_{t+1}] - (1/sigma)*(i_t - E[pi_{t+1}]) - chi * s_t
  y = y(+1) - (1/sigma)*(i - pi(+1)) - chi * s;         // Aggregate demand with sentiment

  // Phillips Curve: pi_t = beta * E[pi_{t+1}] + alpha * pi_{t-1} + kappa * y_t + phi_e*(e - e(-1)) + u_t
  pi = beta * pi(+1) + alpha * pi(-1) + kappa * y + phi_e * (e - e(-1)) + eps_u;   // Hybrid NKPC

  // UIP Condition: i_t - i^*_t = E[e_{t+1} - e_t] + psi_s * s_t + rp_t
  // (Assume foreign i* = 0 in deviations)
  i = e(+1) - e + psi_s * s + rp;                          // Uncovered interest parity

  // Taylor Rule: i_t = rho_i * i_{t-1} + (1-rho_i)*(phi_pi * pi_t + phi_y * y_t) + eps_i_t
  i = rho_i * i(-1) + (1 - rho_i)*(phi_pi * pi + phi_y * y) + eps_i;    // Monetary policy rule

  // AR(1) process for sentiment: s_t = rho_s * s_{t-1} + eps_s_t
  s = rho_s * s(-1) + eps_s;                             // Sentiment (uncertainty) shock process

  // AR(1) process for risk premium: rp_t = rho_rp * rp_{t-1} + eps_rp_t
  rp = rho_rp * rp(-1) + eps_rp;                         // Risk premium shock process

  // Observation equations: map model variables to observed data
  pi_obs = pi;     // Observed inflation (percent, demeaned) corresponds to model inflation
  y_obs  = y;      // Observed output gap or growth corresponds to model output gap
  e_obs  = e;      // Observed exchange rate (log deviation) corresponds to model e
  s_obs  = s;      // Observed sentiment index corresponds to model sentiment state
end;

// 4. Steady state: in a linear model, steady-state values are all zero by construction (after de-meaning data).
initval;
  y = 0; pi = 0; i = 0; e = 0; s = 0; rp = 0;
  pi_obs = 0; y_obs = 0; e_obs = 0; s_obs = 0;
end;
steady;  // (Steady-state is zero-inflation, zero gap, etc.)

// 5. Priors for Bayesian estimation
estimated_params;
  // Structural parameters:
  phi_pi,  gamma_pdf, 1.5, 0.25;    // Inflation response ~ N(1.5,0.25) truncated >0
  phi_y,   normal_pdf, 0.25, 0.1;   // Output response ~ N(0.25,0.1)
  rho_i,   beta_pdf, 0.8, 0.1;      // Smoothing ~ Beta(0.8,0.1) on [0,1)
  alpha,   beta_pdf, 0.5, 0.2;      // Backward inflation weight ~ Beta(0.5,0.2)
  kappa,   gamma_pdf, 0.05, 0.03;   // Phillips slope ~ Gamma(0.05,0.03) 
  phi_e,   gamma_pdf, 0.2, 0.1;     // Exchange pass-through ~ Gamma(0.2,0.1)
  chi,     gamma_pdf, 0.5, 0.3;     // Sentiment demand effect ~ Gamma(0.5,0.3)
  psi_s,   gamma_pdf, 0.2, 0.1;     // Sentiment FX effect ~ Gamma(0.2,0.1)
  rho_s,   beta_pdf, 0.85, 0.1;     // Sentiment persistence ~ Beta(0.85,0.1)
  rho_rp,  beta_pdf, 0.5, 0.2;      // Risk premium persistence ~ Beta(0.5,0.2)

  // Shock standard deviations (std dev, in same units as variables):
  stderr eps_s,  inv_gamma_pdf, 1.0, 2.0;   // Sentiment shock ~ InvGamma (mean ~1%)
  stderr eps_rp, inv_gamma_pdf, 1.0, 2.0;   // Risk premium shock ~ InvGamma (mean ~1, implies ~1% dev in e)
  stderr eps_u,  inv_gamma_pdf, 1.0, 2.0;   // Cost-push shock ~ InvGamma (mean ~1%)
  stderr eps_i,  inv_gamma_pdf, 0.5, 2.0;   // Monetary policy shock ~ InvGamma (mean ~0.5%)
end;

// 6. Specify the data and variables to use in estimation
varobs pi_obs y_obs e_obs s_obs;   // We observe inflation, output, exchange, sentiment

// (datafile 'bolivia_data.csv' contains columns: [pi_obs, y_obs, e_obs, s_obs] from Jun-2023 to Dec-2024)
estimation(datafile="bolivia_data.csv", sheet="bolivia_data", first_obs=1, nobs=19, plot_priors=0, lik_init=2,
           mode_compute=6, mh_replic=2000, mh_burnin=500, mh_jscale=0.4, 
           nodisplay, graphs=False);

// After estimation, simulate impulse responses for key shocks of interest
stoch_simul(irf=24, order=1, series([eps_s]=1) ) y pi e;    // 2-year IRFs to a sentiment shock (eps_s)
stoch_simul(irf=24, order=1, series([eps_rp]=1) ) pi e y;   // 2-year IRFs to a risk premium (exchange rate) shock
