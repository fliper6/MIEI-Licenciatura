function F = Sistema_N_Linear_Equals_0(x)
F(1) = (x(1)^4+0.06823*x(1))-(x(2)^4+0.05848*x(2))-0.01509;
F(2) = (x(1)^4+0.05848*x(1))-(2*x(2)^4+0.11696*x(2));
% fornecendo as primeiras derivadas F passa a ser [F,d]
%if nargout>1
%d = [4*x(1)^3+0.06823 -4*x(2)^3-0.05848; 4*x(1)^3+0.05848 -8*x(2)^3-0.11696];
end

