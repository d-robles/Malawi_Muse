%function [open_spectra, open_spectra_front, F] = MalawiLSL_ComputeSpectra(path, sub, F, wavenum)
function[open_spectra_shf,F] = MalawiLSL_SH_frontal(path, sub, F, wavenum)

%%
rawdata = importfile_lsl([path sub '_Malawi.csv']);
period = 0.00390625;
srate = 256;
 timepoints = period:period:length(rawdata)*period;
 timepointm = timepoints/60;     

%% subtract the mean

%whole
%data = rawdata(:,1:4)';

%first half
%data = rawdata(1:38400,1:4)';

%second half
data = rawdata(38401:end,1:4)';

mean_data = mean(data,2);

% 
% data(1,:) = data(1,:) / mean_data(1);
% data(2,:) = data(2,:) / mean_data(2);
% data(3,:) = data(3,:) / mean_data(3);
% data(4,:) = data(4,:) / mean_data(4);

F = 1:.5:30;
wavenum = 10;

[B2] = log(BOSC_tf(data(2,:),F,srate,wavenum));
[B3] = log(BOSC_tf(data(3,:),F,srate,wavenum));

open_spectras = [B2,B3];
open_spectra_shf = mean(open_spectras,2);