function [rads, torque, motorpower, TotalThrust] = radsRequired(TWR, radsGuess, AoA)
AerofoilData = xlsread('AerofoilData');

error = 100;
maxError = 0.02;

while abs(error) > maxError
    [thrust, torque, TotalThrust] = ThrustToWeight(radsGuess, AoA, AerofoilData);
    error = (TWR-thrust)/TWR;
    radsGuess = radsGuess + error*radsGuess;
end

rads = radsGuess;
motorpower=torque*rads;
end

