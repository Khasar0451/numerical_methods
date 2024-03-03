clear all;
close all;
Edges = [1,1,2,2,2,3,3,3,4,4,5,5,6,6,7; %2wierszex15kolumn
         4,6,3,4,5,5,6,7,5,6,4,6,4,7,6];
d = 0.85;
n = 15;     % 15 linków
N = 7;      % 7 stron, więc macierz B jest 7x7 
v = ones(1, size(Edges,2)); %1 wiersz 15 kolumn
B = sparse(Edges(2,:), Edges(1,:), v, N, N);
I = speye(N);   %sparse I(eye)dentity, rzadka jednostkowa
L = sum(B);
% A = spdiags %co to
A = spdiags(1./L',0,N,N);
M = I - d*B*A;
b = zeros(N,1) + (1-d)/N;

diary("sparse_test.txt");
whos A B I M b 
diary off;

spy(B)
print -dpng spy_b
r = M/b % M\b? 