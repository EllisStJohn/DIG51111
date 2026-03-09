clc
clear
close all

% Parameters
f1 = 500;      % start frequency (Hz)
f2 = 3000;     % end frequency (Hz)
dur = 3;       % duration (seconds)
fs = 44100;    % sampling rate

% Generate chirp
signal = mychirp(f1, f2, dur, fs);

% Normalise signal to avoid clipping
signal = signal / max(abs(signal));

% Time vector for plotting
t = 0:1/fs:dur;

% Plot waveform
figure
plot(t, signal)
xlabel('Time (seconds)')
ylabel('Amplitude')
title('Generated Chirp Signal')
grid on

% Play sound in MATLAB
sound(signal, fs)

% Save as standard WAV file
audiowrite('mychirp_output.wav', signal, fs, 'BitsPerSample', 16);

disp('Chirp created and saved as mychirp_output.wav')