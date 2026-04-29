# MATLAB DSP — Signals and Systems Analysis

MATLAB implementations of discrete-time signal
generation, signal decomposition, frequency domain
analysis, and system response developed as part of
Digital Signal Processing coursework at the
University of the Philippines Diliman.

## Machine Problem 1 — Time Domain Analysis

### Signal Generators

| File | Description |
|------|-------------|
| `sig_1.m` | Sinusoidal signal generator |
| `sig_2.m` | Trapezoidal signal with ramp and flat regions |
| `sig_3.m` | Decaying exponential signal generator |

### Signal Decomposition

| File | Description |
|------|-------------|
| `even.m` | Even part of a signal: (x[n] + x[-n]) / 2 |
| `odd.m`  | Odd part of a signal: (x[n] - x[-n]) / 2 |

### Discrete-Time Systems

| File | Description |
|------|-------------|
| `sys_1.m` | FIR system with current and delayed input |
| `sys_2.m` | IIR system with recursive output feedback |
| `sys_3.m` | IIR system via convolution with impulse response |
| `sys_4.m` | IIR system with variable delay parameter L |

## Machine Problem 2 — Frequency Domain Analysis

### Frequency Transforms

| File | Description |
|------|-------------|
| `dtft.m` | DTFT approximation and DFT comparison with zero-padding analysis |
| `dtfs.m` | DTFS vs FFT comparison with partial reconstruction and MSE analysis |

### Frequency Domain Operations

| File | Description |
|------|-------------|
| `circ_shift.m` | N-point circular shift via twiddle factor multiplication |
| `circ_conv.m`  | N-point circular convolution via FFT multiplication property |

## Key Concepts Covered

- Discrete-time signal generation
- Even and odd signal decomposition
- FIR and IIR system implementation
- Impulse response and convolution
- Recursive difference equations
- DTFT approximation and analysis
- DTFS vs DFT/FFT comparison
- Circular shifting via twiddle factors
- Circular convolution via FFT property
- Zero-padding and spectral interpolation
- MSE reconstruction analysis

## How to Use

    % Machine Problem 1
    x = sig_1(100);               % generate sinusoidal signal
    [x_even, ind] = even(x, 1);  % even decomposition
    [x_odd,  ind] = odd(x, 1);   % odd decomposition
    y1 = sys_1(x);                % FIR system
    y2 = sys_2(x);                % IIR system
    y3 = sys_3(x);                % IIR via impulse response
    y4 = sys_4(x, L);             % IIR with delay L

    % Machine Problem 2
    [s, d, d32, d64, d128] = dtft(0, 8);     % DTFT vs DFT
    [x, a0, ck, Xk, ~, ~, ~, ~, ~] = dtfs(6, 0); % DTFS analysis
    y = circ_shift(x, m, N);                  % circular shift
    r = circ_conv(x1, x2);                    % circular convolution

## Technologies Used
- **Language:** MATLAB
- **Functions:** fft, ifft, impz, conv, fliplr,
  stem, subplot, exp, zeros, real
- **Concepts:** Discrete-Time Signals, Even/Odd
  Decomposition, FIR/IIR Systems, DTFT, DTFS,
  DFT, FFT, Circular Convolution, Circular Shift,
  Twiddle Factors, Zero-Padding, MSE Analysis,
  Impulse Response, Transfer Functions

## Course
ECE 161 Digital Signal Processing
Electronics Engineering
University of the Philippines Diliman

## Status
Completed — University Machine Problems 1 and 2
