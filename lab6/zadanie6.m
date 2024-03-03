clc
clear all
close all

warning('off','all')

load trajektoria2

N = 60;
xa = aproksymacjaTrygonometryczna(n, x, N);  % aproksymacja wspolrzednej x
ya = aproksymacjaTrygonometryczna(n, y, N);  
za = aproksymacjaTrygonometryczna(n, z, N);  

plot3(x,y,z,'o')
grid on
axis equal
hold on
plot3(xa,ya,za,'g','lineWidth',4)
xlabel("Położenie - oś x [m]")
ylabel("Położenie - oś y [m]")
zlabel("Położenie - oś z [m]")
print -dpng zadanie5a.png;
hold off
figure

M = numel(x);
maxN = 71;
%err = zeros(maxN);
for N = 1:maxN
    xa = aproksymacjaTrygonometryczna(n, x, N);  % aproksymacja wspolrzednej x
    ya = aproksymacjaTrygonometryczna(n, y, N);  
    za = aproksymacjaTrygonometryczna(n, z, N);  
    errx = sqrt(sum((x - xa).^2))/M;
    erry = sqrt(sum((y - ya).^2))/M;
    errz = sqrt(sum((z - za).^2))/M;
    err(N) = errx + erry + errz;
end

[minError, index] = min(err);
disp("Minimalny błąd to " + minError  + " dla N = " + index);

semilogy(1:maxN,err,'o')
grid on
xlabel("Rząd aproksymacji")
ylabel("Wartość błędu")
print -dpng zadanie5b.png;