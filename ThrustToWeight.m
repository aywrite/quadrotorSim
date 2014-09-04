function [TWR, torque, TotalThrust] = ThrustToWeight(MotorSpeed, AoA, AerofoilData)
ConstantsAndSpecs;
%AoA=0;
global g;
global m;
[Motor1Lift, Motor1Drag, MotorThrust, Motor1Torque] = MotorForces(MotorSpeed, AoA, AerofoilData);
TotalThrust = sum(MotorThrust)*4;
TWR = TotalThrust/(m*g);
torque = Motor1Torque;
end

