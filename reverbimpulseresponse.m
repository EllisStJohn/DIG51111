%Echo on a digital signal using impulse response

%% Read in Audio
[sig, Fs] = audioread('pluck.wav'); % Read signal
sound(sig, Fs)
pause(3)

%% Read in Impulse Response
[h, Fs_h] = audioread('Church.wav'); % Read impulse response

%% Make Mono
h = sum(h,2);

sound(h, Fs_h)
pause(3)

%% Apply Convolution
% Check sample rates are same, if not resample.
if ~isequal(Fs, Fs_h)
sig = resample(sig, Fs_h, Fs);
end

% Apply convolution between signal and impulse response with conv function
wet_sig = conv(h, sig);

% Signal amplitude can grow with convolution, normalise output
wet_sig = wet_sig ./ max(abs(wet_sig));

% Play convolved output
sound(wet_sig, Fs_h)

%% Convolution can also be used to apply a filter
cutoff = 400;
normalised_freq = cutoff / (Fs_h/2);
filt_order = 51;

h2 = fir1(filt_order, normalised_freq, 'low');

sig2 = conv(h2, wet_sig);
sig2 = sig2 ./ max(abs(sig2));

sound(sig2, Fs_h)