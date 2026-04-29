function x = sig_2(N)
    n = 0:N-1;
    x = zeros(1, N);

    for i = 1:N
        ni = n(i);
        if ni < 3*N/10
            x(i) = (2/20) * ni;          % ramp up: (C+2)/20 = 2/20
        elseif ni <= 7*N/10
            x(i) = 15*(0+2);             % flat top: 15*(C+2) = 30
        else
            x(i) = (2/20) * (N - ni);    % ramp down
        end
    end
end