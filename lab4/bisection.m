function [xvect,xdif,fx,it_cnt] = bisection(l,r,eps,fun)
% fun - funkcja, ktorej miejsce zerowe bedzie poszukiwane
% [l,r] - przedzial poszukiwania miejsca zerowego
% eps - prog dokladnosci obliczen
% 
% xvect - wektor kolejnych wartosci przyblizonego rozwiazania
% xdif - wektor roznic pomiedzy kolejnymi wartosciami przyblizonego rozwiazania
% fx - wektor wartosci funkcji dla kolejnych elementow wektora xvect
% it_cnt - liczba iteracji wykonanych przy poszukiwaniu miejsca zerowego

it_cnt = 0;
for i = 1:1000
    it_cnt = it_cnt + 1;
    c = (l + r)/2;

    xvect(i) = c;
    if i > 1
        xdif(i) = abs(c - xvect(i - 1));
    end
    fc = fun(c); % wartosci funkcji fun dla wartosci c
    fx(i) = fc;

    if abs(fc) < eps || abs(r - l) < eps 
        return 
    elseif fun(l) * fun(c) < 0
        r = c;
    else
        l = c; 
    end

end


end

