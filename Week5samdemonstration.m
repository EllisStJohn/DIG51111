N = 51;
n = floor(N/2);

Fs = 10000;

% ----- LOW PASS -----
f_low = 500;
fc_low = f_low/Fs;                     % normalized (0 to 0.5)

h_low = 2*fc_low * sinc(2*fc_low*(-n:n));

% ----- HIGH PASS -----
f_high = 200;
fc_high = f_high/Fs;

h_high = sinc((-n:n)) - 2*fc_high * sinc(2*fc_high*(-n:n));

% ----- WINDOW -----
wind = flattopwin(length(h_low));

% Make column vectors
h_low = h_low(:);
h_high = h_high(:);
wind = wind(:);

% ----- Windowed filters -----
windowed_sinc_LP = wind .* h_low;
windowed_sinc_HP = wind .* h_high;

% ----- Plot frequency responses -----
figure;
freqz(h_low,1)
hold on
freqz(windowed_sinc_LP,1)
legend('Ideal LP','Windowed LP')

figure;
freqz(h_high,1)
hold on
freqz(windowed_sinc_HP,1)
legend('Ideal HP','Windowed HP')