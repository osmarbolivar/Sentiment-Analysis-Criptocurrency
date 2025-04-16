// A More Standard Small Open Economy DSGE Model with Two Forward-Looking Variables
// (1) y(t) forward-looking IS   (2) pi(t) forward-looking Phillips Curve
// This model is fully calibrated (no Bayesian estimation) and should satisfy
// Blanchard-Kahn conditions if parameters are in a sensible range.

//////////////////////
// 0. Variables
//////////////////////
var y pi i e s rp;           // Endogenous state variables
varexo eps_s eps_rp eps_u eps_i; // Exogenous shocks

//////////////////////
// 1. Parameters
//////////////////////
parameters beta sigma phi_pi phi_y rho_i kappa phi_e chi psi_s rho_s rho_rp;
parameters sigma_s sigma_rp sigma_u sigma_i;

//////////////////////
// 2. Calibration
//////////////////////
// Typical New Keynesian open-economy + Bolivian context
// We have TWO forward-looking variables: y(t+1) in the IS eq. and pi(t+1) in the PC.
// The model typically satisfies Blanchard-Kahn with an aggressive phi_pi > 1.

beta   = 0.997;  // monthly discount factor (~4% annual)
sigma  = 1.0;    // intertemporal elasticity
phi_pi = 1.8;    // strong inflation response in Taylor rule (1.8)
phi_y  = 0.2;    // small output response
rho_i  = 0.7;    // partial interest rate smoothing
kappa  = 0.05;   // slope of Phillips curve (sticky prices)
phi_e  = 0.2;   // exchange rate pass-through
chi    = 0.3;    // effect of sentiment on demand
psi_s  = 0.1;    // effect of sentiment on exchange rate
rho_s  = 0.6;    // persistence of sentiment shock
rho_rp = 0.5;    // persistence of risk premium shock

// Shock std devs
sigma_s = 0.5;
sigma_rp= 0.4;
sigma_u = 0.3;
sigma_i = 0.2;

//////////////////////
// 3. Model Equations
//////////////////////
model(linear);

  // (1) Forward-Looking IS:
  //   y_t = E_t[y_{t+1}] - (1/sigma)*(i_t - E_t[pi_{t+1}]) - chi*s_t
  //   capturing open-economy demand + sentiment channel.
  y = y(+1) - (1/sigma)*( i - pi(+1) ) - chi*s;

  // (2) New Keynesian Phillips Curve (no lagged inflation)
  //   pi_t = beta*E_t[pi_{t+1}] + kappa*y_t + phi_e*( e_t - e_{t-1} ) + eps_u
  pi = beta*pi(+1) + kappa*y + phi_e*( e - e(-1) ) + eps_u;

  // (3) Monetary Policy Rule (Taylor)
  //   i_t = rho_i * i_{t-1} + (1-rho_i)*( phi_pi*pi_t + phi_y*y_t ) + eps_i
  i = rho_i*i(-1) + (1 - rho_i)*( phi_pi*pi + phi_y*y ) + eps_i;

  // (4) Exchange Rate: a simple random-walk with i & sentiment
  //   e_t = e_{t-1} + i_t + psi_s*s_t + rp_t
  //   ignoring foreign i*. This backward-looking eq ensures we don't add more forward states.
  e = e(-1) + i + psi_s*s + rp;

  // (5) Sentiment AR(1)
  s = rho_s*s(-1) + eps_s;

  // (6) Risk Premium AR(1)
  rp = rho_rp*rp(-1) + eps_rp;

end;

//////////////////////
// 4. Shocks
//////////////////////
shocks;
  var eps_s;  stderr sigma_s; // Sentiment shock: fluctuations in economic uncertainty
  var eps_rp; stderr sigma_rp; // Risk premium shock: unexpected shifts in the currency risk premium
  var eps_u;  stderr sigma_u;  // Cost-push shock: markup or supply-driven price shocks
  var eps_i;  stderr sigma_i;  // Monetary policy shock: unanticipated policy stance changes
end;

//////////////////////
// 5. Steady State & Checks
//////////////////////
initval;
  y  = 0;
  pi = 0;
  i  = 0;
  e  = 0;
  s  = 0;
  rp = 0;
end;

steady;
check;

//////////////////////
// 6. Simulation
//////////////////////
// No Bayesian estimation. Just stoch_simul on calibrated system.

stoch_simul(order=1, irf=24);
