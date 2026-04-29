function x = sig_3(N)
    n = 0:N-1;
    x = ((2+1)/2) * exp(-n / (8+8+1));   % (A+1)/2 = 3/2, D+E+1 = 17
end