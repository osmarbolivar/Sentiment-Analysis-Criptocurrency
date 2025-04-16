function [y, T, residual, g1] = dynamic_2(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(4, 1);
  residual(1)=(y(13))-(params(5)*y(3)+(1-params(5))*(y(12)*params(3)+y(11)*params(4))+x(4));
  residual(2)=(y(12))-(y(22)*params(1)+params(6)*y(2)+y(11)*params(7)+params(8)*(y(14)-y(4))+x(3));
  residual(3)=(y(13))-(y(24)-y(14)+y(15)*params(10)+y(16));
  residual(4)=(y(11))-(0.9*y(21)-1/params(2)*(y(13)-y(22))-params(9)*y(15));
if nargout > 3
    g1_v = NaN(17, 1);
g1_v(1)=(-params(5));
g1_v(2)=(-params(6));
g1_v(3)=params(8);
g1_v(4)=1;
g1_v(5)=1;
g1_v(6)=1/params(2);
g1_v(7)=(-((1-params(5))*params(3)));
g1_v(8)=1;
g1_v(9)=(-params(8));
g1_v(10)=1;
g1_v(11)=(-((1-params(5))*params(4)));
g1_v(12)=(-params(7));
g1_v(13)=1;
g1_v(14)=(-params(1));
g1_v(15)=(-(1/params(2)));
g1_v(16)=(-1);
g1_v(17)=(-0.9);
    if ~isoctave && matlab_ver_less_than('9.8')
        sparse_rowval = double(sparse_rowval);
        sparse_colval = double(sparse_colval);
    end
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 4, 12);
end
end
