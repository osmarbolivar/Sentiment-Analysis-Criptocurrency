//============================================================
//  DSGE Model
//============================================================

// 1. Declaring Endogenous Variables
var x pi i e s psi; 
// x   = output gap
// pi  = inflation
// i   = nominal interest rate
// e   = parallel exchange rate (deviation from peg)
// s   = economic uncertainty sentiment
// psi = risk premium or exchange-rate shock


// 2. Declaring Exogenous Shocks
varexo eps_s eps_psi eps_u eps_i; 
// eps_s   = sentiment shock
// eps_psi = risk premium shock
// eps_u   = cost-push (markup) shock
// eps_i   = monetary policy shock


// 3. Declaring Model Parameters
parameters beta sigma phi_x phi_pi rho_i kappa phi_e phi_s gamma_s rho_s rho_psi phi;
// beta      = discount factor
// sigma     = intertemporal elasticity of substitution
// phi_x     = weight on x in the Taylor rule (policy output response)
// phi_pi    = weight on pi in the Taylor rule (policy inflation response)
// rho_i     = interest rate smoothing
// kappa     = slope of the New Keynesian Phillips curve
// phi_e     = pass-through from exchange rate changes to inflation
// phi_s     = effect of sentiment on x (IS curve)
// gamma_s   = effect of sentiment on e (exchange rate eq)
// rho_s     = persistence of sentiment AR(1)
// rho_psi   = persistence of risk premium AR(1)
// phi       = 1/sigma in the IS or can be direct sensitivity param


// 4. Calibration of Parameters
beta   = 0.997;    // monthly discount factor (~4% annual)
sigma  = 1.0;      // CRRA or 1 / Intertemporal elasticity
phi    = 1.0;      // 1/sigma if desired, or separate sensitivity
phi_x  = 0.2;      // small output weight in Taylor rule
phi_pi = 1.8;      // strong inflation response => determinacy
rho_i  = 0.7;      // partial interest-rate smoothing
kappa  = 0.06;     // slope of NKPC (sticky prices)
phi_e  = 0.15;     // pass-through from exchange rate to inflation
phi_s  = 0.3;      // effect of sentiment on x (IS curve)
gamma_s= 0.1;      // effect of sentiment on e
rho_s  = 0.6;      // AR(1) persistence for sentiment
rho_psi= 0.5;      // AR(1) persistence for risk premium

// 5. Model Equations (Linearized)
model(linear);

  // (1) Forward-Looking IS Equation:
  // x_t = E_t[x_{t+1}] - (1/sigma)*(i_t - E_t[pi_{t+1}]) - phi_s*s_t
  x = x(+1) - phi*( i - pi(+1) ) - phi_s*s;

  // (2) New Keynesian Phillips Curve:
  // pi_t = beta*pi_{t+1} + kappa*x_t + phi_e*(e_t - e_{t-1}) + eps_u
  pi = beta*pi(+1) + kappa*x + phi_e*( e - e(-1) ) + eps_u;

  // (3) Monetary Policy Rule (Taylor):
  // i_t = rho_i * i_{t-1} + (1-rho_i)*( phi_pi*pi_t + phi_x*x_t ) + eps_i
  i = rho_i*i(-1) + (1 - rho_i)*( phi_pi*pi + phi_x*x ) + eps_i;

  // (4) Exchange Rate Determination:
  // e_t = e_{t-1} + gamma_s*s_t + psi_t
  e = e(-1) + gamma_s*s + psi;

  // (5) Sentiment AR(1):
  // s_t = rho_s*s_{t-1} + eps_s
  s = rho_s*s(-1) + eps_s;

  // (6) Risk Premium AR(1):
  // psi_t = rho_psi*psi_{t-1} + eps_psi
  psi = rho_psi*psi(-1) + eps_psi;

end;


// 6. Exogenous Shock Variances
shocks;
  var eps_s;   stderr 0.5; // Sentiment shock
  var eps_psi; stderr 0.4; // Risk premium shock
  var eps_u;   stderr 0.3; // Cost-push shock
  var eps_i;   stderr 0.2; // Monetary policy shock
end;


// 7. Steady State & Checks
initval;
  x   = 0;
  pi  = 0;
  i   = 0;
  e   = 0;
  s   = 0;
  psi = 0;
end;

steady;
check;

// 8. Simulation (No Bayesian Estimation)
stoch_simul(order=1, irf=24);
