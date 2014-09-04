function plotStuff3(~)
clf
close
maxTWR = 2;
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

Acc = 20;

increment = (maxAoA/Acc);
%this loops through TWR
i = 1;
for l = 0.5:0.1:maxTWR
    %this loops through AoA
    
    for k=-2:increment:maxAoA;
        [TWR(i), rpm(i), torque(i), motorpower(i), PowerInduced(i), motorElectricalPower(i), AoA(i)] = rpmRequiredQuiet(l,k);
        i = i + 1;
    end
    i
end
    
    figure(1)
    hold on;
    scatter3(AoA, TWR, motorpower);
    title('Motor Power vs. Inflow Angle')
    xlabel('Inflow Angle (degrees)')
    ylabel('TWR')
    zlabel('Power (Watts)')
    %legend('0.5', '1', '1.5', '2')
    
    figure(2)
    hold on;
    scatter3(AoA, TWR, PowerInduced);
    title('Power Induced vs. Inflow Angle')
    xlabel('Inflow Angle (degrees)')
    ylabel('TWR')
    zlabel('Power (Watts)')
    %legend('0.5', '1', '1.5', '2')
    
    figure(3)
    hold on;
    scatter3(AoA, TWR, motorElectricalPower);
    title('Electrical Power vs. Inflow Angle')
    xlabel('Inflow Angle (degrees)')
    ylabel('TWR')
    zlabel('Power (Watts)')
    %legend('0.5', '1', '1.5', '2')
    
    figure(4)
    hold on;
    scatter3(AoA, TWR, (torque*1000));
    title('Torque vs. Inflow Angle')
    xlabel('Inflow Angle (degrees)')
    ylabel('TWR')
    zlabel('Torque (Nmm)')
    %legend('0.5', '1', '1.5', '2')
    
    figure(5)
    hold on;
    scatter3(AoA, TWR, rpm);
    title('RPM Required vs. Inflow angle')
    xlabel('Inflow Angle (degrees)')
    ylabel('TWR')
    zlabel('RPM Required')
    %legend('0.5', '1', '1.5', '2')
    
end

