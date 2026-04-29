function x = sig_1(N)
    n = 0:N-1;                        % time index starts at n=0
    x = sin(((0+1)*pi/100) * n);      % C=0, so (C+1)=1
end