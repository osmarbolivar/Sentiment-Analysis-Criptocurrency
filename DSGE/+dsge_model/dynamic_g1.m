function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
% function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   g1
%

if T_flag
    T = dsge_model.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(6, 18);
g1(1,1)=(-params(15));
g1(1,7)=1;
g1(1,13)=(-(1-params(15)));
g1(1,14)=(-params(12));
g1(1,9)=params(12);
g1(1,11)=params(8);
g1(2,7)=(-params(6));
g1(2,2)=(-params(14));
g1(2,8)=1;
g1(2,14)=(-(params(13)*params(1)));
g1(2,4)=params(7);
g1(2,10)=(-params(7));
g1(2,17)=(-1);
g1(3,7)=(-((1-params(5))*params(3)));
g1(3,8)=(-((1-params(5))*params(4)));
g1(3,3)=(-params(5));
g1(3,9)=1;
g1(3,18)=(-1);
g1(4,4)=(-1);
g1(4,10)=1;
g1(4,11)=(-params(9));
g1(4,12)=(-1);
g1(5,5)=(-params(10));
g1(5,11)=1;
g1(5,15)=(-1);
g1(6,6)=(-params(11));
g1(6,12)=1;
g1(6,16)=(-1);

end
