function [samples, dtft_vals, dft32, dft64, dft128] = dtft(C, D)
% =========================================================
% ECE 161 - Machine Problem 2
% Problem 1: DTFT vs DFT/FFT of a Finite-Length Signal
%
% Student Number : 2023-08860
% Parameters     : C = 0, D = 8
%
% Function computes the DTFT approximation and DFTs (N=32,
% 64, 128) of a finite-length two-tone cosine signal x[n].
% =========================================================

% ---------------------------------------------------------
% 1.1 Signal Generation
%     x[n] = cos((C+0.5)/10 * pi * n)
%           + 0.5*cos((D+0.5)/10 * pi * n),  0 <= n <= 31
%
%     For our constants (C=0, D=8):
%       Tone 1 at omega = 0.05*pi rad/sample
%       Tone 2 at omega = 0.85*pi rad/sample
% ---------------------------------------------------------
n       = 0:31;
x       = cos((C + 0.5)/10 * pi * n) ...
        + 0.5 * cos((D + 0.5)/10 * pi * n);
samples = length(x);   % = 32 samples

figure;
stem(n, x, 'filled');
xlabel('n');
ylabel('x[n]');
title(sprintf('Finite-Length Signal x[n]  (C=%d, D=%d)', C, D));
grid on;

% ---------------------------------------------------------
% 1.2 DTFT Approximation
%     The DTFT is continuous in frequency. We approximate
%     it by evaluating at 1000 equally spaced points over
%     [-pi, pi]. More points = smoother, more accurate
%     approximation of the true continuous spectrum.
%
%     Formula:  X(e^jw) = sum_{n=0}^{31} x[n] * e^{-jwn}
%
%     Vectorized form: dtft_vals = x * exp(-j * n' * omega)
%       x         : (1 x 32) row vector
%       n'        : (32 x 1) column vector
%       n' * omega: (32 x 1000) outer product matrix
%     Result      : (1 x 1000) complex spectrum
% ---------------------------------------------------------
omega     = linspace(-pi, pi, 1000);
dtft_vals = x * exp(-1j * n' * omega);

figure;
plot(omega/pi, abs(dtft_vals));
xlabel('\omega / \pi  (normalized frequency)');
ylabel('|X(e^{j\omega})|');
title('DTFT Magnitude Spectrum');
grid on;

% ---------------------------------------------------------
% 1.3 DFT via FFT — 32 points
%     The N-point DFT samples the DTFT at exactly N
%     equally spaced frequencies: omega_k = 2*pi*k/N.
%     Since N = signal length here, no zero-padding occurs.
% ---------------------------------------------------------
dft32 = fft(x, 32);

figure;
stem(0:31, abs(dft32), 'filled');
xlabel('k  (DFT bin index)');
ylabel('|X[k]|');
title('32-point DFT Magnitude Spectrum');
grid on;

% ---------------------------------------------------------
% 1.4 Effect of Zero-Padding (N = 64 and N = 128)
%     Zero-padding adds zeros to x[n] before taking the
%     DFT. This increases the number of frequency samples,
%     making the spectrum look smoother — but it does NOT
%     add new frequency information. It is purely spectral
%     interpolation of the same 32-point signal.
% ---------------------------------------------------------
dft64  = fft(x, 64);
dft128 = fft(x, 128);

figure;
subplot(3,1,1);
stem(0:31,  abs(dft32),  'filled');
ylabel('|X[k]|'); title('N = 32');  grid on;

subplot(3,1,2);
stem(0:63,  abs(dft64),  'filled');
ylabel('|X[k]|'); title('N = 64');  grid on;

subplot(3,1,3);
stem(0:127, abs(dft128), 'filled');
ylabel('|X[k]|'); xlabel('k');
title('N = 128'); grid on;

sgtitle('Effect of Zero-Padding on DFT Magnitude');

% ---------------------------------------------------------
% 1.5 Review Questions
% ---------------------------------------------------------
fprintf('\n--- DTFT Review ---\n\n');

fprintf(['Q1: What happens if the DTFT frequency spacing is increased?\n\n' ...
         'A1: Increasing the frequency spacing means evaluating the DTFT at\n' ...
         '    fewer points across [-pi, pi]. This produces a coarser, lower-\n' ...
         '    resolution approximation of the true continuous spectrum. Fine\n' ...
         '    spectral features — such as closely spaced peaks or narrow\n' ...
         '    sidelobes — may be missed entirely or appear distorted. At the\n' ...
         '    extreme, if spacing equals 2*pi/N, the DTFT grid collapses to\n' ...
         '    exactly the N DFT frequency bins, recovering the DFT.\n\n']);

fprintf(['Q2: What frequency spacing should be used to match the N-point DFT?\n\n' ...
         'A2: The N-point DFT evaluates the DTFT at frequencies\n' ...
         '    omega_k = 2*pi*k/N for k = 0, 1, ..., N-1.\n' ...
         '    Therefore, the required frequency spacing is delta_omega = 2*pi/N.\n' ...
         '    For N = 32: delta_omega = 2*pi/32 = pi/16 ≈ 0.1963 rad/sample.\n' ...
         '    This is also why zero-padding (larger N) gives a finer spacing\n' ...
         '    and a denser — though not more informative — spectrum.\n\n']);

end