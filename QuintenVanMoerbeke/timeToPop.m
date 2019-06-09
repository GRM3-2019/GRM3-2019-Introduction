function [t_end] = timeToPop(r, N_0, N_t)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

t_end = 1./r * log (N_t/N_0);

end

