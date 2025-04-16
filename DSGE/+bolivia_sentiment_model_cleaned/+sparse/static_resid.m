function [residual, T_order, T] = static_resid(y, x, params, T_order, T)
if nargin < 5
    T_order = -1;
    T = NaN(0, 1);
end
[T_order, T] = bolivia_sentiment_model_cleaned.sparse.static_resid_tt(y, x, params, T_order, T);
residual = NaN(10, 1);
    residual(1) = (y(1)) - (y(1)*0.9-1/params(2)*(y(3)-y(2))-params(9)*y(5));
    residual(2) = (y(2)) - (y(2)*params(1)+y(2)*params(6)+y(1)*params(7)+x(3));
    residual(3) = (y(3)) - (y(5)*params(10)+y(6));
    residual(4) = (y(3)) - (y(3)*params(5)+(1-params(5))*(y(2)*params(3)+y(1)*params(4))+x(4));
    residual(5) = (y(5)) - (y(5)*params(11)+x(1));
    residual(6) = (y(6)) - (y(6)*params(12)+x(2));
    residual(7) = (y(7)) - (y(2));
    residual(8) = (y(8)) - (y(1));
    residual(9) = (y(9)) - (y(4));
    residual(10) = (y(10)) - (y(5));
end
