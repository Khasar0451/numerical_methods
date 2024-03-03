clc
clear all
close all

% odpowiednie fragmenty kodu mozna wykonac poprzez zaznaczenie i wcisniecie F9 w Matlabie
% komentowanie/odkomentowywanie: ctrl+r / ctrl+t

% Zadanie A
%------------------
N = 10;
density = 3; % parametr decydujacy o gestosci polaczen miedzy stronami
[Edges] = generate_network(N, density);
%-----------------

% Zadanie B
%------------------
% generacja macierzy I, A, B i wektora b
% macierze A, B i I musza byc przechowywane w formacie sparse (rzadkim)
d = 0.85;
v = ones(1, size(Edges,2)); 
B = sparse(Edges(2,:), Edges(1,:), v, N, N);
I = speye(N);   
L = sum(B);
A = spdiags(1./L',0,N,N);
M = I - d*B*A;
b = zeros(N,1) + (1-d)/N;

issparse(M)
%-----------------

r=M\b;

% Zadanie D
%------------------
clc
clear all
close all

N = [500, 1000, 3000, 6000, 12000];


for i = 1:5
    density = 10; % parametr decydujacy o gestosci polaczen miedzy stronami
    d = 0.85;
    [Edges] = generate_network(N(i), density);
    v = ones(1, size(Edges,2)); 
    B = sparse(Edges(2,:), Edges(1,:), 1, N(i), N(i));
    I = speye(N(i));   
    L = sum(B);
    A = spdiags(1./L',0,N(i),N(i));

    M = I - d*B*A;
    b = zeros(N(i),1) + (1-d)/N(i);

    tic
    % obliczenia start
    r=M\b;
    % obliczenia stop
    czas(i) = toc;
end
plot(N, czas)
xlabel("Wartość N")
ylabel("Czas [s]")
title("Bezpośrednia - czas")
%------------------


%%
% Zadanie E
%------------------
clc
clear all
close all


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sprawdz czy poprawnie mierze czas i czy wykresy sa zapisywane %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


N = [500, 1000, 3000, 6000, 12000];

for i = 1:5
    density = 10; % parametr decydujacy o gestosci polaczen miedzy stronami
    d = 0.85;

    [Edges] = generate_network(N(i), density);

    v = ones(1, size(Edges,2)); 
    B = sparse(Edges(2,:), Edges(1,:), 1, N(i), N(i));
    I = speye(N(i));   
    L = sum(B);
    A = spdiags(1./L',0,N(i),N(i));
    M = I - d*B*A;
    b = zeros(N(i),1) + (1-d)/N(i);
    
    [iter(i), resArr] = jacobi(N(i), M, b);

    % obliczenia stop   
    czas_Jacobi(i) = toc;
end
figure;
plot(N, czas_Jacobi)
xlabel("Wartość N")
ylabel("Czas [s]")
title("Jacobi - czas")
figure;
plot(N, iter)
xlabel("Wartość N")
ylabel("Ilość iteracji")
title("Jacobi - ilość iteracji")

figure;
semilogy(1:length(resArr), resArr)
ylabel("Wielkość normy błędu rezydualnego")
xlabel("Numer losowania")
title("Jacobi - norma błędu rezydualnego dla N=1000")

%------------------
%%

% Zadanie F
%------------------
clc
clear all
close all

N = [500, 1000, 3000, 6000, 12000];

for i = 1:5
    density = 10; % parametr decydujacy o gestosci polaczen miedzy stronami
    d = 0.85;
    
    [Edges] = generate_network(N(i), density);
   
    v = ones(1, size(Edges,2)); 
    B = sparse(Edges(2,:), Edges(1,:), 1, N(i), N(i));
    I = speye(N(i));   
    L = sum(B);
    A = spdiags(1./L',0,N(i),N(i));
    M = I - d*B*A;
    b = zeros(N(i),1) + (1-d)/N(i);

    [iter(i), resArr] = gaussSeidel(N(i), M, b);

    % obliczenia stop
    czas_Gauss(i) = toc;
end

figure;
plot(N, czas_Gauss)
xlabel("Wartość N")
ylabel("Czas [s]")
title("Gauss-Seidel - czas")

figure;
plot(N, iter)
xlabel("Wartość N")
ylabel("Ilość iteracji")
title("Gauss-Seidel - ilość iteracji")

figure;
semilogy(1:length(resArr), resArr)
ylabel("Wielkość normy błędu rezydualnego")
xlabel("Numer losowania")
title("Gauss-Seidel - norma błędu rezydualnego dla N=1000")

% Zadanie G
%------------------
%%
clc
clear all
close all

load("Dane_Filtr_Dielektryczny_lab3_MN.mat");
N = length(M);
%r=M\b;
[ie, resArr] = jacobi(N, M, b);
figure;
semilogy(1:length(resArr), resArr)
ylabel("Wielkość normy błędu rezydualnego")
xlabel("Numer losowania")
title("Jacobi - norma błędu rezydualnego")

[iet, resArr] = gaussSeidel(N, M, b);
figure;
semilogy(1:length(resArr), resArr)
ylabel("Wielkość normy błędu rezydualnego")
xlabel("Numer losowania")
title("Gauss-Seidel - norma błędu rezydualnego")