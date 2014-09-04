function [MotorSpeeds] = GetSpeeds(Orientation, Omega, Alpha, Position, Velocity, Acceleration, MotorSpeeds)
global MaxMotorSpeed;
global MinMotorSpeed;

DesiredPosition = [0,0,0];
x1 = DesiredPosition(1);
y1 = DesiredPosition(2);
z1 = DesiredPosition(3);
x2 = Position(1);
y2 = Position(2);
z2 = Position(3);
displacment = 5*((x2-x1)^2+(y2-y2)^2+(z2-z1)^2)^(0.5);
Int = 10;
P = 10;
if Position(3) < DesiredPosition(3)
    MotorSpeeds = MotorSpeeds + [displacment, displacment, displacment, displacment];
    if Acceleration(3) < 0
        MotorSpeeds = MotorSpeeds + [Int, Int, Int, Int];
    else
       MotorSpeeds = MotorSpeeds - [displacment, displacment, displacment, displacment];
    end
    if Velocity(3) < 0
       MotorSpeeds = MotorSpeeds + [P, P, P, P];
    else
       MotorSpeeds = MotorSpeeds - [displacment, displacment, displacment, displacment];
    end
else 
    MotorSpeeds = MotorSpeeds - [displacment, displacment, displacment, displacment];
    if Acceleration(3) > 0
        MotorSpeeds = MotorSpeeds - [Int, Int, Int, Int];
    else
       MotorSpeeds = MotorSpeeds + [displacment, displacment, displacment, displacment];
    end
    if Velocity(3) > 0
       MotorSpeeds = MotorSpeeds - [P, P, P, P];
    else
       MotorSpeeds = MotorSpeeds + [displacment, displacment, displacment, displacment];
    end
end
if MotorSpeeds(1) > MaxMotorSpeed
    MotorSpeeds = [MaxMotorSpeed, MaxMotorSpeed, MaxMotorSpeed, MaxMotorSpeed];
end
if MotorSpeeds(1) < MinMotorSpeed
    MotorSpeeds = [MinMotorSpeed, MinMotorSpeed, MinMotorSpeed, MinMotorSpeed];
end
end

