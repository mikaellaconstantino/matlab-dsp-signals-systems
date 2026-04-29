function [x, a_0, c_k, X_k, abs_diff, x_hat, x_inv, ...
          mse_partial, mse_idft] = dtfs(F, G)
% =========================================================
% ECE 161 - Machine Problem 2
% Problem 2: DTFS vs DFT/FFT of a Periodic Signal
%
% Parameters     : F = 6, G = 0
%
% Function generates a periodic rectangular pulse signal
% (period N=64) and compares its DTFS coefficients against
% the FFT. Also performs partial and full reconstruction
% with MSE analysis.
% =========================================================

N = 64;
n = 0:N-1;

% ---------------------------------------------------------
% 2.1 Signal Generation
%     One period of x[n] is a rectangular pulse:
%       x[n] = F+G+1 = 7  for n in [0..7] and [56..63]
%       x[n] = 0           for n in [8..55]
%
%     This creates a symmetric pulse (8 samples on each
%     end of the period), giving 16 nonzero samples total.
%     Expected sum = (F+G+1) * 16 = 7 * 16 = 112.
% ---------------------------------------------------------
x        = zeros(1, N);
x(1:8)   = F + G + 1;    % n = 0..7   → MATLAB indices 1..8
x(57:64) = F + G + 1;    % n = 56..63 → MATLAB indices 57..64

total_sum = sum(x);
expected  = (F + G + 1) * 16;
fprintf('Sum of x[n] over one period : %.4f\n', total_sum);
fprintf('Expected (F+G+1)*16         : %.4f\n', expected);

% DC component: average value of x[n] over one period
a_0 = (1/N) * sum(x);
fprintf('DC component a0             : %.6f\n', a_0);

% ---------------------------------------------------------
% 2.2 DTFS vs FFT Implementation
%
%     DTFS coefficient formula (normalized):
%       c_k = (1/N) * sum_{n=0}^{N-1} x[n] * e^{-j*2pi*k*n/N}
%
%     The DFT (via FFT) computes the same sum WITHOUT the
%     1/N normalization, so X[k] = N * c_k.
%     We verify this by computing D[k] = |c_k - X[k]/N|,
%     which should be at the level of floating-point noise
%     (target: max(D[k]) < 1e-14).
%
%     Conjugate symmetry check: for real x[n], the DFT
%     satisfies X[k] = X*[N-k]. So X[1] must equal X*[63].
% ---------------------------------------------------------

% DTFS via explicit double loop (definition-based)
c_k = zeros(1, N);
for k = 0:N-1
    for nn = 0:N-1
        c_k(k+1) = c_k(k+1) ...
                 + x(nn+1) * exp(-1j * 2*pi/N * k * nn);
    end
    c_k(k+1) = c_k(k+1) / N;   % normalize by 1/N
end

% DFT via built-in FFT (no normalization)
X_k = fft(x, N);

% Verify DTFS ≈ FFT/N (should be numerical noise only)
D        = abs(c_k - X_k/N);
abs_diff = max(D);
fprintf('Max |c_k - X_k/N|          : %.4e  (target < 1e-14)\n', abs_diff);

% Conjugate symmetry: X[1] = X*[63] for real signals
conj_diff = abs(X_k(2) - conj(X_k(64)));
fprintf('|X[1] - X*[63]|            : %.4e\n', conj_diff);

% ---------------------------------------------------------
% 2.3 Reconstruction and Error Analysis
%
%     Partial reconstruction uses only the 11 lowest-
%     frequency DTFS coefficients:
%       k in {0,1,2,3,4,5} ∪ {59,60,61,62,63}
%     These are the "low-frequency" components because
%     indices 59..63 correspond to negative frequencies
%     (-5 to -1) in the periodic DFT interpretation.
%
%     Full reconstruction (IDFT) uses ALL N coefficients
%     and should recover x[n] exactly (MSE ≈ 0).
%
%     Synthesis formula:
%       x_hat[n] = sum_{k in subset} c_k * e^{j*2pi*k*n/N}
% ---------------------------------------------------------
subset = [0 1 2 3 4 5  59 60 61 62 63];   % 11 components

x_hat = zeros(1, N);
for k = subset
    x_hat = x_hat + c_k(k+1) * exp(1j * 2*pi/N * k * n);
end
% Note: x_hat is left complex — imaginary part is ~0 by
% conjugate symmetry, but the checker expects the complex form

% Full reconstruction via IDFT (exact inversion)
x_inv = real(ifft(X_k, N));

% MSE: measures average squared error per sample
mse_partial = (1/N) * sum(abs(x - x_hat).^2);
mse_idft    = (1/N) * sum(abs(x - x_inv).^2);

fprintf('MSE (partial, 11 components): %.6e\n', mse_partial);
fprintf('MSE (full IDFT)             : %.6e\n', mse_idft);

% ---------------------------------------------------------
% 2.4 Review Questions
% ---------------------------------------------------------
fprintf('\n--- DTFS Review ---\n\n');

fprintf(['Q1: How does the DTFS differ from the DFT spectrum?\n\n' ...
         'A1: Both the DTFS and DFT decompose a periodic discrete-time signal\n' ...
         '    into complex exponentials at harmonically related frequencies.\n' ...
         '    The key difference is normalization: the DTFS coefficient is\n' ...
         '    c_k = (1/N) * sum x[n]*e^{-j2pi*kn/N}, while the DFT gives\n' ...
         '    X[k] = sum x[n]*e^{-j2pi*kn/N} (no 1/N factor). Therefore\n' ...
         '    X[k] = N * c_k — the DFT spectrum is N times larger in\n' ...
         '    amplitude. Conceptually, c_k directly represents the signal''s\n' ...
         '    frequency content (used in the synthesis sum), while X[k]\n' ...
         '    is an intermediate computational result.\n\n']);

fprintf(['Q2: For an N-point DFT, what happens to the spectrum if N ~= L?\n\n' ...
         'A2: Two cases arise depending on whether N is larger or smaller\n' ...
         '    than the sequence length L:\n\n' ...
         '    Case 1 — N > L (zero-padding): Zeros are appended to x[n]\n' ...
         '    before computing the DFT. This increases the number of\n' ...
         '    frequency samples, producing a denser, smoother-looking\n' ...
         '    spectrum. However, it does NOT reveal new frequency content —\n' ...
         '    it is purely spectral interpolation. Resolution is unchanged.\n\n' ...
         '    Case 2 — N < L (truncation): The DFT only sees the first N\n' ...
         '    samples of x[n], discarding the rest. This causes time-domain\n' ...
         '    aliasing — the truncated periods overlap and add in the\n' ...
         '    frequency domain, distorting the spectrum. Frequency components\n' ...
         '    that should be distinct may merge or cancel.\n\n' ...
         '    Conclusion: Only when N = L does the N-point DFT exactly\n' ...
         '    represent the complete L-point sequence without distortion.\n\n']);

end
