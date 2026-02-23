%% Tutorial 5 - Windowed Sinc (Task 1 + Task 2)
% Task 1: Design a 61-point truncated sinc LPF (fc = 300 Hz, Fs = 4000 Hz)
%         Plot the truncated sinc (impulse response) and its spectrum.
% Task 2: Create a signal with 150 Hz and 800 Hz components, apply the filter,
%         and compare input vs output (time + frequency).

clear; clc; close all;

%% =========================
% Parameters (given)
%% =========================
Fs = 4000;          % Sampling frequency (Hz)
fc = 300;           % Cutoff frequency (Hz)
N  = 61;            % Number of taps (points)

%% =========================
% TASK 1: Design truncated sinc LPF
%% =========================
M = (N-1)/2;        % Midpoint (group delay in samples for symmetric FIR)
n = 0:N-1;          % 0..60
m = n - M;          % -30..+30 (centred index)

fcn = fc / Fs;                      % Normalised cutoff (cycles/sample)
h   = 2*fcn * sinc(2*fcn * m);       % Ideal LPF impulse response (truncated)

% --- Plot truncated sinc (impulse response) ---
figure('Name','Task 1: Truncated Sinc (Impulse Response)');
stem(n, h, 'filled'); grid on;
xlabel('n (samples)');
ylabel('h[n]');
title(sprintf('61-point Truncated Sinc LPF (fc=%d Hz, Fs=%d Hz)', fc, Fs));

% --- Plot spectrum / magnitude response ---
nfft = 4096;
[H, f] = freqz(h, 1, nfft, Fs);

figure('Name','Task 1: Filter Magnitude Response (dB)');
plot(f, 20*log10(abs(H) + 1e-12)); grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Response of Truncated Sinc LPF');
xlim([0 Fs/2]);

%% =========================
% TASK 2: Create 2-tone signal, apply filter, compare
%% =========================
f1 = 150;           % Hz (should pass)
f2 = 800;           % Hz (should be attenuated)

T  = 1.0;                           % seconds
t  = (0:1/Fs:T-1/Fs).';             % column vector time

% Input signal (two sine components)
x = sin(2*pi*f1*t) + sin(2*pi*f2*t);

% Apply FIR filter
y = filter(h, 1, x);

% Optional: align output by removing group delay (so time plots line up)
gd = M;                              % group delay (samples)
y_aligned = [y(gd+1:end); zeros(gd,1)];

% --- Time-domain comparison (zoom into first 50 ms) ---
Ns = round(0.05*Fs);                 % 50 ms worth of samples

figure('Name','Task 2: Time Domain (Input)');
plot(t(1:Ns), x(1:Ns)); grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Input Signal: 150 Hz + 800 Hz (First 50 ms)');

figure('Name','Task 2: Time Domain (Filtered Output)');
plot(t(1:Ns), y_aligned(1:Ns)); grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Output (Aligned): Sinc LPF fc = 300 Hz (First 50 ms)');

% --- Frequency-domain comparison (magnitude spectra) ---
NFFT = 8192;
X = fft(x, NFFT);
Y = fft(y, NFFT);

faxis = (0:NFFT/2) * (Fs/NFFT);

Xmag = abs(X(1:NFFT/2+1));
Ymag = abs(Y(1:NFFT/2+1));

figure('Name','Task 2: Magnitude Spectrum (Input vs Output)');
plot(faxis, 20*log10(Xmag + 1e-12)); hold on;
plot(faxis, 20*log10(Ymag + 1e-12));
grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Spectrum Comparison: Input vs Filtered Output');
legend('Input (150 + 800 Hz)', 'Output after Sinc LPF', 'Location','best');
xlim([0 Fs/2]);

% Optional: show peaks clearly with markers near expected frequencies
[~, idx150] = min(abs(faxis - 150));
[~, idx800] = min(abs(faxis - 800));
fprintf('Input magnitude @150 Hz: %.3f\n', Xmag(idx150));
fprintf('Input magnitude @800 Hz: %.3f\n', Xmag(idx800));
fprintf('Output magnitude @150 Hz: %.3f\n', Ymag(idx150));
fprintf('Output magnitude @800 Hz: %.3f\n', Ymag(idx800));
