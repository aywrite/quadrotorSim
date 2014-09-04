function accelerations = TranslationalAccelerations(MotorThrust, Orientation, Velocity)
%#codegen
global m;
global g;
global rho;
global ModelCd0;

%calculate the angle of the model
Bank = Orientation(1);
Elevation = Orientation(2);
Heading = Orientation(3);
%set up the rotation matrix
Rx = [1,0,0; 0, cos(Bank), -sin(Bank); 0, sin(Bank), cos(Bank)];
Ry = [cos(Elevation), 0, sin(Elevation); 0,1,0; -sin(Elevation),0,cos(Elevation)];
Rz = [cos(Heading), -sin(Heading),0; sin(Heading), cos(Heading),0;0,0,1];
Rcombined = Rz*Ry*Rx;
%Calculate the Total Thrust From The Model
TotalThrust = sum(MotorThrust);
%TWR = TotalThrust/(m*g)
%Convert Thrust to Inertial Coordinates
TotalThrustInertial = Rcombined*([0,0,TotalThrust]');

%CalculateDrag Opposing Motion%
%THIS IS DUMMY DATA%
AreaVertical = (0.3*0.3);
AreaHorizontal = (0.3*0.01+0.1*0.1);
Sx = abs(AreaVertical*sin(Bank)+AreaHorizontal*cos(Bank));
Sy = abs(AreaVertical*sin(Elevation)+AreaHorizontal*cos(Elevation));
Sz = abs(AreaVertical*cos(Bank)*cos(Elevation)+AreaHorizontal*sin(Bank)*sin(Elevation));
vx = Velocity(1);
vy = Velocity(2);
vz = Velocity(3);
Dx = 0.5*rho*vx*abs(vx)*Sx*ModelCd0;
Dy = 0.5*rho*vy*abs(vy)*Sy*ModelCd0;
Dz = 0.5*rho*vz*abs(vz)*Sz*ModelCd0;
Drag = [Dx, Dy, Dz];
%END DUMMY DRAG

%Calculate the Thrust Forces on the model in inertial Coordinates
xThrust = TotalThrustInertial(1);
yThrust = TotalThrustInertial(2);
zThrust = TotalThrustInertial(3);
%Combine With Drag
xForces = -xThrust - Drag(1);
yForces = -yThrust - Drag(2);
zForces = zThrust - m*g-Drag(3);

xA = xForces/m;
yA = yForces/m;
zA = zForces/m;
accelerations = [xA, yA, zA];
end

