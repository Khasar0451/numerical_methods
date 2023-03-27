clear all;
close all;
a = 4;
r_max = a / 2;
n_max = 200;
i = 2;
correct = 0;
los = 0;
while correct == 0
    x = rand(1) * a;
    y = rand(1) * a;
    r = rand(1) * r_max;
    correct = x-r>0 & x+r<a & y-r>0 & y+r<a;
    los = los + 1;
end
xArr(1) = x;
yArr(1) = y;
rArr(1) = r;
lArr(1) = los;
hold on;
plot_circle(x,y,r); 
PArr(1) = pi*r^2;
axis equal;
axis ([0 a 0 a]);

while i <= n_max
    correct = 0;
    los = 0;
    while correct == 0
        x = rand(1) * a;
        y = rand(1) * a;
        r = rand(1) * r_max;
        j = 1;
        los = los + 1;
        while j < i
            correct = check(x,y,a,r,xArr(j),yArr(j),rArr(j));
            if correct == 0 
                j = n_max;
            end
            j = j + 1;
        end
    end
    xArr(i) = x;
    yArr(i) = y;
    rArr(i) = r;
    PArr(i) = pi * r * r;
    lArr(i) = los;
    plot_circle(x,y,r);
    pause(0.01);
    i = i + 1;
end
hold off;

figure;
plot(1:n_max,cumsum(PArr));
title("powierzchnia całkowita kół")
xlabel("liczba narysowanych okregow");
ylabel("powierzchnia");
print -dpng zadanie1a

figure;
i=1;
while i <= n_max
    lArr(i) = lArr(i) / i;
    i = i+1;
end

plot(1:n_max, cumsum(lArr));
title("średnia liczba losowań")
xlabel("liczba narysowanych okregow");
ylabel("liczba losowań");
print -dpng zadanie1b