function signal = mychirp(f1, f2, dur, fs)
%MYCHIRP Generate a linear frequency modulated chirp signal
%
% f1  = starting frequency (Hz)
% f2  = ending frequency (Hz)
% dur = duration (seconds)
% fs  = sampling frequency (optional, default = 8000 Hz)

if nargin < 4
    fs = 8000;
end

ts = 1/fs;          % sample period
t = 0:ts:dur;       % time vector

a = (f2 - f1) / (2 * dur);   % chirp rate
b = f1;

theta = 2*pi*(100 + b*t + a*t.*t);

signal = real(exp(1j * theta));   % create chirp signal

end