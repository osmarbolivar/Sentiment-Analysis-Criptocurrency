function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
% function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
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
%   residual
%

if T_flag
    T = bolivia_sentiment_model_cleaned.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(10, 1);
    residual(1) = (y(6)) - (0.9*y(16)-1/params(2)*(y(8)-y(17))-params(9)*y(10));
    residual(2) = (y(7)) - (y(17)*params(1)+params(6)*y(1)+y(6)*params(7)+params(8)*(y(9)-y(3))+x(it_, 3));
    residual(3) = (y(8)) - (y(18)-y(9)+y(10)*params(10)+y(11));
    residual(4) = (y(8)) - (params(5)*y(2)+(1-params(5))*(y(7)*params(3)+y(6)*params(4))+x(it_, 4));
    residual(5) = (y(10)) - (params(11)*y(4)+x(it_, 1));
    residual(6) = (y(11)) - (params(12)*y(5)+x(it_, 2));
    residual(7) = (y(12)) - (y(7));
    residual(8) = (y(13)) - (y(6));
    residual(9) = (y(14)) - (y(9));
    residual(10) = (y(15)) - (y(10));

end
