function [xvect,xdif,fx,it_cnt] = secant(a,b,eps,fun)
% fun - funkcja, ktorej miejsce zerowe bedzie poszukiwane
% [a,b] - przedzial poszukiwania miejsca zerowego
% eps - prog dokladnosci obliczen
% 
% xvect - wektor kolejnych wartosci przyblizonego rozwiazania
% xdif - wektor roznic pomiedzy kolejnymi wartosciami przyblizonego rozwiazania
% fx - wektor wartosci funkcji dla kolejnych elementow wektora xvect
% it_cnt - liczba iteracji wykonanych przy poszukiwaniu miejsca zerowego



it_cnt = 0;
xvect(1) = a;
xvect(2) = b;
for i = 3:1000
    it_cnt = it_cnt + 1;
    xk = xvect(i-1);
    xkm1 = xvect(i-2);
    
    licznik =  fun(xk) * (xk - xkm1) 
    mianownik = fun(xk) - fun(xkm1)
    liczba = licznik/mianownik
    c = xk - liczba
    %c = xk - ( fun(xk) * (xk - xkm1) ) / (fun(xk) - fun(xkm1));
    xvect(i) = c;
    xdif(i) = abs(c - xvect(i - 1));
    
    fc = fun(c); % wartosci funkcji fun dla wartosci c
    fx(i) = fc;

    if abs(fc) < eps 
        return 
    end
end
end

