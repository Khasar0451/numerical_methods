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
    density = 3; % parametr decydujacy o gestosci polaczen miedzy stronami
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
    disp (i);
    % obliczenia start
    r=M\b;
    disp (i);
    % obliczenia stop
    czas(i) = toc;
    
    % disp(czas_Gauss);
end
plot(N, czas)
xlabel("Wartość N")
ylabel("Czas")
title("Bezpośrednia - czas")
% %------------------
% 

%%
% Zadanie E
%------------------
clc
clear all
close all

% sprawdz przykladowe dzialanie funkcji tril, triu, diag:
% Z = rand(4,4)
% tril(Z,-1) 
% triu(Z,1) 
% diag(diag(Z))


N = [500, 1000, 3000, 6000, 12000];

for i = 1:5
    density = 3; % parametr decydujacy o gestosci polaczen miedzy stronami
    d = 0.85;
    
    [Edges] = generate_network(N(i), density);
   
    v = ones(1, size(Edges,2)); 
    B = sparse(Edges(2,:), Edges(1,:), 1, N(i), N(i));
    I = speye(N(i));   
    L = sum(B);
    A = spdiags(1./L',0,N(i),N(i));
    
    M = I - d*B*A;
    b = zeros(N(i),1) + (1-d)/N(i);
    flag = false;
    k(i)=0;
    r = ones(N(i), 1);
    
    
    res = norm(M*r-b);
    U = triu(M, 1);
    L = tril(M, -1);
    D = diag(diag(M));
    part1 = -D\(L+U);
    part2 = D\b;
    % obliczenia start
    tic
    while ((res) > 10e-14)
        r = part1*r+part2;
        res = norm(M*r-b);
        k(i) = k(i) + 1;
        if (i == 2)
            res2(k) = res;
        end
        
    end
    % obliczenia stop   
    czas_Jacobi(i) = toc;
end
figure;
plot(N, czas_Jacobi)
xlabel("Wartość N")
ylabel("Czas")
title("Jacobi - czas")
figure;
plot(N, k)
xlabel("Wartość N")
ylabel("Ilość iteracji")
title("Jacobi - ilość iteracji")

figure;
semilogy(1:length(res2), res2)
xlabel("Wielkość normy błędu rezydualnego")
ylabel("Numer losowania")
title("Jacobi - norma błędu rezydualnego dla N=1000")

%------------------
%%

% Zadanie F
%------------------


N = [500, 1000, 3000, 6000, 12000];

for i = 1:5
    density = 3; % parametr decydujacy o gestosci polaczen miedzy stronami
    d = 0.85;
    
    [Edges] = generate_network(N(i), density);
   
    v = ones(1, size(Edges,2)); 
    B = sparse(Edges(2,:), Edges(1,:), 1, N(i), N(i));
    I = speye(N(i));   
    L = sum(B);
    A = spdiags(1./L',0,N(i),N(i));
    
    M = I - d*B*A;
    b = zeros(N(i),1) + (1-d)/N(i);
    flag = false;
    k(i)=0;
    r = ones(N(i), 1);
    
    res = norm(M*r-b);
    U = triu(M, 1);
    L = tril(M, -1);
    D = diag(diag(M));
    part1 = -(D+L);
    part2 = (D+L)\b;
    % obliczenia start
    tic
    while ((res) > 10e-14)
        r = part1\(U*r)+part2;
        res = norm(M*r-b);
        k(i) = k(i) + 1;
        if (i == 2)
            res2(k) = res;
        end
    end
    % obliczenia stop
    czas_Gauss(i) = toc;
end

figure;
plot(N, czas_Gauss)
xlabel("Wartość N")
ylabel("Czas")
title("Gauss - czas")
figure;
plot(N, k)
xlabel("Wartość N")
ylabel("Ilość iteracji")
title("Gauss - ilość iteracji")

figure;
semilogy(1:length(res2), res2)
xlabel("Wielkość normy błędu rezydualnego")
ylabel("Numer losowania")
title("Gauss - norma błędu rezydualnego dla N=1000")

% Zadanie G
%------------------


