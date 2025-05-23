function [g1, T_order, T] = static_g1(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T_order, T)
if nargin < 8
    T_order = -1;
    T = NaN(0, 1);
end
[T_order, T] = dsge_model.sparse.static_g1_tt(y, x, params, T_order, T);
g1_v = NaN(12, 1);
g1_v(1)=(-params(6));
g1_v(2)=(-((1-params(5))*params(3)));
g1_v(3)=(-params(12));
g1_v(4)=1-(params(13)*params(1)+params(14));
g1_v(5)=(-((1-params(5))*params(4)));
g1_v(6)=params(12);
g1_v(7)=1-params(5);
g1_v(8)=params(8);
g1_v(9)=(-params(9));
g1_v(10)=1-params(10);
g1_v(11)=(-1);
g1_v(12)=1-params(11);
if ~isoctave && matlab_ver_less_than('9.8')
    sparse_rowval = double(sparse_rowval);
    sparse_colval = double(sparse_colval);
end
g1 = sparse(sparse_rowval, sparse_colval, g1_v, 6, 6);
end
