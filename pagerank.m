clear all;
close all;
Edges = [1,1,2,2,2,3,3,3,4,4,5,5,6,6,7;
         4,6,3,4,5,5,6,7,5,6,4,6,4,7,6];
d = 0.85;
n = 15;     % 15 linków
N = 7       % 7 stron, więc macierz B jest 7x7 
% N = 0;      % wektor indeksów B, czyli chyba 1-N
v = ones(N,1) %wektor z jedynkami (elementy niezerowe w B) Czemu same 1?
B = sparse(Edges[2,:], Edges[1,:], v, N, N);
I = speye(N);
L = sum(B);
A = spdiags %co to
M = 
r = M/b % M\b? 