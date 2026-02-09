%% Read in Audio
[sig, Fs] = audioread('pluck.wav'); % Read signal
sound(sig, Fs)
pause(3)

%% Create Echo Impulse Response (FIR)
delay_s = 0.25; % Echo delay (seconds)
D = round(delay_s * Fs); % Delay in samples

ir_len = 50000; % IR length (samples)
ir = zeros(ir_len, 1); % Create impulse response

ir(1) = 1; % Direct sound
ir(1 + 1*D) = 0.8; % 1st echo
ir(1 + 2*D) = 0.6; % 2nd echo
ir(1 + 3*D) = 0.45; % 3rd echo
ir(1 + 4*D) = 0.30; % 4th echo

%% Apply Convolution (Echo)
wet_sig = conv(ir, sig); % Convolve signal with echo IR

% Signal amplitude can grow with convolution, normalise output
wet_sig = wet_sig ./ (max(abs(wet_sig)) + eps);

% Play convolved output
sound(wet_sig, Fs)

%% Plot both signals (optional)
figure;
subplot(211), plot(sig); grid on;
title('Original (pluck.wav)'); xlabel('Sample'); ylabel('Amplitude');

subplot(212), plot(wet_sig); grid on;
title('Output with Echo (convolution)'); xlabel('Sample'); ylabel('Amplitude');