clc
clear all
close all

warning('off','all')

load trajektoria1


N = 60;
xa = aproksymacjaWielomianowa(n, x, N);  % aproksymacja wspolrzednej x
ya = aproksymacjaWielomianowa(n, y, N);  
za = aproksymacjaWielomianowa(n, z, N);  

plot3(x,y,z,'o')
grid on
axis equal
hold on
xlabel("Położenie - oś x [m]")
ylabel("Położenie - oś y [m]")
zlabel("Położenie - oś z [m]")
plot3(xa,ya,za,'g','lineWidth',4)
xlabel("Położenie - oś x [m]")
ylabel("Położenie - oś y [m]")
zlabel("Położenie - oś z [m]")
print -dpng zadanie4.png;