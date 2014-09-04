%constants for model%

global g;
global rho;
global ProcessFrequency;

g=9.81;
rho = 1.225;

%Efficiencies
global EffectiveBladePercentage;
EffectiveBladePercentage = 0.98; 

%Modelling Constants
global NoIncrements;
global NoTimeSteps;

NoIncrements = 50;
NoTimeSteps = -1;
ProcessFrequency = 50;

%Initial Conditions%
global InitialOrientation;
global InitialPosition;
global InitialVelocity;

InitialOrientation = [0,0,0];
InitialPosition = [0,0,0];
InitialVelocity = [0,0,0];

%Specifications%
global m;
global BladeRadius;
global BladeRootWidth;
global BladeTipWidth;
global MotorLocation;
global HubRadius;
global BladeRootAoA;
global BladeTipAoA;
global BladeCl;
global BladesPerRotor;
global Motors;
global ModelCd0;
global MaxMotorSpeed;
global MinMotorSpeed;

m=0.9;
BladeRadius=0.07;
BladeRootWidth=0.015;
BladeTipWidth=0.007;
MotorLocation=0.115;
HubRadius=0.018;
BladeRootAoA = 10;
BladeTipAoA = 0.5;
BladeCl = 0.8;
BladesPerRotor = 2;
Motors = 4;
ModelCd0=1;
MaxMotorSpeed = 3500;
MinMotorSpeed = 0;
%effeciencies

%Moments of Inertia%
global Ix;
global Iy;
global Iz;

%Mass Moments of Inertia%
Ix = 0.001;
Iy = 0.001;
Iz = 0.002;


%Motor Locations/Offset if centre was (0,0,0)%
global Motor1Offset;
global Motor2Offset;
global Motor3Offset;
global Motor4Offset;
%Since Using an X configuration, Convert Vector Motor Location to Cartesian
%Motor Location
cMotorLocation = (MotorLocation)/(2^(0.5));
Motor1Offset = [-cMotorLocation,cMotorLocation,0];
Motor2Offset = [cMotorLocation,cMotorLocation,0];
Motor3Offset = [-cMotorLocation,-cMotorLocation,0];
Motor4Offset = [cMotorLocation,-cMotorLocation,0];