clear all; close all; clc;

Nt = 500;               %no. of time steps
Nz = 100;               %no. of meshes
ep = 8.854*10^-12;      %permittivity
mu = (4*pi)*10^(-7);    %permeability
c = 1/sqrt(ep*mu);      %light speed [m/s] in vaccuum
wlength = 1*10^-2;      %wave length
dz = wlength/10;        %size of each cell
dt = dz/(c*2);          %size of each time step
tau = 2/(Nz*dz);        %width of gaussian pulse
Ey = zeros(1,Nz);       %vectorization of Ey
Hx = zeros(1,Nz);       %vectorization of Hx
mHx = c*dt/dz;          %impedance of H field
mEy = c*dt/dz;          %impedance of E field
vidObj = VideoWriter('FDTDmovie.avi');
open(vidObj);
for i=1:Nt
    %source
    Ey(floor(Nz/2)) = Ey(floor(Nz/2)) + exp(-((i-tau*6)/(tau))^2);
    %equation for E field
    Ey(2:Nz-1) = Ey(2:Nz-1) + mEy*(Hx(1:Nz-2)-Hx(2:Nz-1));    
    %equation for H field
    Hx(1:Nz-2) = Hx(1:Nz-2) + mHx*(Ey(1:Nz-2)-Ey(2:Nz-1)); 
    %graph figure
    figure(1);
    plot(Ey);
    axis([0 Nz -2 2]);
    xlabel('Z(mm)');
    ylabel('Ey(V/m)')
    movie = getframe(gcf);
    writeVideo(vidObj,movie);
end
close(vidObj);
