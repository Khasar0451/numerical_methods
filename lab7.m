clc
clear all
close all
load P_ref.mat
x = linspace(1,20,100);
for t = 1:100
    y(t) = f(x(t));
end 
plot(1:100, y)
title("Funkcja gęstości")
xlabel("Czas używania urządzenia w latach")
ylabel("Gęstość prawdopodbieństwa f(t)")


a = 0;
b = 5;
NArr = 5:50:10^4;
err1 = [];
err2 = [];
err3 = [];
err4 = [];
for N = NArr
    deltaX = (b-a)/N;

    %prostokaty
    sum = 0;
    for i = 1:N
        xi = a + (i-1)*deltaX;
        xip1 = a + i*deltaX;
        sum = sum + f((xi + xip1)/2)*deltaX;
       % disp(sum)
    end
    disp(sum-P_ref)
    err1 = [err1 abs(sum - P_ref)];
    disp("Prostokaty: ")
    disp(sum)
    
    %trapezy
    sum = 0;
    for i = 1:N
        xi = a + (i-1)*deltaX;
        xip1 = a + i*deltaX;
        sum = sum + ((f(xi)+f(xip1)) / 2) * deltaX;
    end
    err2 = [err2 abs(sum - P_ref)];
    disp("Trapezy: ")
    disp(sum)
    
    %simpson
    sum = 0;
    for i = 1:N
        xi = a + (i-1)*deltaX;
        xip1 = a + i*deltaX;
        sum = sum + f(xi) + 4 * f((xip1+xi)/2) + f(xip1);
    end
    sum = sum * deltaX / 6;
    err3 = [err3 abs(sum - P_ref)];
    disp("Simpson: ")
    disp(sum)
    
    %monte carlo
    S = b * f(b);
    x = a + (b-a) * rand(N,1);
    y = 0 + f(b) * rand(N,1);
    N1 = 0;
    for i = 1:N
        if f(x(i)) < y(i)
            N1 = N1 + 1;
        end
    end
    P = N1*S/N;
    err4 = [err4 abs(P - P_ref)];
    disp("Monte Carlo: ")
    disp(P)
end
figure
loglog(NArr, err1)
legend("Prostokąty")
xlabel("N")
ylabel("Błąd")
hold on
%print -dpng BladProstokaty.png;
%figure
loglog(NArr, err2)
legend("Trapezy")
%xlabel("Liczba przedziałów")
%ylabel("Błąd")
%print -dpng BladTrapezy.png;
%figure

loglog(NArr, err3)
legend("Simpson")
%xlabel("Liczba przedziałów")
%ylabel("Błąd")
%print -dpng BladSimpson.png;
%figure
loglog(NArr, err4)
legend("Prostokaty", "Trapezy", "Simpson" ,"Monte Carlo")
%xlabel("Liczba losowań")
%ylabel("Błąd")
hold off
print -dpng BledyCalkowania.png;

N = 10^7;
deltaX = (b-a)/N;

%prostokaty
sum = 0;
tic
for i = 1:N
    xi = a + (i-1)*deltaX;
    xip1 = a + i*deltaX;
    sum = sum + f((xi + xip1)/2)*deltaX;
end
czas(1) =toc;
disp(sum-P_ref)
err1 = [err1 abs(sum - P_ref)];
disp("Prostokaty: ")
disp(sum)

%trapezy
sum = 0;
tic
for i = 1:N
    xi = a + (i-1)*deltaX;
    xip1 = a + i*deltaX;
    sum = sum + ((f(xi)+f(xip1)) / 2) * deltaX;
end
czas(2) =toc;
err2 = [err2 abs(sum - P_ref)];
disp("Trapezy: ")
disp(sum)

%simpson
sum = 0;
tic
for i = 1:N
    xi = a + (i-1)*deltaX;
    xip1 = a + i*deltaX;
    sum = sum + f(xi) + 4 * f((xip1+xi)/2) + f(xip1);
end
czas(3) =toc;
sum = sum * deltaX / 6;
err3 = [err3 abs(sum - P_ref)];
disp("Simpson: ")
disp(sum)

%monte carlo
tic
S = b * f(b);
x = a + (b-a) * rand(N,1);
y = 0 + f(b) * rand(N,1);
N1 = 0;
for i = 1:N
    if f(x(i)) < y(i)
        N1 = N1 + 1;
    end
end
P = N1*S/N;
czas(4) =toc;
err4 = [err4 abs(P - P_ref)];
disp("Monte Carlo: ")
disp(P)

names = {"Prosotąty"; "Trapezy"; "Simpson"; "Monte Carlo"};
figure
bar(czas)
set(gca,'xticklabel',names)
title("Czas wykonywania metod całkowania")
ylabel("Czas [s]")
xlabel("Metoda")
print -dpng czasy.png;




59825



f.m

function val = f(t)
    val = exp(-(t-10)^2 / 18) / (3*sqrt(2*pi));
end











clc
clear all


%------------------------------------------
load dane_jezioro   % dane XX, YY, FF sa potrzebne jedynie do wizualizacji problemu. 
surf(XX,YY,FF)
shading interp
axis equal
%------------------------------------------
N = 10^4;
V = 100*100*50;
x = 100 * rand(N,1);
y = 100 * rand(N,1);
z = -50 * rand(N,1);
N1 = 0;
for i = 1:N
    if z(i) < glebokosc(x,y) %f(x(i)) < z && f(y(i)) < z(i) 
        N1 = N1 + 1;
    end
end
P = N1*V/N;
disp(P);
%------------------------------------------
% Implementacja Monte Carlo dla f(x,y) w celu obliczenia objetosci wody w zbiorniku wodnym. 
% Calka = ?
% Nalezy skorzystac z nastepujacej funkcji:
% z = glebokosc(x,y); % wyznaczanie glebokosci jeziora w punkcie (x,y),
% gdzie x i y sa losowane
%------------------------------------------
