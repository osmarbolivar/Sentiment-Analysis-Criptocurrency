function [residual, T_order, T] = dynamic_resid(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(0, 1);
end
[T_order, T] = dsge_model.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
residual = NaN(6, 1);
    residual(1) = (y(7)) - (params(15)*y(1)+(1-params(15))*y(13)-params(12)*(y(9)-y(14))-params(8)*y(11));
    residual(2) = (y(8)) - (y(14)*params(13)*params(1)+params(14)*y(2)+y(7)*params(6)+params(7)*(y(10)-y(4))+x(3));
    residual(3) = (y(9)) - (params(5)*y(3)+(1-params(5))*(y(8)*params(4)+y(7)*params(3))+x(4));
    residual(4) = (y(10)) - (y(4)+y(11)*params(9)+y(12));
    residual(5) = (y(11)) - (params(10)*y(5)+x(1));
    residual(6) = (y(12)) - (params(11)*y(6)+x(2));
end
