# MATLAB DSP — Signals and Systems Analysis

MATLAB implementations of discrete-time signal
generation, signal decomposition, and system
response analysis developed as part of Digital
Signal Processing coursework at the University
of the Philippines Diliman.

## Files Included

### Signal Generators

| File | Description |
|------|-------------|
| `sig_1.m` | Sinusoidal signal generator |
| `sig_2.m` | Trapezoidal signal generator with ramp and flat regions |
| `sig_3.m` | Decaying exponential signal generator |

### Signal Decomposition

| File | Description |
|------|-------------|
| `even.m` | Computes even part of a signal: (x[n] + x[-n]) / 2 |
| `odd.m`  | Computes odd part of a signal: (x[n] - x[-n]) / 2 |

### Discrete-Time Systems

| File | Description |
|------|-------------|
| `sys_1.m` | FIR system with current and delayed input |
| `sys_2.m` | IIR system with recursive output feedback |
| `sys_3.m` | IIR system via convolution with impulse response |
| `sys_4.m` | IIR system with variable delay parameter L |

## Key Concepts Covered

- Discrete-time signal generation
- Even and odd signal decomposition
- FIR and IIR system implementation
- Impulse response and convolution
- Recursive difference equations
- Transfer function analysis using impz and conv

## How to Use

    % Generate a sinusoidal signal of length N
    x = sig_1(100);

    % Decompose into even and odd parts
    [x_even, ind] = even(x, 1);
    [x_odd,  ind] = odd(x, 1);

    % Pass through systems
    y1 = sys_1(x);
    y2 = sys_2(x);
    y3 = sys_3(x);
    y4 = sys_4(x, L);

## Technologies Used
- **Language:** MATLAB
- **Functions:** impz, conv, zeros, fliplr
- **Concepts:** Discrete-Time Signals, Even/Odd
  Decomposition, FIR Systems, IIR Systems,
  Impulse Response, Convolution, Difference
  Equations, Transfer Functions

## Course
Digital Signal Processing — Electronics Engineering
University of the Philippines Diliman

## Status
Completed — University Machine Problem
