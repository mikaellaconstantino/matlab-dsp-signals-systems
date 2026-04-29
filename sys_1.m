function y = sys_1(x)
    N = length(x);
    y = zeros(1, N);          % pre-allocate output

    for n = 1:N
        if n < 2              % no x[n-1] exists yet (n=0 has no n=-1)
            y(n) = 2*x(n);
        else
            y(n) = 2*x(n) + (3/3)*x(n-1);
        end
    end
end