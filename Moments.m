function f=Moments(MotorLift, MotorTorque)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%function Setup%
global Motor1Offset;
global Motor2Offset;
global Motor3Offset;
global Motor4Offset;

LiftVector = [0,0,1];

%Calculate pitch and roll moments%
m1=cross((MotorLift(1)*LiftVector),(Motor1Offset));
m2=cross((MotorLift(2)*LiftVector),(Motor2Offset));
m3=cross((MotorLift(3)*LiftVector),(Motor3Offset));
m4=cross((MotorLift(4)*LiftVector),(Motor4Offset));
PitchRollMoment = m1+m2+m3+m4;
%Calculate Yaw Moment%
YawMoment=[0,0,((MotorTorque(1)+MotorTorque(4))-(MotorTorque(2)+MotorTorque(3)))];
%sum all moments%
Moments=PitchRollMoment+YawMoment;
f=Moments;

