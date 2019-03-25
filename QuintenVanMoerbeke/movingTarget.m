classdef movingTarget<target % to inherit from target
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties %extra properties
        deltaAoA
    end
    
    %constructor for standard arguments and deltaAoA
    methods
         function thisTarget=movingTarget(AoA,range,signal,deltaAoA) %balloon = thisTarget, literally the command = constructor!, mostly on top of all the methods
            thisTarget@target(AoA,range,signal); 
            if nargin == 4 
                thisTarget.deltaAoA = deltaAoA;
            end  
         end
    end
end

