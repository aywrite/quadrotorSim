function [Pos, Vel, Acc, Ori, Aph] = Main(EndTime, AoA)
%#codegen
%Run script to initilise varialbes and import model
%time1=cputime;
ConstantsAndSpecs; 
%Declare Global Variables, those already defined in ConstantsAndSpecs
global InitialOrientation;
global InitialPosition;
global InitialVelocity;
%global NoTimeSteps;
global ProcessFrequency;

%import Aerofoil Data
disp('Importing Data...');
AerofoilData = xlsread('AerofoilData');
%import Motor Data
%filename = 'MotorSpeeds';
%TimeArray = xlsread(filename, 'A:A');
%Motor2Speed = xlsread(filename, 'C:C');
%Motor3Speed = xlsread(filename, 'D:D');
%Motor4Speed = xlsread(filename, 'E:E');
disp('Done');

%Setup Initial conditions, @time 0
Orientation = InitialOrientation;
Position = InitialPosition;
Velocity = InitialVelocity;
Omega = [0,0,0];
Alpha = [0,0,0];
Acceleration = [0, 0, 0];
MotorSpeeds = [0,0,0,0];


%{
given condition
is current = condition
yes -> do nothing
else
change current
recheck
%}




%Calculate Time increment to solve with, Initialise counters
TimeStepSize = 1/ProcessFrequency;
i=1;
MaxSimTime =ProcessFrequency*EndTime;

%Pre-Allocate Matricies for storing telemetry, used only for post flight
%analysis (PFA), not part of solution code. NB PreAlloc is for speed.
Pos = zeros(MaxSimTime, 3);
Vel = zeros(MaxSimTime, 3);
Acc = zeros(MaxSimTime, 3);
Ori = zeros(MaxSimTime, 3);
Aph = zeros(MaxSimTime, 3);
%Set Up Animation
close
clf
AnimationPlot = figure('units','normalized','outerposition',[0 0 1 1]);
global PlotMatrix;
PlotMatrix = zeros((ProcessFrequency*EndTime), 5, 'double');
%Begin solving for each time step
for k=0:MaxSimTime
    
    %Store values for PFA
    Ori(i, :) = Orientation; %store the current orientation for PFA
    Aph(i, :) = Alpha; %Store the current Angular Acceleration for PFA
    Pos(i, :) = Position; %Position for PFA
    Vel(i, :) = Velocity; %Velocity for PFA
    Acc(i, :) = Acceleration; %Acceleration for PFA
    
    %Find the current Time Value
    %CurrentTime = TimeStepSize*k;
    %Get the current Index from the Time Array
    %j = GetArrayIndex(CurrentTime, TimeArray);
    
    %Get Desired Motor Speed from control Algorithm
    [MotorSpeeds] = GetSpeeds(Orientation, Omega, Alpha, Position, Velocity, Acceleration, MotorSpeeds);
    
    %Update Forces
    [Moment, MotorThrust] = UpdateForces(MotorSpeeds(1), MotorSpeeds(2), MotorSpeeds(3), MotorSpeeds(4), AoA, AerofoilData);
        
    %Update Angular Quantities
    [Orientation, Omega, Alpha] = UpdateAngulars(Orientation, Omega, Moment, TimeStepSize);
        
    %Update Translational Quantities
    [Position, Velocity, Acceleration] = UpdateTranslationals(Position, Velocity, MotorThrust, Orientation, TimeStepSize);
        
    %Increment the counter
    AnimationPlot= PositionAnimation(i, Pos(i, :), Ori(i, :), EndTime, AnimationPlot, MotorSpeeds);
    
    i = i+1;
end

disp('Finished Simulation');
%PositionAnimation(Pos, Vel, Acc, Ori, Aph, EndTime);
%RunTime = cputime-time1;
end

