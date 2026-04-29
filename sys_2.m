function y = sys_2(x)
    N = length(x);
    y = zeros(1, N);

    for n = 1:N
        if n == 1             % no y[n-1] or y[n-2] exist
            y(n) = x(n);
        elseif n == 2         % only y[n-1] exists, no y[n-2] yet
            y(n) = x(n) - (3/3)*y(n-1);
        else                  % all terms available
            y(n) = x(n) - (3/3)*y(n-1) - (1/11)*y(n-2);
        end
    end
end