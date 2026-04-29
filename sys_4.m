function y = sys_4(x, L)

    N = length(x);

    % Numerator (input coefficients)
    b = [9/2];

    % Denominator (output coefficients)
    a = zeros(1, L+2);
    a(1)   = 1;
    a(L+1) = -6/4;
    a(L+2) = 1/8;

    % Impulse response
    h = impz(b, a, N);

    % Convolution
    yc = conv(x, h);
    y = yc(1:N);

end