function [x_even, ind_even] = even(x, ind)
    N = length(x);
    
    % Find how far signal extends on each side of n=0
    M = max(ind-1, N-ind);     % maximum extent needed for symmetry
    ind_even = M + 1;           % n=0 is at this MATLAB index in output
    L_out = 2*M + 1;            % total output length (symmetric around 0)
    
    % Zero-pad x into a symmetric array
    x_padded = zeros(1, L_out);
    x_start = M - (ind-1) + 1; % where x(1) maps into x_padded
    x_padded(x_start : x_start+N-1) = x;
    
    % Even part: (x[n] + x[-n]) / 2
    % fliplr(x_padded) gives x[-n] since array is centered at n=0
    x_even = (x_padded + fliplr(x_padded)) / 2;
end