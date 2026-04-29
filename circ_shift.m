function y = circ_shift(x, m, N)
% =========================================================
% ECE 161 - Machine Problem 2
% Problem 3: Circular Shifting
%
% Computes the N-point circular shift of sequence x by m
% positions using the frequency-domain approach.
%
% Inputs:
%   x - input sequence of length N1 (N1 <= N)
%   m - number of positions to shift (right shift)
%   N - DFT length (defines the circular buffer size)
%
% Output:
%   y - circularly shifted sequence: y[n] = x((n-m) mod N)
%       length N
%
% Theory:
%   A circular shift by m in the time domain corresponds
%   to multiplication by the twiddle factor W_N^{km} in
%   the frequency domain:
%
%     DFT[x((n-m)_N)] = W_N^{km} * X[k]
%     where W_N = e^{-j*2*pi/N}
%
%   So the algorithm is:
%     1. Zero-pad x to length N
%     2. Take DFT: X = fft(x, N)
%     3. Multiply by twiddle factors: Y[k] = W_N^{mk} * X[k]
%     4. Take IDFT: y = ifft(Y, N)
% =========================================================

% Step 1: Zero-pad x to length N (handles N1 <= N case)
x = [x zeros(1, N - length(x))];

% Step 2: DFT of the zero-padded sequence
X  = fft(x, N);

% Step 3: Multiply by twiddle factor W_N^{mk} for k=0,...,N-1
%         W_N = e^{-j*2*pi/N} is the fundamental twiddle factor
%         W_N^{mk} applies the circular shift in frequency domain
WN = exp(-1j * 2 * pi / N);
k  = 0:N-1;
Y  = (WN .^ (m * k)) .* X;

% Step 4: IDFT back to time domain
%         real() removes floating-point imaginary residue
y = real(ifft(Y, N));

% ---------------------------------------------------------
% Plot: original (zero-padded) and circularly shifted signal
% ---------------------------------------------------------
figure;
subplot(2,1,1);
stem(0:N-1, x, 'b', 'filled');
ylabel('x(n)');
title(sprintf('Original x(n) and Circular Shift by m=%d, N=%d', m, N));
grid on;

subplot(2,1,2);
stem(0:N-1, y, 'r', 'filled');
ylabel('y(n)');
xlabel('n');
title('Circularly Shifted  y(n) = x((n-m))_N');
grid on;

end