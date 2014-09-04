function plotStuff(~)
clf
close
maxAoA = 2;
% Acc = 99;
% TWR = zeros(Acc, 2);
% rpm = zeros(Acc, 2);
% torque = zeros(Acc, 2);
% motorpower = zeros(Acc, 2);
% PowerInduced = zeros(Acc, 2);
% motorElectricalPower = zeros(Acc, 2);
Acc = 20;

j = 1;
increment = (2/Acc);
%this loops through AoA
for l = 0:1:maxAoA
    %this loops through TWR
    i = 1;
    for k=0.1:increment:2;
        %if i >0.1
        [TWR(i, j), rpm(i, j), torque(i, j), motorpower(i, j), PowerInduced(i, j), motorElectricalPower(i, j)] = rpmRequiredQuiet(k,l);
        i = i + 1;
        %end
    end
    j = j + 1
end

j = 1;
%for l = 0:1:maxAoA
    figure(1)
    hold on;
    plot(TWR, motorpower);
    title('Motor Power vs. Thrust to Weight Ratio')
    xlabel('Thrust to Weight Ratio')
    ylabel('Power (Watts)')
    
    figure(2)
    hold on;
    plot(TWR, PowerInduced, '--');
    title('Power Induced vs. Thrust to Weight Ratio')
    xlabel('Thrust to Weight Ratio')
    ylabel('Power (Watts)')
    %legend(['Motor Power, AoA: ', num2str(j)], ['Power Induced, AoA: ', num2str(j)], ['Electrical Power, AoA: ', num2str(j)])
    
    figure(3)
    hold on;
    plot(TWR, motorElectricalPower, ':');
    title('Electrical Power vs. Thrust to Weight Ratio')
    xlabel('Thrust to Weight Ratio')
    ylabel('Power (Watts)')
    
    figure(4)
    hold on;
    plot(TWR, (torque*1000));
    title('Torque vs. Thrust to Weight Ratio')
    xlabel('Thrust to Weight Ratio')
    ylabel('Torque (Nmm)')
    
    
    figure(5)
    hold on;
    plot(TWR, rpm);
    title('RPM Required vs. Thrust to Weight Ratio')
    xlabel('Thrust to Weight Ratio')
    ylabel('RPM Required')
    %j = j + 1;
%end
end

