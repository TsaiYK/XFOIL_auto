clear
close all
clc

%% Parameters definition
para.numNodes = 200; % number of points on the airfoil
para.Airfoil = 'NACA'; % it means a NACA airfoil is used
para.NACA = '0012'; % or 0012
para.width = 0.01; % span, unit: m
para.rho = 1.206; % air density
para.U = 20;
para.alpha = 1;
para.Re = 2.78e5; % Reynold number
para.Mach = para.U/343;

%% XFOIL simulation
FluidOutput = Aerodynamics_XFOIL(para,'Airfoil_coordinate_CST.txt');
Cp = FluidOutput.Cp; % positive: out of the airfoil
P = FluidOutput.P;
L = FluidOutput.L;
dA = FluidOutput.dA;
normal_dir = FluidOutput.normal_dir;
RotationMatrix = [cosd(-para.alpha),-sind(-para.alpha);...
    sind(-para.alpha),cosd(-para.alpha)];
X0 = FluidOutput.X0;
Y0 = FluidOutput.Y0;
X = FluidOutput.X;
Y = FluidOutput.Y;

%% Plots
figure
plot(X0(1:100),Cp(1:para.numNodes/2),'LineWidth',1.5); hold on
plot(X0(101:end),Cp(para.numNodes/2+1:end),'--','LineWidth',1.5)
xlabel('Distance along chord (m)')
ylabel('$C_p$','interpreter','latex')
title(['Velocity = ',num2str(para.U),' m/s'])
legend('lower surf','upper surf')

U = -Cp.*cos(normal_dir);
V = -Cp.*sin(normal_dir);
X_for_plot = X;
Y_for_plot = Y;

figure
plot(X,Y,'k.','LineWidth',2); hold on
plot(X,Y,'k-')
axis equal; grid on;
p2 = quiver(X_for_plot,Y_for_plot,U,V,'r','AutoScaleFactor',3.05);
legend(p2,'pressure vectors')
title(['Velocity = ',num2str(para.U),' m/s'])
