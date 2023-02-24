close all
clear all
%%
folders = {'Patients'};
% %Less noisy subs 
subs = {'001';'002';'003';'004';'006';'008';'009';'010';'011';'013';'015';'016';'017';'020';
        '021';'022';'024';'025';'027';'032';'034';'035';'036'};
%subs = {'014'};    
nsubs = length(subs);
%%
overall_count = 0;
for i_fold = 1:length(folders)
path = 'M:\Data\Malawi\';
    overall_count = 0;
    path = [path  folders{i_fold} '\'];
    fprintf(['Current folder: ' folders{i_fold} '. \n']);
    for i_sub = 1:nsubs
        overall_count = overall_count +1;
        folder_list(overall_count) = i_fold;
        sub = subs{i_sub};
        fprintf(['Current subject: ' sub '. \n']);
        disp([path sub '_Malawi.csv'])

        [open_spectra_fhf(:,i_fold, overall_count), F] = MalawiLSL_FH_frontal(path, sub, folders{i_fold});

    end
end
overall_count1 = 0;
for i_fold = 1:length(folders)
path = 'M:\Data\Malawi\';
    overall_count1 = 0;
    path = [path  folders{i_fold} '\'];
    fprintf(['Current folder: ' folders{i_fold} '. \n']);
    for i_sub = 1:nsubs
        overall_count1 = overall_count1 +1;
        folder_list(overall_count1) = i_fold;
        sub = subs{i_sub};
        fprintf(['Current subject: ' sub '. \n']);
        disp([path sub '_Malawi.csv'])

        [open_spectra_fhp(:,i_fold, overall_count1), F] = MalawiLSL_FH_posterior(path, sub, folders{i_fold});

    end
end
overall_count2 = 0;
for i_fold = 1:length(folders)
path = 'M:\Data\Malawi\';
    overall_count2 = 0;
    path = [path  folders{i_fold} '\'];
    fprintf(['Current folder: ' folders{i_fold} '. \n']);
    for i_sub = 1:nsubs
        overall_count2 = overall_count2 +1;
        folder_list(overall_count2) = i_fold;
        sub = subs{i_sub};
        fprintf(['Current subject: ' sub '. \n']);
        disp([path sub '_Malawi.csv'])

        [open_spectra_shf(:,i_fold, overall_count2), F] = MalawiLSL_SH_frontal(path, sub, folders{i_fold});

    end
end
overall_count3 = 0;
for i_fold = 1:length(folders)
path = 'M:\Data\Malawi\';
    overall_count3 = 0;
    path = [path  folders{i_fold} '\'];
    fprintf(['Current folder: ' folders{i_fold} '. \n']);
    for i_sub = 1:nsubs
        overall_count3 = overall_count3 +1;
        folder_list(overall_count3) = i_fold;
        sub = subs{i_sub};
        fprintf(['Current subject: ' sub '. \n']);
        disp([path sub '_Malawi.csv'])

        [open_spectra_shp(:,i_fold, overall_count3), F] = MalawiLSL_SH_posterior(path, sub, folders{i_fold});

    end
end
%%
%First Half
close all
figure; %hold on;
subplot(1,2,1)
[hl]= boundedline(F,mean(open_spectra_fhf(:,:,:),3),std(open_spectra_fhf(:,:,:),[],3)/sqrt(sum(nsubs)),'b',...
    F,mean(open_spectra_fhp(:,:,:),3),std(open_spectra_fhp(:,:,:),[],3)/sqrt(sum(nsubs)),'r');
legend({'Frontal Spectra';'Posterior Spectra'});
ylabel('Power (uV^2)');
xlabel('Frequency (Hz)');
title('First Half of Recording Spectra');
axis tight
set(gca,'linewidth',3,'box','off','color','none','Layer','Top');
set(hl,'linewidth',3);

%second half
subplot(1,2,2)
[h2]= boundedline(F,mean(open_spectra_shf(:,:,:),3),std(open_spectra_shf(:,:,:),[],3)/sqrt(sum(nsubs)),'b',...
    F,mean(open_spectra_shp(:,:,:),3),std(open_spectra_shp(:,:,:),[],3)/sqrt(sum(nsubs)),'r');
legend({'Frontal Spectra';'Posterior Spectra'});
ylabel('Power (uV^2)');
xlabel('Frequency (Hz)');
title('Second Half of Recording Spectra');
axis tight
set(gca,'linewidth',3,'box','off','color','none','Layer','Top');
set(h2,'linewidth',3);


