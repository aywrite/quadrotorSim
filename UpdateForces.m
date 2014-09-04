function [Moment, MotorThrust] = UpdateForces(Motor1Speed, Motor2Speed, Motor3Speed, Motor4Speed, AoA, AerofoilData)
    %Forces arising from each motor, from RPM%
    [Motor1Lift, Motor1Drag, Motor1Thrust, Motor1Torque] = MotorForces(Motor1Speed, AoA, AerofoilData);
    [Motor2Lift, Motor2Drag, Motor2Thrust, Motor2Torque] = MotorForces(Motor2Speed, AoA, AerofoilData);
    [Motor3Lift, Motor3Drag, Motor3Thrust, Motor3Torque] = MotorForces(Motor3Speed, AoA, AerofoilData);
    [Motor4Lift, Motor4Drag, Motor4Thrust, Motor4Torque] = MotorForces(Motor4Speed, AoA, AerofoilData);
    %Store these forces in vectors for each Force Type
    MotorLift = [Motor1Lift, Motor2Lift, Motor3Lift, Motor4Lift];
    MotorDrag = [Motor1Drag, Motor2Drag, Motor3Drag, Motor4Drag];
    MotorThrust = [Motor1Thrust, Motor2Thrust, Motor3Thrust, Motor4Thrust];
    MotorTorque = [Motor1Torque, Motor2Torque, Motor3Torque, Motor4Torque];
    %Calculate the Moments due to Lift Imbalances
    Moment = Moments(MotorLift, MotorTorque);
end

