function [residual, T_order, T] = static_resid(y, x, params, T_order, T)
if nargin < 5
    T_order = -1;
    T = NaN(0, 1);
end
[T_order, T] = dsge_model.sparse.static_resid_tt(y, x, params, T_order, T);
residual = NaN(6, 1);
    residual(1) = (y(1)) - (y(1)*params(15)+y(1)*(1-params(15))-params(12)*(y(3)-y(2))-params(8)*y(5));
    residual(2) = (y(2)) - (y(2)*params(13)*params(1)+y(2)*params(14)+y(1)*params(6)+x(3));
    residual(3) = (y(3)) - (y(3)*params(5)+(1-params(5))*(y(2)*params(4)+y(1)*params(3))+x(4));
    residual(4) = (y(4)) - (y(4)+y(5)*params(9)+y(6));
    residual(5) = (y(5)) - (y(5)*params(10)+x(1));
    residual(6) = (y(6)) - (y(6)*params(11)+x(2));
end
