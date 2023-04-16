clc
clear all
close all

[xvect, xdif, fx, it_cnt] = bisection(1,60000,1e-3,@compute_time);
plot(1:it_cnt, xvect)
title("Metoda bisekcji, dla funkcji wyznaczającej czas wykonania algorytmu A")
ylabel("Liczba parametrów")
xlabel("Numer iteracji")
figure
semilogy(1:it_cnt, xdif)
title("Metoda bisekcji, dla funkcji wyznaczającej czas wykonania algorytmu A")
ylabel("Różnica między kolejnymi rozwiązaniami")
xlabel("Numer iteracji")
figure


[xvect, xdif, fx, it_cnt] = secant(1,60000,1e-3,@compute_time);
plot(1:it_cnt, xvect)
title("Metoda siecznych, dla funkcji wyznaczającej czas wykonania algorytmu A")
ylabel("Liczba parametrów")
xlabel("Numer iteracji")
figure
semilogy(1:it_cnt, xdif)
title("Metoda siecznych, dla funkcji wyznaczającej czas wykonania algorytmu A")
ylabel("Różnica między kolejnymi rozwiązaniami")
xlabel("Numer iteracji")
figure


[xvect, xdif, fx, it_cnt] = bisection(0,50,1e-12,@compute_impedance);
plot(1:it_cnt, xvect)
title("Metoda bisekcji, dla funkcji wyznaczającej impedancję obwodu rezonansowego")
ylabel("Wartość omegi")
xlabel("Numer iteracji")
figure
semilogy(1:it_cnt, xdif)
title("Metoda bisekcji, dla funkcji wyznaczającej impedancję obwodu rezonansowego")
ylabel("Różnica między kolejnymi rozwiązaniami")
xlabel("Numer iteracji")
figure


[xvect, xdif, fx, it_cnt] = secant(0,50,1e-12,@compute_impedance);
plot(1:it_cnt, xvect)
title("Metoda siecznych, dla funkcji wyznaczającej impedancję obwodu rezonansowego")
ylabel("Wartość omegi")
xlabel("Numer iteracji")
semilogy(1:it_cnt, xdif)
figure
title("Metoda siecznych, dla funkcji wyznaczającej impedancję obwodu rezonansowego")
ylabel("Różnica między kolejnymi rozwiązaniami")
xlabel("Numer iteracji")
figure


[xvect, xdif, fx, it_cnt] = bisection(0,50,1e-12,@compute_speed);
plot(1:it_cnt, xvect)
title("Metoda bisekcji, dla funkcji wyznaczającej prędkość lotu rakiety")
ylabel("Czas")
xlabel("Numer iteracji")
figure
semilogy(1:it_cnt, xdif)
title("Metoda bisekcji, dla funkcji wyznaczającej prędkość lotu rakiety")
ylabel("Różnica między kolejnymi rozwiązaniami")
xlabel("Numer iteracji")
figure


[xvect, xdif, fx, it_cnt] = secant(0,50,1e-12,@compute_speed);
plot(1:it_cnt, xvect)
title("Metoda siecznych, dla funkcji wyznaczającej prędkość lotu rakiety")
ylabel("Czas")
xlabel("Numer iteracji")
figure
semilogy(1:it_cnt, xdif)
title("Metoda siecznych, dla funkcji wyznaczającej prędkość lotu rakiety")
ylabel("Różnica między kolejnymi rozwiązaniami")
xlabel("Numer iteracji")
figure


fx
xvectf