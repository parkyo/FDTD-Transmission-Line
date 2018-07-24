clear all; close all; clc;

Nt = 500;               %no. of meshes
Nz = 100;               %no. of time steps
S = 0.5;                %courant number
ep = 8.854*10^-12;      %permittivity
mu = (4*pi)*10^(-7);    %permeability
c = 1/sqrt(ep*mu);      %light speed [m/s] in vaccuum
dz = 1*10^-3;           %size of each cell
dt = dz/c*S;            %size of each time step
e1 = 1;                 %relative permittivity in air
tau = dt*1e13;          %width of gaussian pulse
Ey = zeros(1,Nz);       %vectorization of Ey
Hx = zeros(1,Nz);       %vectorization of Hx
mHx = c*dt/dz;          %impedance of H field
mEy = c*dt/dz;          %impedance of E field
vidObj2 = VideoWriter('FDTDmovie2.avi');
open(vidObj2);
for i=1:Nt
    %source
    Ey(floor(Nz/2)) = Ey(floor(Nz/2)) + exp(-(i-tau*4)^2/(2*tau^2));
    %equation for E field
    Ey(2:Nz-1) = Ey(2:Nz-1) - mEy*(Hx(1:Nz-2)-Hx(2:Nz-1));    
    %equation for H field
    Hx(1:Nz-1) = Hx(1:Nz-1)- mHx*(Ey(1:Nz-1)-Ey(2:Nz)); 
    %graph figure
    figure(1);
    plot(Hx);
    axis([0 Nz -2 2]);
    xlabel('Z(mm)');
    ylabel('Hx(mA/m)')
    movie2 = getframe(gcf);
    writeVideo(vidObj2,movie2);
end
close(vidObj2);
