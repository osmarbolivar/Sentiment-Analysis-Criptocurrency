function [y, T, residual, g1] = static_3(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(3, 1);
  residual(1)=(y(3))-(y(3)*params(5)+(1-params(5))*(y(2)*params(3)+y(1)*params(4))+x(4));
  residual(2)=(y(2))-(y(2)*params(1)+y(1)*params(6)+x(3));
  residual(3)=(y(1))-(y(1)-1/params(2)*(y(3)-y(2))-params(8)*y(5));
if nargout > 3
    g1_v = NaN(7, 1);
g1_v(1)=1-params(5);
g1_v(2)=1/params(2);
g1_v(3)=(-((1-params(5))*params(3)));
g1_v(4)=1-params(1);
g1_v(5)=(-(1/params(2)));
g1_v(6)=(-((1-params(5))*params(4)));
g1_v(7)=(-params(6));
    if ~isoctave && matlab_ver_less_than('9.8')
        sparse_rowval = double(sparse_rowval);
        sparse_colval = double(sparse_colval);
    end
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 3, 3);
end
end
