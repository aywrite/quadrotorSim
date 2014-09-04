function [Orientation, Omega, Alpha] = UpdateAngulars(Orientation, Omega, Moment, TimeStepSize)
%#codegen
%Calculate Angular Accelerations
Alpha = AngularAccelerations(Moment, Omega);
%Store Current Values in Temp
OldOmega = Omega;
%calculate the Angular Velocity and Acceleration for the time frame
Omega = (Alpha)*TimeStepSize + Omega;
AngularChange = ((Omega+OldOmega)/2)*TimeStepSize;
%convert to changes in pitch roll and yaw
Roll = AngularChange(1);
Pitch = AngularChange(2);
Yaw= AngularChange(3);


Heading = Orientation(3)+Yaw;
Elevation = Orientation(2) + Pitch;
Bank = Orientation(1) + Roll;
Orientation = [Bank, Elevation, Heading];
end
 
