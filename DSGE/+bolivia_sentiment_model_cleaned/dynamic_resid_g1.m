function [residual, g1] = dynamic_resid_g1(T, y, x, params, steady_state, it_, T_flag)
% function [residual, g1] = dynamic_resid_g1(T, y, x, params, steady_state, it_, T_flag)
%
% Wrapper function automatically created by Dynare
%

    if T_flag
        T = bolivia_sentiment_model_cleaned.dynamic_g1_tt(T, y, x, params, steady_state, it_);
    end
    residual = bolivia_sentiment_model_cleaned.dynamic_resid(T, y, x, params, steady_state, it_, false);
    g1       = bolivia_sentiment_model_cleaned.dynamic_g1(T, y, x, params, steady_state, it_, false);

end
