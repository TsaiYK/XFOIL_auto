clear
clc
% close all

%%  Airfoil parameters
c = 1; % chord length

%%
N1 = 0.5;
N2 = 1;
psi = 0:0.01:1;
C = psi.^N1.*(1-psi).^N2;
n = 4; % order of Bernstein polynomials
for r = 0:n
    K = nchoosek(n,r);
    S(r+1,:) = K*psi.^r.*(1-psi).^(n-r);
end

figure
plot(psi,S)
xlabel('$\psi$','Interpreter','latex')
ylabel('$S(\psi)$','Interpreter','latex')

% Au = ones(1,n+1); % coefficients for the upper surface
% Al = ones(1,n+1); % coefficients for the lower surface
Au = [0.1702,0.1528,0.1592,0.1192,0.1651];
Al = [0.1828,0.1179,0.2079,0.0850,0.1874];
S_times_Au = Au*S;
S_times_Al = Al*S;

Delta_zTE = 0.001;
zeta_T = Delta_zTE/c;

zeta_u = C.*S_times_Au+psi*zeta_T;
zeta_l = -(C.*S_times_Al+psi*zeta_T);


figure
plot(psi,zeta_u); hold on
plot(psi,zeta_l)
xlabel('$\psi$','Interpreter','latex')
ylabel('$\zeta$','Interpreter','latex')

X = [psi';flip(psi)'];
Y = [zeta_u';flip(zeta_l)'];
Coordinate = [X,Y];

figure
plot(X,Y)
xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
axis equal

writematrix(Coordinate,'Airfoil_coordinate_CST.txt','Delimiter',' ')




