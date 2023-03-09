%function [open_spectra, open_spectra_front, F] = MalawiLSL_ComputeSpectra(path, sub, F, wavenum)
function[open_spectra_front,F] = MalawiLSL_ComputeSpectra(path, sub, F, wavenum)

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
%data = rawdata(38401:end,1:4)';

mean_data = mean(data,2);

% 
% data(1,:) = data(1,:) / mean_data(1);
% data(2,:) = data(2,:) / mean_data(2);
% data(3,:) = data(3,:) / mean_data(3);
% data(4,:) = data(4,:) / mean_data(4);
% 
% %%%%%%%%%%% plot EEG
% 
%  %Channels separated
%  close all
%  figure;
%  subplot(4,1,1)
% 
%  plot(timepoints,data(1,:),'r');
%  legend ('TP9')
%  axis tight
%  
%  subplot(4,1,2)
%  plot(timepoints,data(2,:),'k');
%  legend ('AF7')
%  axis tight
% 
%  subplot(4,1,3)
%  plot(timepoints,data(3,:),'b');
%  legend ('AF8')
%  axis tight
%  
%  subplot(4,1,4)
%  plot(timepoints,data(4,:));
%  legend ('TP10')
%  axis tight
%   title ('Raw Signal Muse Channels');
% xlabel('Time (S)'); 
%   ylabel('Amplitude (uV)'); 

% %% Spectrogram 
% close all
F = 1:.5:30;
wavenum = 10;

[B2] = log(BOSC_tf(data(2,:),F,srate,wavenum));
[B3] = log(BOSC_tf(data(3,:),F,srate,wavenum));

% % plot spectrogram
% 
% subplot(2,1,1);
%     imagesc(timepointm,F,B2);
%         set(gca,'Ydir','normal');
%         xlabel('Time (min)');
%         ylabel('Frequency (Hz)');
% %         colormap(hot)
% 
% subplot(2,1,2);
%      imagesc(timepointm,F,B3);
%         set(gca,'Ydir','normal');
%         xlabel('Time (min)');
%         ylabel('Frequency (Hz)');   

%% Spectrogram frontal vs posterior


% B1B4 = (B1+B4)/2;
% B2B3 = (B2+B3)/2; 
% 
% close all
% subplot(2,1,1);
%     imagesc(timepointm,F,B1B4);
%         set(gca,'Ydir','normal');
%         title('Posterior Resting State Spectrogram')
%         xlabel('Time (min)');
%         ylabel('Frequency (Hz)');
% %         colormap(hot)
% 
% subplot(2,1,2);
%      imagesc(timepointm,F,B2B3);
%         set(gca,'Ydir','normal');
%         title('Anterior Resting State Spectrogram')
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
open_spectras = [B2,B3];
open_spectra_front = mean(open_spectras,2);





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