function [Position, Velocity, Acceleration] = UpdateTranslationals(Position, Velocity, MotorThrust, Orientation, TimeStepSize)
%Store Current Values in Temp
OldVelocity = Velocity;
%Calculate Translation Accelerations
Acceleration = TranslationalAccelerations(MotorThrust, Orientation, Velocity);
%calculate the Velocity and Acceleration for the time frame
Velocity = (Acceleration)*TimeStepSize + Velocity;
Position = ((Velocity+OldVelocity)/2)*TimeStepSize + Position;
end

