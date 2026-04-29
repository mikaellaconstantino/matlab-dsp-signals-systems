function res = circ_conv(x1, x2)
% =========================================================
% ECE 161 - Machine Problem 2
% Problem 4: Circular Convolution
%
% Computes the N-point circular convolution of two finite-
% duration sequences x1 and x2 using the DFT multiplication
% property (frequency-domain approach).
%
% Inputs:
%   x1  - first input sequence  (length L1)
%   x2  - second input sequence (length L2)
%
% Output:
%   res - N-point circular convolution, rounded to nearest
%         integer. Length = N.
%
% Parameters:
%   N = max(length(x1), length(x2))  [as specified in MP]
%
% Theory:
%   The N-point circular convolution is defined as:
%     y[n] = sum_{m=0}^{N-1} x1[m] * x2((n-m) mod N)
%
%   By the DFT circular convolution property:
%     DFT[x1 circonv x2] = X1[k] * X2[k]
%
%   Therefore, circular convolution in the time domain
%   is equivalent to pointwise multiplication in the
%   frequency domain — which is the fast approach used
%   here via the FFT.
%
%   Algorithm:
%     1. Zero-pad both sequences to length N
%     2. Compute X1 = FFT(x1), X2 = FFT(x2)
%     3. Multiply pointwise: Y[k] = X1[k] * X2[k]
%     4. Inverse FFT: y = IFFT(Y)
%     5. Round to nearest integer (as required)
% =========================================================

% Step 1: Determine N and zero-pad both inputs to length N
N  = max(length(x1), length(x2));
x1 = [x1 zeros(1, N - length(x1))];
x2 = [x2 zeros(1, N - length(x2))];

% Step 2: Transform both sequences to frequency domain
X1 = fft(x1, N);
X2 = fft(x2, N);

% Step 3 & 4: Pointwise multiply then inverse transform
%             real() removes floating-point imaginary noise
%             round() satisfies the integer output requirement
res = round(real(ifft(X1 .* X2, N)));

end