// Small Open Economy DSGE with Sentiment and Sticky Expectations

var y pi i e s rp;
var pi_obs y_obs e_obs s_obs;
varexo eps_s eps_rp eps_u eps_i;

parameters beta sigma phi_pi phi_y rho_i alpha kappa phi_e chi psi_s rho_s rho_rp;
parameters sigma_s sigma_rp sigma_u sigma_i;

// 1. Calibrate fixed parameters
beta = 0.997;
sigma = 1.0;

// 2. Adjusted initial guesses for determinacy
phi_pi = 1.75;     // Increased to ensure determinacy
phi_y  = 0.1;      // Reduced slightly
rho_i  = 0.7;      // Reduced slightly to improve responsiveness
alpha  = 0.3;      // Reduced weight on lagged inflation
kappa  = 0.05;
phi_e  = 0.15;     // Slightly reduced exchange rate pass-through
chi    = 0.3;      // Reduced to stabilize sentiment effect
psi_s  = 0.15;     // Slightly reduced risk premium effect
rho_s  = 0.7;      // Reduced persistence of sentiment shock
rho_rp = 0.4;      // Reduced persistence of risk premium shock

// Standard deviation of shocks (initial guesses)
sigma_s  = 0.5;
sigma_rp = 0.5;
sigma_u  = 0.5;
sigma_i  = 0.3;

// 3. Model equations (linearized)
model(linear);
    y = 0.9*y(+1) - (1/sigma)*(i - pi(+1)) - chi*s; // Slight discounting of future output
    pi = beta*pi(+1) + alpha*pi(-1) + kappa*y + phi_e*(e - e(-1)) + eps_u;
    i = e(+1) - e + psi_s*s + rp;
    i = rho_i*i(-1) + (1 - rho_i)*(phi_pi*pi + phi_y*y) + eps_i;
    s = rho_s*s(-1) + eps_s;
    rp = rho_rp*rp(-1) + eps_rp;

    pi_obs = pi;
    y_obs  = y;
    e_obs  = e;
    s_obs  = s;
end;

// 4. Steady State
initval;
    y = 0; pi = 0; i = 0; e = 0; s = 0; rp = 0;
    pi_obs = 0; y_obs = 0; e_obs = 0; s_obs = 0;
end;
steady;
check;

// 5. Bayesian Estimation Priors
estimated_params;
    phi_pi,  gamma_pdf, 1.75, 0.2;
    phi_y,   normal_pdf, 0.1, 0.05;
    rho_i,   beta_pdf, 0.7, 0.1;
    alpha,   beta_pdf, 0.3, 0.1;
    kappa,   gamma_pdf, 0.05, 0.02;
    phi_e,   gamma_pdf, 0.15, 0.05;
    chi,     gamma_pdf, 0.3, 0.1;
    psi_s,   gamma_pdf, 0.15, 0.05;
    rho_s,   beta_pdf, 0.7, 0.1;
    rho_rp,  beta_pdf, 0.4, 0.1;

    stderr eps_s,  inv_gamma_pdf, 0.5, 2;
    stderr eps_rp, inv_gamma_pdf, 0.5, 2;
    stderr eps_u,  inv_gamma_pdf, 0.5, 2;
    stderr eps_i,  inv_gamma_pdf, 0.3, 2;
end;

// 6. Specify data and estimation
varobs pi_obs y_obs e_obs s_obs;

estimation( datafile  = 'bolivia_data.xlsx', xls_sheet = Sheet1, xls_range = B2:E37,
            nobs = 36, mode_compute=4, mode_check, mh_replic=2000, mh_jscale=0.3,
            mh_nblocks =2, graph_format=none, plot_priors=0, 
            diffuse_filter) y pi i e s rp;

stoch_simul(irf=24, order=1);
