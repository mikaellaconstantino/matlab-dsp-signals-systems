function y = sys_3(x)
    % y[n] = x[n] + 0*x[n-1] - (9/6)y[n-1] - (9/7)y[n-2]
    % Rearranged: y[n] + (9/6)y[n-1] + (9/7)y[n-2] = x[n]
    
    b = [1, 0];          % coefficients of x[n] and x[n-1] (C=0)
    a = [1, 9/6, 9/7];   % coefficients of y[n], y[n-1], y[n-2]

    h = impz(b, a)';     % compute impulse response h[n], transpose to row
    yc = conv(h, x);     % convolve: output = impulse response * input
    y = yc(1:length(x)); % trim back to original length
end