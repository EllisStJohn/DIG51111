signalAnalyzer

NoiseFs = 22050;
NoiseDur = 2;

Noise = randn(NoiseFs * NoiseDur, 1);
sound(Noise, NoiseFs);





%% Part 2 – Apply exported filter

a = 1;                          % FIR filter denominator
b = filt1.numerator;            % FIR filter coefficients

stem(b);                        % Plot impulse response


% --- Convolution method ---
newnoise1 = conv(Noise, b);


% --- Filter function method ---
newnoise2 = filter(b, a, Noise);


%% Make convolution output same length (optional but recommended)
newnoise1 = newnoise1(1:length(Noise));


%% Playback filtered signals
pause(2.5);
sound(newnoise1, NoiseFs);

pause(2.5);
sound(newnoise2, NoiseFs);


%% Length check
len = length(newnoise1)

