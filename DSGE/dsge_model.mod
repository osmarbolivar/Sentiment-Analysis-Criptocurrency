//============================================================
//  DSGE Model with Hybrid Phillips Curve (Calibrated for Bolivia)
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
parameters 
  beta sigma phi_x phi_pi rho_i kappa phi_e phi_s 
  gamma_s rho_s rho_psi phi gamma_f gamma_b rho_x;    
// gamma_f = weight on forward-looking inflation in hybrid NKPC
// gamma_b = weight on backward-looking inflation in hybrid NKPC
// rho_x   = persistence of the output gap

// 4. Calibration of Parameters (Monthly, Bolivia & Emerging Markets)
beta    = 0.997;      // monthly discount factor (~4% annual) 
sigma   = 2.2249;     // CRRA elasticity (Valdivia 2016) ok
phi     = 1/sigma;    // sensitivity to real interest rate ok
phi_x   = 6.9070;     // Taylor rule output response (Valdivia & Montenegro, 2009) ok
phi_pi  = 1.25;     // Taylor rule inflation response (Valdivia & Montenegro, 2009) ok
rho_i   = 0.8458;       // interest-rate smoothing (Mendieta, 2010)
kappa   = 0.242;      // NKPC slope (Mendieta, 2010)
phi_e   = 0.193;      // exchange-rate passthrough to inflation Mendieta, 2010)
phi_s   = 0.0737;       // sentiment effect on output (para que calce con la correlación)
gamma_s = 0.10;       // sentiment effect on exchange rate (Valdivia, 2016)
rho_s   = 0.60;       // persistence of sentiment AR(1) estimado
rho_psi = 0.50;       // persistence of risk premium AR(1) (Sánchez et al., 2023)
gamma_f = 0.4966;     // forward weight in hybrid NKPC (Valdivia & Montenegro, 2009)
gamma_b = 0.4581;     // backward weight in hybrid NKPC (Valdivia & Montenegro, 2009)
rho_x   = 0.5141;        // persistence of output gap (Mendieta, 2010)


// 5. Model Equations (Linearized)
model(linear);

  // (1) Forward-Looking & Persistent IS Equation
  x = rho_x * x(-1) + (1 - rho_x) * x(+1) - phi * ( i - pi(+1) ) - phi_s * s;

  // (2) Hybrid New Keynesian Phillips Curve
  pi = gamma_f * beta * pi(+1) + gamma_b * pi(-1) + kappa * x + phi_e * ( e - e(-1) ) + eps_u;

  // (3) Monetary Policy Rule (Taylor)
  i = rho_i * i(-1) + (1 - rho_i) * ( phi_pi * pi + phi_x * x ) + eps_i;

  // (4) Exchange Rate Determination
  e = e(-1) + gamma_s * s + psi;

  // (5) Sentiment AR(1)
  s = rho_s * s(-1) + eps_s;

  // (6) Risk Premium AR(1)
  psi = rho_psi * psi(-1) + eps_psi;

end;

// 6. Exogenous Shock Variances
shocks;
  var eps_s;   stderr 0.5;  // sentiment shock
  var eps_psi; stderr 0.4;  // risk premium shock
  var eps_u;   stderr 0.3;  // cost-push shock
  var eps_i;   stderr 0.2;  // monetary policy shock
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

// 8. Simulation (IRFs for 24 periods)
stoch_simul(order=1, irf=24);
