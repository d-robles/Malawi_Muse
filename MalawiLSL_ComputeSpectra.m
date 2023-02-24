%function [open_spectra, open_spectra_front, F] = MalawiLSL_ComputeSpectra(path, sub, F, wavenum)
function[open_spectra,F] = MalawiLSL_ComputeSpectra(path, sub, F, wavenum)

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

%% plot EEG
% 
% figure; subplot(3,1,1); plot(timepoints,log(data));
%  axis tight
% % %  
% figure; plot(timepoints,log(data));
%  axis tight


%% wavelet

F = 1:.5:30;
wavenum = 10;

[B1] = log(BOSC_tf(data(1,:),F,srate,wavenum));
[B4] = log(BOSC_tf(data(4,:),F,srate,wavenum));
% plot spectrogram

% subplot(2,1,1);
%     imagesc(timepointm,F,B1);
%         set(gca,'Ydir','normal');
%         xlabel('Time (min)');
%         ylabel('Frequency (Hz)');
% %         colormap(hot)
% 
% subplot(2,1,2);
%      imagesc(timepointm,F,B4);
%         set(gca,'Ydir','normal');
%         xlabel('Time (min)');
%         ylabel('Frequency (Hz)');   

        
%% Find markers
% 11 and 12 = eyes open 1st and 2nd block
% 21 and 22 = eyes closed 1st and 2nd block
% 1 and 2 = eyes open 1st or eyes closed 1st


% mrk_ids = find(rawdata(:,7)>0);
% mrk_vals = rawdata(rawdata(:,7)>0,7);
% block_length_ids = round(block_length/period);
% 
% 
% closed_win_1 = [mrk_ids(mrk_vals == 21) mrk_ids(mrk_vals == 21) + block_length_ids];
% open_win_1 =   [mrk_ids(mrk_vals == 11) mrk_ids(mrk_vals == 11) + block_length_ids];
% 
% 
%      
     
%% Spectra

% %first blocks
% closed_spectra_1_B1 = mean(B1(:,closed_win_1(1):closed_win_1(2)),2);
% closed_spectra_1_B4 = mean(B4(:,closed_win_1(1):closed_win_1(2)),2);
% open_spectra_1_B1 = mean(B1(:,open_win_1(1):open_win_1(2)),2);
% open_spectra_1_B4 = mean(B4(:,open_win_1(1):open_win_1(2)),2);

%%Average Spectra

% closed_spectras = [closed_spectra_1_B1,closed_spectra_1_B4];
% closed_spectra = mean(closed_spectras,2);
open_spectras = [B1,B4];
open_spectra = mean(open_spectras,2);





% 
% plot spectra
% figure; 
%     boundedline(F,squeeze(mean(open_spectra(:,:),2)));
%     legend('open');
%     ylabel('Power (uV^2)');
%     xlabel('Frequency (Hz)');
%     title(num2str(sub));
%     
%     squeeze(mean(open_spectra(:,:),2))
%     