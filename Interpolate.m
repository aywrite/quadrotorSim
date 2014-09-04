function [BestI] = Interpolate(CurrentValue, ValueArray)
i=1;
BestError = 32000; %THIS IS DODGY< FIX
for k=0:(length(ValueArray)-1)
    error = abs(ValueArray(i)-CurrentValue);
    if error < BestError
        BestError = error;
        BestI = i;
    end
    i=i+1;
end
end

