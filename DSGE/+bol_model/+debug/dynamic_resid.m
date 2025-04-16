function [lhs, rhs] = dynamic_resid(y, x, params, steady_state)
T = NaN(0, 1);
lhs = NaN(6, 1);
rhs = NaN(6, 1);
lhs(1) = y(7);
rhs(1) = y(13)-1/params(2)*(y(9)-y(14))-params(8)*y(11);
lhs(2) = y(8);
rhs(2) = y(14)*params(1)+y(7)*params(6)+params(7)*(y(10)-y(4))+x(3);
lhs(3) = y(9);
rhs(3) = params(5)*y(3)+(1-params(5))*(y(8)*params(3)+y(7)*params(4))+x(4);
lhs(4) = y(10);
rhs(4) = y(9)+y(4)+y(11)*params(9)+y(12);
lhs(5) = y(11);
rhs(5) = params(10)*y(5)+x(1);
lhs(6) = y(12);
rhs(6) = params(11)*y(6)+x(2);
end
