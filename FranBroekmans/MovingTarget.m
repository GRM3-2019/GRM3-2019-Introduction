classdef MovingTarget < target    
    properties
        deltaAoA
    end
    
    methods
        function NewMovingTarget=MovingTarget(AoA,range,signal)
            NewMovingTarget=NewMovingTarget@target(AoA,range,signal)
            NewMovingTarget.deltaAoA=deltaAoA
        end
    end
end

