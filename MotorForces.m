function [Lift, BladeDrag, BladeThrust,BladeTorque]=MotorForces(MotorSpeed, MotorAoA, AerofoilData)
%declare variables%

global rho;

global BladeRadius;
global HubRadius;
global BladeRootAoA;
global BladeTipAoA;
global BladeRootWidth;
global BladeTipWidth;
global BladesPerRotor;
global NoIncrements;
global MotorLocation;
global EffectiveBladePercentage;

%get Aerofoil Data into vectors
AoAArray = AerofoilData(:, 1);
ClArray = AerofoilData(:, 2);
CdpArray = AerofoilData(:, 3);
%
MotorAoA = degtorad(MotorAoA);

%set up paramters for numerical intergration%
incrementSize =(BladeRadius-HubRadius)/NoIncrements;
BladeStation = HubRadius:incrementSize:BladeRadius;
%optimisation- these declerations are not essential but make the code much faster%
BladeStationAoA=HubRadius:incrementSize:BladeRadius;
BladeStationWidth=HubRadius:incrementSize:BladeRadius;
BladeStationArea=HubRadius:incrementSize:BladeRadius;
BladeVelocity= HubRadius:incrementSize:BladeRadius;
LiftPerBlade= HubRadius:incrementSize:BladeRadius;
DragPerBlade= HubRadius:incrementSize:BladeRadius;
ThrustPerBlade= HubRadius:incrementSize:BladeRadius;
TorquePerBlade= HubRadius:incrementSize:BladeRadius;
%end optimisation%

%Intergrate Accross the blade
i=1;
for k=0:NoIncrements;
   %K all at once 
   AR = (BladeRadius-HubRadius)^2/(((BladeRootWidth+BladeTipWidth)/2)*(BladeRadius-HubRadius));
   e0=0.7;
   K = 1/(pi*e0*AR);
   
   %blade Twist 
   BladeStationAoA(i) = (BladeRootAoA-((BladeRootAoA-BladeTipAoA)/(HubRadius-BladeRadius))*(HubRadius-BladeStation(i))) + MotorAoA;
   %blade Taper
   BladeStationWidth(i) = (BladeRootWidth-((BladeRootWidth-BladeTipWidth)/(HubRadius-BladeRadius))*(HubRadius-BladeStation(i)));
   %Blade Area
   BladeStationArea(i) = ((BladeRadius-HubRadius)*BladeStationWidth(i))/NoIncrements; %esentially the trapazoidal method since in the centre of the station
   %Blade Velocity
   BladeVelocity(i) = MotorSpeed*BladeStation(i);
   %Get Cl at current station
   %BladeCl = ClArray(GetArrayIndex(BladeStationAoA(i), AoAArray));
   BladeCl = interp1(AoAArray, ClArray, BladeStationAoA(i)); %run this when you want graphs, otherwise just use the lookup above
   %Get Cd0 at current station
   BladeCd0 = CdpArray(GetArrayIndex(BladeStationAoA(i), AoAArray));
     
   %Lift Intergration%    
   LiftPerBlade(i) = 0.5*rho*(BladeVelocity(i)^2)*BladeStationArea(i)*BladeCl;
   if i >= (EffectiveBladePercentage*NoIncrements)
       LiftPerBlade(i) = 0;
   end
   %Drag Intergration%
   DragPerBlade(i) = 0.5*rho*(BladeVelocity(i)^2)*BladeStationArea(i)*(BladeCd0+K*BladeCl^2);
   %Thrust Intergration (always Vertical)%
   ThrustPerBlade(i) = LiftPerBlade(i)*cos(MotorAoA)-DragPerBlade(i)*sin(MotorAoA);
   %Torque Intergration%
   TorquePerBlade(i) = (LiftPerBlade(i)*sin(MotorAoA)+DragPerBlade(i)*cos(MotorAoA))*BladeStation(i);
   i = i+1;
end

% figure(1)
% scatter(BladeStation, LiftPerBlade, 1)
% title('Lift Distribution Over One Blade in Hover (TWR = 1.0, AoA = 0)')
% xlabel('Distance from Hub')
% ylabel('Lift (N)')

%Total Forces%
Lift = sum(LiftPerBlade)*BladesPerRotor;
BladeDrag = sum(DragPerBlade)*BladesPerRotor;
BladeThrust = sum(ThrustPerBlade)*BladesPerRotor;
BladeTorque = sum(TorquePerBlade)*BladesPerRotor;
%Ineffeciencies
BladeGap = (2^(0.5))*MotorLocation-2*BladeRadius;
%BladeGapLossFactor = 1-((0.29-(BladeGap/BladeRadius))*0.68);
BladeGapLossFactor = 0.85;
Lift = Lift*BladeGapLossFactor;
BladeThrust = BladeThrust*BladeGapLossFactor;
end