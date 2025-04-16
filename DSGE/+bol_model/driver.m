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
M_.fname = 'bol_model';
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
M_.endo_names = cell(6,1);
M_.endo_names_tex = cell(6,1);
M_.endo_names_long = cell(6,1);
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
M_.endo_partitions = struct();
M_.param_names = cell(15,1);
M_.param_names_tex = cell(15,1);
M_.param_names_long = cell(15,1);
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
M_.param_names(6) = {'kappa'};
M_.param_names_tex(6) = {'kappa'};
M_.param_names_long(6) = {'kappa'};
M_.param_names(7) = {'phi_e'};
M_.param_names_tex(7) = {'phi\_e'};
M_.param_names_long(7) = {'phi_e'};
M_.param_names(8) = {'chi'};
M_.param_names_tex(8) = {'chi'};
M_.param_names_long(8) = {'chi'};
M_.param_names(9) = {'psi_s'};
M_.param_names_tex(9) = {'psi\_s'};
M_.param_names_long(9) = {'psi_s'};
M_.param_names(10) = {'rho_s'};
M_.param_names_tex(10) = {'rho\_s'};
M_.param_names_long(10) = {'rho_s'};
M_.param_names(11) = {'rho_rp'};
M_.param_names_tex(11) = {'rho\_rp'};
M_.param_names_long(11) = {'rho_rp'};
M_.param_names(12) = {'sigma_s'};
M_.param_names_tex(12) = {'sigma\_s'};
M_.param_names_long(12) = {'sigma_s'};
M_.param_names(13) = {'sigma_rp'};
M_.param_names_tex(13) = {'sigma\_rp'};
M_.param_names_long(13) = {'sigma_rp'};
M_.param_names(14) = {'sigma_u'};
M_.param_names_tex(14) = {'sigma\_u'};
M_.param_names_long(14) = {'sigma_u'};
M_.param_names(15) = {'sigma_i'};
M_.param_names_tex(15) = {'sigma\_i'};
M_.param_names_long(15) = {'sigma_i'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 4;
M_.endo_nbr = 6;
M_.param_nbr = 15;
M_.orig_endo_nbr = 6;
M_.aux_vars = [];
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
M_.eq_nbr = 6;
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
 0 5 11;
 0 6 12;
 1 7 0;
 2 8 0;
 3 9 0;
 4 10 0;]';
M_.nstatic = 0;
M_.nfwrd   = 2;
M_.npred   = 4;
M_.nboth   = 0;
M_.nsfwrd   = 2;
M_.nspred   = 4;
M_.ndynamic   = 6;
M_.dynamic_tmp_nbr = [0; 0; 0; 0; ];
M_.equations_tags = {
  1 , 'name' , 'y' ;
  2 , 'name' , 'pi' ;
  3 , 'name' , 'i' ;
  4 , 'name' , 'e' ;
  5 , 'name' , 's' ;
  6 , 'name' , 'rp' ;
};
M_.mapping.y.eqidx = [1 2 3 ];
M_.mapping.pi.eqidx = [1 2 3 ];
M_.mapping.i.eqidx = [1 3 4 ];
M_.mapping.e.eqidx = [2 4 ];
M_.mapping.s.eqidx = [1 4 5 ];
M_.mapping.rp.eqidx = [4 6 ];
M_.mapping.eps_s.eqidx = [5 ];
M_.mapping.eps_rp.eqidx = [6 ];
M_.mapping.eps_u.eqidx = [2 ];
M_.mapping.eps_i.eqidx = [3 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.block_structure.time_recursive = false;
M_.block_structure.block(1).Simulation_Type = 1;
M_.block_structure.block(1).endo_nbr = 2;
M_.block_structure.block(1).mfs = 2;
M_.block_structure.block(1).equation = [ 5 6];
M_.block_structure.block(1).variable = [ 5 6];
M_.block_structure.block(1).is_linear = true;
M_.block_structure.block(1).NNZDerivatives = 4;
M_.block_structure.block(1).bytecode_jacob_cols_to_sparse = [1 2 3 4 ];
M_.block_structure.block(2).Simulation_Type = 8;
M_.block_structure.block(2).endo_nbr = 4;
M_.block_structure.block(2).mfs = 4;
M_.block_structure.block(2).equation = [ 3 4 1 2];
M_.block_structure.block(2).variable = [ 3 4 1 2];
M_.block_structure.block(2).is_linear = true;
M_.block_structure.block(2).NNZDerivatives = 16;
M_.block_structure.block(2).bytecode_jacob_cols_to_sparse = [1 2 5 6 7 8 11 12 ];
M_.block_structure.block(1).g1_sparse_rowval = int32([]);
M_.block_structure.block(1).g1_sparse_colval = int32([]);
M_.block_structure.block(1).g1_sparse_colptr = int32([]);
M_.block_structure.block(2).g1_sparse_rowval = int32([1 2 4 1 2 3 2 4 1 3 4 1 4 3 3 4 ]);
M_.block_structure.block(2).g1_sparse_colval = int32([1 2 2 5 5 5 6 6 7 7 7 8 8 11 12 12 ]);
M_.block_structure.block(2).g1_sparse_colptr = int32([1 2 4 4 4 7 9 12 14 14 14 15 17 ]);
M_.block_structure.variable_reordered = [ 5 6 3 4 1 2];
M_.block_structure.equation_reordered = [ 5 6 3 4 1 2];
M_.block_structure.incidence(1).lead_lag = -1;
M_.block_structure.incidence(1).sparse_IM = [
 2 4;
 3 3;
 4 4;
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
 3 1;
 3 2;
 3 3;
 4 3;
 4 4;
 4 5;
 4 6;
 5 5;
 6 6;
];
M_.block_structure.incidence(3).lead_lag = 1;
M_.block_structure.incidence(3).sparse_IM = [
 1 1;
 1 2;
 2 2;
];
M_.block_structure.dyn_tmp_nbr = 0;
M_.state_var = [5 6 3 4 ];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(6, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(4, 1);
M_.params = NaN(15, 1);
M_.endo_trends = struct('deflator', cell(6, 1), 'log_deflator', cell(6, 1), 'growth_factor', cell(6, 1), 'log_growth_factor', cell(6, 1));
M_.NNZDerivatives = [27; 0; -1; ];
M_.dynamic_g1_sparse_rowval = int32([3 2 4 5 6 1 2 3 2 3 1 3 4 2 4 1 4 5 4 6 1 1 2 5 6 2 3 ]);
M_.dynamic_g1_sparse_colval = int32([3 4 4 5 6 7 7 7 8 8 9 9 9 10 10 11 11 11 12 12 13 14 14 19 20 21 22 ]);
M_.dynamic_g1_sparse_colptr = int32([1 1 1 2 4 5 6 9 11 14 16 19 21 22 24 24 24 24 24 25 26 27 28 ]);
M_.dynamic_g2_sparse_indices = int32([]);
M_.lhs = {
'y'; 
'pi'; 
'i'; 
'e'; 
's'; 
'rp'; 
};
M_.static_tmp_nbr = [0; 0; 0; 0; ];
M_.block_structure_stat.block(1).Simulation_Type = 3;
M_.block_structure_stat.block(1).endo_nbr = 1;
M_.block_structure_stat.block(1).mfs = 1;
M_.block_structure_stat.block(1).equation = [ 5];
M_.block_structure_stat.block(1).variable = [ 5];
M_.block_structure_stat.block(2).Simulation_Type = 3;
M_.block_structure_stat.block(2).endo_nbr = 1;
M_.block_structure_stat.block(2).mfs = 1;
M_.block_structure_stat.block(2).equation = [ 6];
M_.block_structure_stat.block(2).variable = [ 6];
M_.block_structure_stat.block(3).Simulation_Type = 6;
M_.block_structure_stat.block(3).endo_nbr = 3;
M_.block_structure_stat.block(3).mfs = 3;
M_.block_structure_stat.block(3).equation = [ 3 2 1];
M_.block_structure_stat.block(3).variable = [ 3 2 1];
M_.block_structure_stat.block(4).Simulation_Type = 3;
M_.block_structure_stat.block(4).endo_nbr = 1;
M_.block_structure_stat.block(4).mfs = 1;
M_.block_structure_stat.block(4).equation = [ 4];
M_.block_structure_stat.block(4).variable = [ 4];
M_.block_structure_stat.variable_reordered = [ 5 6 3 2 1 4];
M_.block_structure_stat.equation_reordered = [ 5 6 3 2 1 4];
M_.block_structure_stat.incidence.sparse_IM = [
 1 2;
 1 3;
 1 5;
 2 1;
 2 2;
 3 1;
 3 2;
 3 3;
 4 3;
 4 5;
 4 6;
 5 5;
 6 6;
];
M_.block_structure_stat.tmp_nbr = 0;
M_.block_structure_stat.block(1).g1_sparse_rowval = int32([1 ]);
M_.block_structure_stat.block(1).g1_sparse_colval = int32([1 ]);
M_.block_structure_stat.block(1).g1_sparse_colptr = int32([1 2 ]);
M_.block_structure_stat.block(2).g1_sparse_rowval = int32([1 ]);
M_.block_structure_stat.block(2).g1_sparse_colval = int32([1 ]);
M_.block_structure_stat.block(2).g1_sparse_colptr = int32([1 2 ]);
M_.block_structure_stat.block(3).g1_sparse_rowval = int32([1 3 1 2 3 1 2 ]);
M_.block_structure_stat.block(3).g1_sparse_colval = int32([1 1 2 2 2 3 3 ]);
M_.block_structure_stat.block(3).g1_sparse_colptr = int32([1 3 6 8 ]);
M_.block_structure_stat.block(4).g1_sparse_rowval = int32([]);
M_.block_structure_stat.block(4).g1_sparse_colval = int32([]);
M_.block_structure_stat.block(4).g1_sparse_colptr = int32([1 1 ]);
M_.static_g1_sparse_rowval = int32([2 3 1 2 3 1 3 4 1 4 5 4 6 ]);
M_.static_g1_sparse_colval = int32([1 1 2 2 2 3 3 3 5 5 5 6 6 ]);
M_.static_g1_sparse_colptr = int32([1 3 6 9 9 12 14 ]);
M_.params(1) = 0.997;
beta = M_.params(1);
M_.params(2) = 1.0;
sigma = M_.params(2);
M_.params(3) = 1.8;
phi_pi = M_.params(3);
M_.params(4) = 0.2;
phi_y = M_.params(4);
M_.params(5) = 0.7;
rho_i = M_.params(5);
M_.params(6) = 0.05;
kappa = M_.params(6);
M_.params(7) = 0.2;
phi_e = M_.params(7);
M_.params(8) = 0.3;
chi = M_.params(8);
M_.params(9) = 0.1;
psi_s = M_.params(9);
M_.params(10) = 0.6;
rho_s = M_.params(10);
M_.params(11) = 0.5;
rho_rp = M_.params(11);
M_.params(12) = 0.5;
sigma_s = M_.params(12);
M_.params(13) = 0.4;
sigma_rp = M_.params(13);
M_.params(14) = 0.3;
sigma_u = M_.params(14);
M_.params(15) = 0.2;
sigma_i = M_.params(15);
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (M_.params(12))^2;
M_.Sigma_e(2, 2) = (M_.params(13))^2;
M_.Sigma_e(3, 3) = (M_.params(14))^2;
M_.Sigma_e(4, 4) = (M_.params(15))^2;
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
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
steady;
oo_.dr.eigval = check(M_,options_,oo_);
options_.irf = 24;
options_.order = 1;
var_list_ = {};
[info, oo_, options_, M_] = stoch_simul(M_, options_, oo_, var_list_);


oo_.time = toc(tic0);
disp(['Total computing time : ' dynsec2hms(oo_.time) ]);
if ~exist([M_.dname filesep 'Output'],'dir')
    mkdir(M_.dname,'Output');
end
save([M_.dname filesep 'Output' filesep 'bol_model_results.mat'], 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bol_model_results.mat'], 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bol_model_results.mat'], 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bol_model_results.mat'], 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bol_model_results.mat'], 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bol_model_results.mat'], 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bol_model_results.mat'], 'oo_recursive_', '-append');
end
if exist('options_mom_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'bol_model_results.mat'], 'options_mom_', '-append');
end
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
