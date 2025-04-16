function [residual, T_order, T] = dynamic_resid(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(0, 1);
end
[T_order, T] = bolivia_sentiment_model_cleaned.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
residual = NaN(10, 1);
    residual(1) = (y(11)) - (0.9*y(21)-1/params(2)*(y(13)-y(22))-params(9)*y(15));
    residual(2) = (y(12)) - (y(22)*params(1)+params(6)*y(2)+y(11)*params(7)+params(8)*(y(14)-y(4))+x(3));
    residual(3) = (y(13)) - (y(24)-y(14)+y(15)*params(10)+y(16));
    residual(4) = (y(13)) - (params(5)*y(3)+(1-params(5))*(y(12)*params(3)+y(11)*params(4))+x(4));
    residual(5) = (y(15)) - (params(11)*y(5)+x(1));
    residual(6) = (y(16)) - (params(12)*y(6)+x(2));
    residual(7) = (y(17)) - (y(12));
    residual(8) = (y(18)) - (y(11));
    residual(9) = (y(19)) - (y(14));
    residual(10) = (y(20)) - (y(15));
end
