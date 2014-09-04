function [TWR, rpm, torque, motorpower, PowerInduced, motorElectricalPower] = rpmRequired(TWR, AoA)
initialGuess = 800;
[rads, torque, motorpower, TotalThrust] = radsRequired(TWR, initialGuess, AoA);
rpm = (rads*30)/pi;
motorElectricalPower = motorpower/(0.8);

global rho;
global BladeRadius;

%inducedVelocity
VelocityInduced = ((TotalThrust/4)/(2*rho*(4*pi*BladeRadius^2)))^(0.5);
PowerInduced = VelocityInduced*(TotalThrust/4);

disp(['For a TWR of ',num2str(TWR)])
disp(['Required RPM: ', num2str(rpm)])
disp(['Torque: ', num2str(torque*1000), ' Nmm'])
disp(['Motor Power: ', num2str(motorpower), ' W'])
disp(['Power Induced: ', num2str(PowerInduced), ' W'])
disp(['Electrical Power: ', num2str(motorElectricalPower), ' W'])

end

