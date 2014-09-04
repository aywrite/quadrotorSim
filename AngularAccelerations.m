function f=AngularAccelerations(Moments, Omega)

%Variables%
global Ix;
global Iy;
global Iz;
global ModelCd0;
global rho;

%ADD DRAG MODEL HERE, SOLVE SIMILAR TO BLADE LIFT/DRAG
%THIS IS DUMMY DATA%
AreaVertical = (0.3*0.3);
AreaHorizontal = (0.3*0.01+0.1*0.1);
Sx = abs(AreaVertical);
Sy = abs(AreaVertical);
Sz = abs(AreaHorizontal);
vx = Omega(1);
vy = Omega(2);
vz = Omega(3);
Dx = 0.5*rho*vx*abs(vx)*Sx*ModelCd0;
Dy = 0.5*rho*vy*abs(vy)*Sy*ModelCd0;
Dz = 0.5*rho*vz*abs(vz)*Sz*ModelCd0;
Drag = [Dx, Dy, Dz];
%END DUMMY DRAG

AngularAccelerations = [(Moments(1)-Dx)/Ix, (Moments(2)-Dy)/Iy, (Moments(3)-Dz)/Iz];
%AngularAccelerations = [(Moments(1))/Ix, (Moments(2))/Iy, (Moments(3))/Iz];
f=AngularAccelerations;

