function [x_odd, ind_odd] = odd(x, ind)
    N = length(x);
    
    M = max(ind-1, N-ind);
    ind_odd = M + 1;
    L_out = 2*M + 1;
    
    x_padded = zeros(1, L_out);
    x_start = M - (ind-1) + 1;
    x_padded(x_start : x_start+N-1) = x;
    
    % Odd part: (x[n] - x[-n]) / 2
    x_odd = (x_padded - fliplr(x_padded)) / 2;
end