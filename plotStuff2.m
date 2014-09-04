function plotStuff2(~)
clf
close
maxTWR = 1;
maxAoA = 10;

% Acc = 21;
% 
% TWR = zeros(Acc, (maxTWR/0.5));
% rpm = zeros(Acc, (maxTWR/0.5));
% torque = zeros(Acc, (maxTWR/0.5));
% motorpower = zeros(Acc, (maxTWR/0.5));
% PowerInduced = zeros(Acc,(maxTWR/0.5));
% motorElectricalPower = zeros(Acc, (maxTWR/0.5));
% AoA = zeros(Acc, 2);

Acc = 10;


j = 1;
increment = (maxAoA/Acc);
%this loops through TWR
for l = 1% 0.5:0.5:maxTWR
    %this loops through AoA
    i = 1;
    for k=-2:increment:maxAoA;
        [~, rpm(i, j), torque(i, j), motorpower(i, j), PowerInduced(i, j), motorElectricalPower(i, j), AoA(i, j)] = rpmRequiredQuiet(l,k);
        i = i + 1;
    end
    j = j + 1
end

    size(AoA)
    size(motorpower)
    
    figure(1)
    hold on;
    plot(AoA, motorpower);
    title('Motor Power vs. Inflow Angle')
    xlabel('Inflow Angle (degrees)')
    ylabel('Power (Watts)')
    legend('0.5', '1', '1.5', '2')
    
    figure(2)
    hold on;
    plot(AoA, PowerInduced, '--');
    title('Power Induced vs. Inflow Angle')
    xlabel('Inflow Angle (degrees)')
    ylabel('Power (Watts)')
    legend('0.5', '1', '1.5', '2')
    
    figure(3)
    hold on;
    plot(AoA, motorElectricalPower, ':');
    title('Electrical Power vs. Inflow Angle')
    xlabel('Inflow Angle (degrees)')
    ylabel('Power (Watts)')
    legend('0.5', '1', '1.5', '2')
    
    figure(4)
    hold on;
    plot(AoA, (torque*1000));
    title('Torque vs. Inflow Angle')
    xlabel('Inflow Angle (degrees)')
    ylabel('Torque (Nmm)')
    legend('0.5', '1', '1.5', '2')
    
    figure(5)
    hold on;
    plot(AoA, rpm);
    title('RPM Required vs. Inflow angle')
    xlabel('Inflow Angle (degrees)')
    ylabel('TWR')
    zlabel('RPM Required')
    legend('0.5', '1', '1.5', '2')
    
end

