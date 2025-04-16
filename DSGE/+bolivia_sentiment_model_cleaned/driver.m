%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

clearvars -global
clear_persistent_variables(fileparts(which('dynare')), false)
tic0 = tic;
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info
options_ = [];
M_.fname = 'bolivia_sentiment_model_cleaned';
M_.dynare_version = '6.1';
oo_.dynare_version = '6.1';
options_.dynare_version = '6.1';
%
% Some global variables initialization
%
global_initialization;
M_.exo_names = cell(4,1);
M_.exo_names_tex = cell(4,1);
M_.exo_names_long = cell(4,1);
M_.exo_names(1) = {'eps_s'};
M_.exo_names_tex(1) = {'eps\_s'};
M_.exo_names_long(1) = {'eps_s'};
M_.exo_names(2) = {'eps_rp'};
M_.exo_names_tex(2) = {'eps\_rp'};
M_.exo_names_long(2) = {'eps_rp'};
M_.exo_names(3) = {'eps_u'};
M_.exo_names_tex(3) = {'eps\_u'};
M_.exo_names_long(3) = {'eps_u'};
M_.exo_names(4) = {'eps_i'};
M_.exo_names_tex(4) = {'eps\_i'};
M_.exo_names_long(4) = {'eps_i'};
M_.endo_names = cell(10,1);
M_.endo_names_tex = cell(10,1);
M_.endo_names_long = cell(10,1);
M_.endo_names(1) = {'y'};
M_.endo_names_tex(1) = {'y'};
M_.endo_names_long(1) = {'y'};
M_.endo_names(2) = {'pi'};
M_.endo_names_tex(2) = {'pi'};
M_.endo_names_long(2) = {'pi'};
M_.endo_names(3) = {'i'};
M_.endo_names_tex(3) = {'i'};
M_.endo_names_long(3) = {'i'};
M_.endo_names(4) = {'e'};
M_.endo_names_tex(4) = {'e'};
M_.endo_names_long(4) = {'e'};
M_.endo_names(5) = {'s'};
M_.endo_names_tex(5) = {'s'};
M_.endo_names_long(5) = {'s'};
M_.endo_names(6) = {'rp'};
M_.endo_names_tex(6) = {'rp'};
M_.endo_names_long(6) = {'rp'};
M_.endo_names(7) = {'pi_obs'};
M_.endo_names_tex(7) = {'pi\_obs'};
M_.endo_names_long(7) = {'pi_obs'};
M_.endo_names(8) = {'y_obs'};
M_.endo_names_tex(8) = {'y\_obs'};
M_.endo_names_long(8) = {'y_obs'};
M_.endo_names(9) = {'e_obs'};
M_.endo_names_tex(9) = {'e\_obs'};
M_.endo_names_long(9) = {'e_obs'};
M_.endo_names(10) = {'s_obs'};
M_.endo_names_tex(10) = {'s\_obs'};
M_.endo_names_long(10) = {'s_obs'};
M_.endo_partitions = struct();
M_.param_names = cell(16,1);
M_.param_names_tex = cell(16,1);
M_.param_names_long = cell(16,1);
M_.param_names(1) = {'beta'};
M_.param_names_tex(1) = {'beta'};
M_.param_names_long(1) = {'beta'};
M_.param_names(2) = {'sigma'};
M_.param_names_tex(2) = {'sigma'};
M_.param_names_long(2) = {'sigma'};
M_.param_names(3) = {'phi_pi'};
M_.param_names_tex(3) = {'phi\_pi'};
M_.param_names_long(3) = {'phi_pi'};
M_.param_names(4) = {'phi_y'};
M_.param_names_tex(4) = {'phi\_y'};
M_.param_names_long(4) = {'phi_y'};
M_.param_names(5) = {'rho_i'};
M_.param_names_tex(5) = {'rho\_i'};
M_.param_names_long(5) = {'rho_i'};
M_.param_names(6) = {'alpha'};
M_.param_names_tex(6) = {'alpha'};
M_.param_names_long(6) = {'alpha'};
M_.param_names(7) = {'kappa'};
M_.param_names_tex(7) = {'kappa'};
M_.param_names_long(7) = {'kappa'};
M_.param_names(8) = {'phi_e'};
M_.param_names_tex(8) = {'phi\_e'};
M_.param_names_long(8) = {'phi_e'};
M_.param_names(9) = {'chi'};
M_.param_names_tex(9) = {'chi'};
M_.param_names_long(9) = {'chi'};
M_.param_names(10) = {'psi_s'};
M_.param_names_tex(10) = {'psi\_s'};
M_.param_names_long(10) = {'psi_s'};
M_.param_names(11) = {'rho_s'};
M_.param_names_tex(11) = {'rho\_s'};
M_.param_names_long(11) = {'rho_s'};
M_.param_names(12) = {'rho_rp'};
M_.param_names_tex(12) = {'rho\_rp'};
M_.param_names_long(12) = {'rho_rp'};
M_.param_names(13) = {'sigma_s'};
M_.param_names_tex(13) = {'sigma\_s'};
M_.param_names_long(13) = {'sigma_s'};
M_.param_names(14) = {'sigma_rp'};
M_.param_names_tex(14) = {'sigma\_rp'};
M_.param_names_long(14) = {'sigma_rp'};
M_.param_names(15) = {'sigma_u'};
M_.param_names_tex(15) = {'sigma\_u'};
M_.param_names_long(15) = {'sigma_u'};
M_.param_names(16) = {'sigma_i'};
M_.param_names_tex(16) = {'sigma\_i'};
M_.param_names_long(16) = {'sigma_i'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 4;
M_.endo_nbr = 10;
M_.param_nbr = 16;
M_.orig_endo_nbr = 10;
M_.aux_vars = [];
options_.varobs = cell(4, 1);
options_.varobs(1)  = {'pi_obs'};
options_.varobs(2)  = {'y_obs'};
options_.varobs(3)  = {'e_obs'};
options_.varobs(4)  = {'s_obs'};
options_.varobs_id = [ 7 8 9 10  ];
M_.Sigma_e = zeros(4, 4);
M_.Correlation_matrix = eye(4, 4);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = true;
M_.det_shocks = [];
M_.surprise_shocks = [];
M_.learnt_shocks = [];
M_.learnt_endval = [];
M_.heteroskedastic_shocks.Qvalue_orig = [];
M_.heteroskedastic_shocks.Qscale_orig = [];
M_.matched_irfs = {};
M_.matched_irfs_weights = {};
options_.linear = true;
options_.block = false;
options_.bytecode = false;
options_.use_dll = false;
options_.ramsey_policy = false;
options_.discretionary_policy = false;
M_.nonzero_hessian_eqs = [];
M_.hessian_eq_zero = isempty(M_.nonzero_hessian_eqs);
M_.eq_nbr = 10;
M_.ramsey_orig_eq_nbr = 0;
M_.ramsey_orig_endo_nbr = 0;
M_.set_auxiliary_variables = exist(['./+' M_.fname '/set_auxiliary_variables.m'], 'file') == 2;
M_.epilogue_names = {};
M_.epilogue_var_list_ = {};
M_.orig_maximum_endo_lag = 1;
M_.orig_maximum_endo_lead = 1;
M_.orig_maximum_exo_lag = 0;
M_.orig_maximum_exo_lead = 0;
M_.orig_maximum_exo_det_lag = 0;
M_.orig_maximum_exo_det_lead = 0;
M_.orig_maximum_lag = 1;
M_.orig_maximum_lead = 1;
M_.orig_maximum_lag_with_diffs_expanded = 1;
M_.lead_lag_incidence = [
 0 6 16;
 1 7 17;
 2 8 0;
 3 9 18;
 4 10 0;
 5 11 0;
 0 12 0;
 0 13 0;
 0 14 0;
 0 15 0;]';
M_.nstatic = 4;
M_.nfwrd   = 1;
M_.npred   = 3;
M_.nboth   = 2;
M_.nsfwrd   = 3;
M_.nspred   = 5;
M_.ndynamic   = 6;
M_.dynamic_tmp_nbr = [0; 0; 0; 0; ];
M_.equations_tags = {
  1 , 'name' , 'y' ;
  2 , 'name' , 'pi' ;
  3 , 'name' , 'i' ;
  4 , 'name' , '4' ;
  5 , 'name' , 's' ;
  6 , 'name' , 'rp' ;
  7 , 'name' , 'pi_obs' ;
  8 , 'name' , 'y_obs' ;
  9 , 'name' , 'e_obs' ;
  10 , 'name' , 's_obs' ;
};
M_.mapping.y.eqidx = [1 2 4 8 ];
M_.mapping.pi.eqidx = [1 2 4 7 ];
M_.mapping.i.eqidx = [1 3 4 ];
M_.mapping.e.eqidx = [2 3 9 ];
M_.mapping.s.eqidx = [1 3 5 10 ];
M_.mapping.rp.eqidx = [3 6 ];
M_.mapping.pi_obs.eqidx = [7 ];
M_.mapping.y_obs.eqidx = [8 ];
M_.mapping.e_obs.eqidx = [9 ];
M_.mapping.s_obs.eqidx = [10 ];
M_.mapping.eps_s.eqidx = [5 ];
M_.mapping.eps_rp.eqidx = [6 ];
M_.mapping.eps_u.eqidx = [2 ];
M_.mapping.eps_i.eqidx = [4 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.block_structure.time_recursive = false;
M_.block_structure.block(1).Simulation_Type = 1;
M_.block_structure.block(1).endo_nbr = 3;
M_.block_structure.block(1).mfs = 3;
M_.block_structure.block(1).equation = [ 5 6 10];
M_.block_structure.block(1).variable = [ 5 6 10];
M_.block_structure.block(1).is_linear = true;
M_.block_structure.block(1).NNZDerivatives = 6;
M_.block_structure.block(1).bytecode_jacob_cols_to_sparse = [1 2 4 5 6 ];
M_.block_structure.block(2).Simulation_Type = 8;
M_.block_structure.block(2).endo_nbr = 4;
M_.block_structure.block(2).mfs = 4;
M_.block_structure.block(2).equation = [ 4 2 3 1];
M_.block_structure.block(2).variable = [ 3 2 4 1];
M_.block_structure.block(2).is_linear = true;
M_.block_structure.block(2).NNZDerivatives = 17;
M_.block_structure.block(2).bytecode_jacob_cols_to_sparse = [1 2 3 5 6 7 8 10 11 12 ];
M_.block_structure.block(3).Simulation_Type = 1;
M_.block_structure.block(3).endo_nbr = 3;
M_.block_structure.block(3).mfs = 3;
M_.block_structure.block(3).equation = [ 9 8 7];
M_.block_structure.block(3).variable = [ 9 8 7];
M_.block_structure.block(3).is_linear = true;
M_.block_structure.block(3).NNZDerivatives = 3;
M_.block_structure.block(3).bytecode_jacob_cols_to_sparse = [4 5 6 ];
M_.block_structure.block(1).g1_sparse_rowval = int32([]);
M_.block_structure.block(1).g1_sparse_colval = int32([]);
M_.block_structure.block(1).g1_sparse_colptr = int32([]);
M_.block_structure.block(2).g1_sparse_rowval = int32([1 2 2 1 3 4 1 2 2 3 1 2 4 2 4 3 4 ]);
M_.block_structure.block(2).g1_sparse_colval = int32([1 2 3 5 5 5 6 6 7 7 8 8 8 10 10 11 12 ]);
M_.block_structure.block(2).g1_sparse_colptr = int32([1 2 3 4 4 7 9 11 14 14 16 17 18 ]);
M_.block_structure.block(3).g1_sparse_rowval = int32([]);
M_.block_structure.block(3).g1_sparse_colval = int32([]);
M_.block_structure.block(3).g1_sparse_colptr = int32([]);
M_.block_structure.variable_reordered = [ 5 6 10 3 2 4 1 9 8 7];
M_.block_structure.equation_reordered = [ 5 6 10 4 2 3 1 9 8 7];
M_.block_structure.incidence(1).lead_lag = -1;
M_.block_structure.incidence(1).sparse_IM = [
 2 2;
 2 4;
 4 3;
 5 5;
 6 6;
];
M_.block_structure.incidence(2).lead_lag = 0;
M_.block_structure.incidence(2).sparse_IM = [
 1 1;
 1 3;
 1 5;
 2 1;
 2 2;
 2 4;
 3 3;
 3 4;
 3 5;
 3 6;
 4 1;
 4 2;
 4 3;
 5 5;
 6 6;
 7 2;
 7 7;
 8 1;
 8 8;
 9 4;
 9 9;
 10 5;
 10 10;
];
M_.block_structure.incidence(3).lead_lag = 1;
M_.block_structure.incidence(3).sparse_IM = [
 1 1;
 1 2;
 2 2;
 3 4;
];
M_.block_structure.dyn_tmp_nbr = 0;
M_.state_var = [5 6 3 2 4 ];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(10, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(4, 1);
M_.params = NaN(16, 1);
M_.endo_trends = struct('deflator', cell(10, 1), 'log_deflator', cell(10, 1), 'growth_factor', cell(10, 1), 'log_growth_factor', cell(10, 1));
M_.NNZDerivatives = [36; 0; -1; ];
M_.dynamic_g1_sparse_rowval = int32([2 4 2 5 6 1 2 4 8 2 4 7 1 3 4 2 3 9 1 3 5 10 3 6 7 8 9 10 1 1 2 3 5 6 2 4 ]);
M_.dynamic_g1_sparse_colval = int32([2 3 4 5 6 11 11 11 11 12 12 12 13 13 13 14 14 14 15 15 15 15 16 16 17 18 19 20 21 22 22 24 31 32 33 34 ]);
M_.dynamic_g1_sparse_colptr = int32([1 1 2 3 4 5 6 6 6 6 6 10 13 16 19 23 25 26 27 28 29 30 32 32 33 33 33 33 33 33 33 34 35 36 37 ]);
M_.dynamic_g2_sparse_indices = int32([]);
M_.lhs = {
'y'; 
'pi'; 
'i'; 
'i'; 
's'; 
'rp'; 
'pi_obs'; 
'y_obs'; 
'e_obs'; 
's_obs'; 
};
M_.static_tmp_nbr = [0; 0; 0; 0; ];
M_.static_g1_sparse_rowval = int32([1 2 4 8 1 2 4 7 1 3 4 9 1 3 5 10 3 6 7 8 9 10 ]);
M_.static_g1_sparse_colval = int32([1 1 1 1 2 2 2 2 3 3 3 4 5 5 5 5 6 6 7 8 9 10 ]);
M_.static_g1_sparse_colptr = int32([1 5 9 12 13 17 19 20 21 22 23 ]);
M_.params(1) = 0.997;
beta = M_.params(1);
M_.params(2) = 1.0;
sigma = M_.params(2);
M_.params(3) = 1.75;
phi_pi = M_.params(3);
M_.params(4) = 0.1;
phi_y = M_.params(4);
M_.params(5) = 0.7;
rho_i = M_.params(5);
M_.params(6) = 0.3;
alpha = M_.params(6);
M_.params(7) = 0.05;
kappa = M_.params(7);
M_.params(8) = 0.15;
phi_e = M_.params(8);
M_.params(9) = 0.3;
chi = M_.params(9);
M_.params(10) = 0.15;
psi_s = M_.params(10);
M_.params(11) = 0.7;
rho_s = M_.params(11);
M_.params(12) = 0.4;
rho_rp = M_.params(12);
M_.params(13) = 0.5;
sigma_s = M_.params(13);
M_.params(14) = 0.5;
sigma_rp = M_.params(14);
M_.params(15) = 0.5;
sigma_u = M_.params(15);
M_.params(16) = 0.3;
sigma_i = M_.params(16);
%
% INITVAL instructions
%
options_.initval_file = false;
oo_.steady_state(1) = 0;
oo_.steady_state(2) = 0;
oo_.steady_state(3) = 0;
oo_.steady_state(4) = 0;
oo_.steady_state(5) = 0;
oo_.steady_state(6) = 0;
oo_.steady_state(7) = 0;
oo_.steady_state(8) = 0;
oo_.steady_state(9) = 0;
oo_.steady_state(10) = 0;
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
steady;
oo_.dr.eigval = check(M_,options_,oo_);
if isempty(estim_params_)
    estim_params_.var_exo = zeros(0, 10);
    estim_params_.var_endo = zeros(0, 10);
    estim_params_.corrx = zeros(0, 11);
    estim_params_.corrn = zeros(0, 11);
    estim_params_.param_vals = zeros(0, 10);
end
if ~isempty(find(estim_params_.param_vals(:,1)==3))
    error('Parameter phi_pi has been specified twice in two concatenated ''estimated_params'' blocks. Depending on your intention, you may want to use the ''overwrite'' option or an ''estimated_params_remove'' block.')
end
estim_params_.param_vals = [estim_params_.param_vals; 3, NaN, (-Inf), Inf, 2, 1.75, 0.2, NaN, NaN, NaN ];
if ~isempty(find(estim_params_.param_vals(:,1)==4))
    error('Parameter phi_y has been specified twice in two concatenated ''estimated_params'' blocks. Depending on your intention, you may want to use the ''overwrite'' option or an ''estimated_params_remove'' block.')
end
estim_params_.param_vals = [estim_params_.param_vals; 4, NaN, (-Inf), Inf, 3, 0.1, 0.05, NaN, NaN, NaN ];
if ~isempty(find(estim_params_.param_vals(:,1)==5))
    error('Parameter rho_i has been specified twice in two concatenated ''estimated_params'' blocks. Depending on your intention, you may want to use the ''overwrite'' option or an ''estimated_params_remove'' block.')
end
estim_params_.param_vals = [estim_params_.param_vals; 5, NaN, (-Inf), Inf, 1, 0.7, 0.1, NaN, NaN, NaN ];
if ~isempty(find(estim_params_.param_vals(:,1)==6))
    error('Parameter alpha has been specified twice in two concatenated ''estimated_params'' blocks. Depending on your intention, you may want to use the ''overwrite'' option or an ''estimated_params_remove'' block.')
end
estim_params_.param_vals = [estim_params_.param_vals; 6, NaN, (-Inf), Inf, 1, 0.3, 0.1, NaN, NaN, NaN ];
if ~isempty(find(estim_params_.param_vals(:,1)==7))
    error('Parameter kappa has been specified twice in two concatenated ''estimated_params'' blocks. Depending on your intention, you may want to use the ''overwrite'' option or an ''estimated_params_remove'' block.')
end
estim_params_.param_vals = [estim_params_.param_vals; 7, NaN, (-Inf), Inf, 2, 0.05, 0.02, NaN, NaN, NaN ];
if ~isempty(find(estim_params_.param_vals(:,1)==8))
    error('Parameter phi_e has been specified twice in two concatenated ''estimated_params'' blocks. Depending on your intention, you may want to use the ''overwrite'' option or an ''estimated_params_remove'' block.')
end
estim_params_.param_vals = [estim_params_.param_vals; 8, NaN, (-Inf), Inf, 2, 0.15, 0.05, NaN, NaN, NaN ];
if ~isempty(find(estim_params_.param_vals(:,1)==9))
    error('Parameter chi has been specified twice in two concatenated ''estimated_params'' blocks. Depending on your intention, you may want to use the ''overwrite'' option or an ''estimated_params_remove'' block.')
end
estim_params_.param_vals = [estim_params_.param_vals; 9, NaN, (-Inf), Inf, 2, 0.3, 0.1, NaN, NaN, NaN ];
if ~isempty(find(estim_params_.param_vals(:,1)==10))
    error('Parameter psi_s has been specified twice in two concatenated ''estimated_params'' blocks. Depending on your intention, you may want to use the ''overwrite'' option or an ''estimated_params_remove'' block.')
end
estim_params_.param_vals = [estim_params_.param_vals; 10, NaN, (-Inf), Inf, 2, 0.15, 0.05, NaN, NaN, NaN ];
if ~isempty(find(estim_params_.param_vals(:,1)==11))
    error('Parameter rho_s has been specified twice in two concatenated ''estimated_params'' blocks. Depending on your intention, you may want to use the ''overwrite'' option or an ''estimated_params_remove'' block.')
end
estim_params_.param_vals = [estim_params_.param_vals; 11, NaN, (-Inf), Inf, 1, 0.7, 0.1, NaN, NaN, NaN ];
if ~isempty(find(estim_params_.param_vals(:,1)==12))
    error('Parameter rho_rp has been specified twice in two concatenated ''estimated_params'' blocks. Depending on your intention, you may want to use the ''overwrite'' option or an ''estimated_params_remove'' block.')
end
estim_params_.param_vals = [estim_params_.param_vals; 12, NaN, (-Inf), Inf, 1, 0.4, 0.1, NaN, NaN, NaN ];
if ~isempty(find(estim_params_.var_exo(:,1)==1))
    error('The standard deviation for eps_s has been specified twice in two concatenated ''estimated_params'' blocks. Depending on your intention, you may want to use the ''overwrite'' option or an ''estimated_params_remove'' block.')
end
estim_params_.var_exo = [estim_params_.var_exo; 1, NaN, (-Inf), Inf, 4, 0.5, 2, NaN, NaN, NaN ];
if ~isempty(find(estim_params_.var_exo(:,1)==2))
    error('The standard deviation for eps_rp has been specified twice in two concatenated ''estimated_params'' blocks. Depending on your intention, you may want to use the ''overwrite'' option or an ''estimated_params_remove'' block.')
end
estim_params_.var_exo = [estim_params_.var_exo; 2, NaN, (-Inf), Inf, 4, 0.5, 2, NaN, NaN, NaN ];
if ~isempty(find(estim_params_.var_exo(:,1)==3))
    error('The standard deviation for eps_u has been specified twice in two concatenated ''estimated_params'' blocks. Depending on your intention, you may want to use the ''overwrite'' option or an ''estimated_params_remove'' block.')
end
estim_params_.var_exo = [estim_params_.var_exo; 3, NaN, (-Inf), Inf, 4, 0.5, 2, NaN, NaN, NaN ];
if ~isempty(find(estim_params_.var_exo(:,1)==4))
    error('The standard deviation for eps_i has been specified twice in two concatenated ''estimated_params'' blocks. Depending on your intention, you may want to use the ''overwrite'' option or an ''estimated_params_remove'' block.')
end
estim_params_.var_exo = [estim_params_.var_exo; 4, NaN, (-Inf), Inf, 4, 0.3, 2, NaN, NaN, NaN ];
options_.datafile = 'bolivia_data.xlsx';
options_.diffuse_filter = true;
options_.graph_format = {'none'};
options_.mh_jscale = 0.3;
options_.mh_nblck = 2;
options_.mh_replic = 2000;
options_.mode_check.status = true;
options_.mode_compute = 4;
options_.nobs = 36;
options_.plot_priors = 0;
options_.xls_range = 'B2:E37';
options_.xls_sheet = 'Sheet1';
options_.order = 1;
options_.steadystate.nocheck = true;
var_list_ = {'y';'pi';'i';'e';'s';'rp'};
oo_recursive_=dynare_estimation(var_list_);
options_.irf = 24;
options_.order = 1;
var_list_ = {};
[info, oo_, options_, M_] = stoch_simul(M_, options_, oo_, var_list_);


oo_.time = toc(tic0);
disp(['Total computing time : ' dynsec2hms(oo_.time) ]);
if ~exist([M_.dname filesep 'Output'],'dir')
    mkdir(M_.dname,'Output');
end
save([M_.dname filesep 'Output' filesep 'bolivia_sentiment_model_cleaned_results.mat'], 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bolivia_sentiment_model_cleaned_results.mat'], 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bolivia_sentiment_model_cleaned_results.mat'], 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bolivia_sentiment_model_cleaned_results.mat'], 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bolivia_sentiment_model_cleaned_results.mat'], 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bolivia_sentiment_model_cleaned_results.mat'], 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bolivia_sentiment_model_cleaned_results.mat'], 'oo_recursive_', '-append');
end
if exist('options_mom_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bolivia_sentiment_model_cleaned_results.mat'], 'options_mom_', '-append');
end
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
