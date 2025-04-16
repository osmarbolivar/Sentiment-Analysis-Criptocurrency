function [y, T] = dynamic_1(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(11)=params(10)*y(5)+x(1);
  y(12)=params(11)*y(6)+x(2);
end
