% Define the main folder path
mainFolder = 'Location where the data is stored';
allData = {};
% ++++++++++++++++++++++++++++Loop through folder of subjects having sampling rate 256 Hz++++++++++++++++++++++++++++++++++
for i = 1:subjects %(subjects = only the folders of subjects having sampling rate of 256 Hz)
    subfolderName = sprintf('AD%d', i);
    subfolderPath = fullfile(mainFolder, subfolderName);
    if isfolder(subfolderPath)
        matFiles = dir(fullfile(subfolderPath, '*.mat'));
        for j = 1:length(matFiles)
           matFilePath = fullfile(matFiles(j).folder, matFiles(j).name);
            data = load(matFilePath);
            fieldNames = fieldnames(data);
            for k = 1:numel(fieldNames)
                signal = data.(fieldNames{k});
                if size(signal, 1) > 256 % Ensuring the signal has enough samples
                    % Downsample from 256 Hz to 128 Hz (factor of 2)
                    downsampledSignal = downsample(signal, 2);
                    allData{end+1} = downsampledSignal;
                else
                    warning('Signal in %s is not long enough for downsampling.', matFilePath);
                end
            end
        end
    else
        warning('Subfolder %s does not exist.', subfolderPath);
    end
end

% +++++++++++++++++++++++++Loop through folder of subjects having sampling rate 128 Hz+++++++++++++++++++++++++++++++++++++++++++++++++++++ 
allData1 = {};
for i = 1:subjects %(subjects = only the folders of subjects having sampling rate of 128 Hz)
    subfolderName = sprintf('AD%d', i);
    subfolderPath = fullfile(mainFolder, subfolderName);
    if isfolder(subfolderPath)
        matFiles = dir(fullfile(subfolderPath, '*.mat'));
        for j = 1:length(matFiles)
            matFilePath = fullfile(matFiles(j).folder, matFiles(j).name);
            data = load(matFilePath);
            fieldNames = fieldnames(data);
            for k = 1:numel(fieldNames)
                allData1{end+1} = data.(fieldNames{k}); % Add each variable to the cell array
            end
        end
    else
        fprintf('Folder %s does not exist.\n', subfolderName);
    end
end
AD =  [allData, allData1];

for i = 1:301
    AD{i} = AD{i}';
end
% making all cell double
for i = 1:301
    AD{i} = double(AD{i});
end
% rearranging
AD=AD';
%% ===========================Segmentation =======================================================================================
% for AD (segmentation of AD data in  5 seconds)
Fs = "sampling rate";
num_samples_to_select = 5*Fs;
selected_samples_AD = cell(size(AD));
for i = 1:numel(AD)
    current_data = AD{i};
    num_samples = size(current_data, 2);
    num_iterations = floor(num_samples / num_samples_to_select);
    selected_data = cell(1, num_iterations);
    for j = 1:num_iterations
        start_index = (j - 1) * num_samples_to_select + 1;
        end_index = min(j * num_samples_to_select, num_samples);
        selected_data{j} = current_data(:, start_index:end_index);
    end
    selected_samples_AD{i} = selected_data;
end
a = [];
for i = 1:numel(selected_samples_AD)
    num_iterations_j = numel(selected_samples_AD{i});
    for j = 1:num_iterations_j
        a = [a; selected_samples_AD{i}{j}];
    end
end
rows_per_cell = "number of channels";
num_cells = ceil(size(a, 1) / rows_per_cell);
cell_array_AD = cell(num_cells, 1);

for i = 1:num_cells
    start_row = (i - 1) * rows_per_cell + 1;
    end_row = min(i * rows_per_cell, size(a, 1));
    cell_array_AD{i} = a(start_row:end_row, :);
end
AD1 = cell_array_AD;
%% +++++++++++++++++++++++++++++++++++++++++++++++++++++ Butterworth bandpass filter (0.5 TO 40 Hz) +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
AD = AD1;
low_fc = 0.5;  % Lower cut-off frequency in Hz
high_fc = 40;  % Higher cut-off frequency in Hz
% Design a Butterworth bandpass filter (0.5–40 Hz)
[bf, af] = butter(4, [low_fc, high_fc] / (Fs / 2), 'bandpass');  % 4th order Butterworth bandpass
% Initialize data
AD1 = cell(size(AD)); 
for i = 1:length(AD)
    for j = 1:size(AD{i}, 1)  
        % Apply the Butterworth bandpass filter (0.5–40 Hz)
        AD1{i}(j, :) = filtfilt(bf, af, AD{i}(j, :));
    end
end
%% +++++++++++++++++++++++++++++++++++++++++++++++++++++ MTFR Generation +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Mode = "specify the number of modes you want to extract";
dur=5; % duration of the signal in seconds
for k = 1:numel(AD1)
        x=AD1{k,1};
   [u, u_hat, omega] = MVMD_ver(x, 6000, 0, Mode, 0, 0, 1e-5);
    u1(:,:,:)=permute(u,[3 1 2]);
    imf_ch1(:,:)=u1(1,1:8,:);
    imf_ch2(:,:)=u1(2,1:8,:);
    imf_ch3(:,:)=u1(3,1:8,:);
    imf_ch4(:,:)=u1(4,1:8,:);
    imf_ch5(:,:)=u1(5,1:8,:);
    imf_ch6(:,:)=u1(6,1:8,:);
    imf_ch7(:,:)=u1(7,1:8,:);
    imf_ch8(:,:)=u1(8,1:8,:);
    imf_ch9(:,:)=u1(9,1:8,:);
    imf_ch10(:,:)=u1(10,1:8,:);
    imf_ch11(:,:)=u1(11,1:8,:);
    imf_ch12(:,:)=u1(12,1:8,:);
    imf_ch13(:,:)=u1(13,1:8,:);
    imf_ch14(:,:)=u1(14,1:8,:);
    imf_ch15(:,:)=u1(15,1:8,:);
    imf_ch16(:,:)=u1(16,1:8,:);
    imf_ch17(:,:)=u1(17,1:8,:);
    imf_ch18(:,:)=u1(18,1:8,:);
    imf_ch19(:,:)=u1(19,1:8,:);

% Compute Instantaneous Amplitude (IA) and Instantaneous Frequency (IF) of each channel IMFs
    [instAmp_ch1,instFreq_ch1] = INST_FREQ_local(imf_ch1);
    [instAmp_ch2,instFreq_ch2] = INST_FREQ_local(imf_ch2);
    [instAmp_ch3,instFreq_ch3] = INST_FREQ_local(imf_ch3);
    [instAmp_ch4,instFreq_ch4] = INST_FREQ_local(imf_ch4);
    [instAmp_ch5,instFreq_ch5] = INST_FREQ_local(imf_ch5);
    [instAmp_ch6,instFreq_ch6] = INST_FREQ_local(imf_ch6);
    [instAmp_ch7,instFreq_ch7] = INST_FREQ_local(imf_ch7);
    [instAmp_ch8,instFreq_ch8] = INST_FREQ_local(imf_ch8);
    [instAmp_ch9,instFreq_ch9] = INST_FREQ_local(imf_ch9);
    [instAmp_ch10,instFreq_ch10] = INST_FREQ_local(imf_ch10);
    [instAmp_ch11,instFreq_ch11] = INST_FREQ_local(imf_ch11);
    [instAmp_ch12,instFreq_ch12] = INST_FREQ_local(imf_ch12);
    [instAmp_ch13,instFreq_ch13] = INST_FREQ_local(imf_ch13);
    [instAmp_ch14,instFreq_ch14] = INST_FREQ_local(imf_ch14);
    [instAmp_ch15,instFreq_ch15] = INST_FREQ_local(imf_ch15);
    [instAmp_ch16,instFreq_ch16] = INST_FREQ_local(imf_ch16);
    [instAmp_ch17,instFreq_ch17] = INST_FREQ_local(imf_ch17);
    [instAmp_ch18,instFreq_ch18] = INST_FREQ_local(imf_ch18);
    [instAmp_ch19,instFreq_ch19] = INST_FREQ_local(imf_ch19);

    instAmp(1,:,:)=instAmp_ch1;
    instAmp(2,:,:)=instAmp_ch2;
    instAmp(3,:,:)=instAmp_ch3;
    instAmp(4,:,:)=instAmp_ch4;
    instAmp(5,:,:)=instAmp_ch5;
    instAmp(6,:,:)=instAmp_ch6;
    instAmp(7,:,:)=instAmp_ch7;
    instAmp(8,:,:)=instAmp_ch8;
    instAmp(9,:,:)=instAmp_ch9;
    instAmp(10,:,:)=instAmp_ch10;
    instAmp(11,:,:)=instAmp_ch11;
    instAmp(12,:,:)=instAmp_ch12;
    instAmp(13,:,:)=instAmp_ch13;
    instAmp(14,:,:)=instAmp_ch14;
    instAmp(15,:,:)=instAmp_ch15;
    instAmp(16,:,:)=instAmp_ch16;
    instAmp(17,:,:)=instAmp_ch17;
    instAmp(18,:,:)=instAmp_ch18;
    instAmp(19,:,:)=instAmp_ch19;


    instFreq(1,:,:)=instFreq_ch1;
    instFreq(2,:,:)=instFreq_ch2;
    instFreq(3,:,:)=instFreq_ch3;
    instFreq(4,:,:)=instFreq_ch4;
    instFreq(5,:,:)=instFreq_ch5;
    instFreq(6,:,:)=instFreq_ch6;
    instFreq(7,:,:)=instFreq_ch7;
    instFreq(8,:,:)=instFreq_ch8;
    instFreq(9,:,:)=instFreq_ch9;
    instFreq(10,:,:)=instFreq_ch10;
    instFreq(11,:,:)=instFreq_ch11;
    instFreq(12,:,:)=instFreq_ch12;
    instFreq(13,:,:)=instFreq_ch13;
    instFreq(14,:,:)=instFreq_ch14;
    instFreq(15,:,:)=instFreq_ch15;
    instFreq(16,:,:)=instFreq_ch16;
    instFreq(17,:,:)=instFreq_ch17;
    instFreq(18,:,:)=instFreq_ch18;
    instFreq(19,:,:)=instFreq_ch19;
% Compute Joint Instantaneous Amplitude and Frequency by combining IA and
% IF functions of each channel
N=dur*Fs;
[m1,n1]=size(imf_ch2);
joint_inst_freq=zeros(m1,N);
         joint_inst_amp=zeros(m1,N);
        for j=1:N
            for i=1:m1
            temp_freq(:,:)=instFreq(:,i,j);    
            temp_amp(:,:)=instAmp(:,i,j);
            joint_inst_freq(i,j)=sum((temp_amp.^2).*temp_freq)/sum(temp_amp.^2);
            joint_inst_amp(i,j)=sqrt(sum(temp_amp.^2));
            end
        end
 % Finaly generate multivariate time-frequency (TF) representations. If you
 % wish to generate TF for a single channel then do not compute Joint IA
 % and IF functions in the previous section. Just provide IA and IF
 % matrices as input to the this section
        
freq = 2*pi*linspace(0,0.5,floor(N/2)+1);
        nfreq = length(freq);
        freq=freq/(2*pi);
        df = freq(2)-freq(1);     

        Tf = zeros(nfreq,N);
        dw=joint_inst_freq;
         for j=1:m1
            for m=1:N        
                 if dw(j,m)<0          
                 else
                     l = round(dw(j,m)/df+1);
                     if l>0 && l<=nfreq  && isfinite(l) 
                         Tf(l,m)=joint_inst_amp(j,m);     
                     end
                 end
            end
         end

N=dur*Fs; % Number of samples in a channel
t=(0:N-1)/Fs;
freq = 2*pi*linspace(0,0.5,floor(N/2)+1);
close all
figure(1)         
set(gcf, 'Position', [10 10 700 500]);
      
h=imagesc(1:length(Tf),freq*500,abs(Tf));   
set(gca,'YDir','normal');
colorbar;
lim = caxis;
caxis([0, 0.01]);
set(gca,'FontSize',1);
xlabel('Samples');
ylabel('Normalised Frequency');
ylim([0,1000]);
xlim([0,length(Tf)]);
axis off;
set(colorbar,'visible','off');

        cd('Locatiojn where you want to save the MTFRs');
        fn=strcat('ad',num2str(k),'.jpg');
        exportgraphics(gca,fn,'BackgroundColor','white');
end

%% +++++++++++++++++++++++++++++++++++  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 %                               Similarly, MTFRs are generated for HC and MCI subjects

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% READ MTRFs FROM THE FOLDER WHERE THEY WERE STORED %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
adPath = 'folder where the AD MTFRs are stored';
adImages = imageDatastore(adPath);
controlPath = 'folder where the HC (healthy control) MTFRs are stored';
controlImages = imageDatastore(controlPath);
MCIPath = 'folder where the MCI MTFRs are stored';
MCIImages = imageDatastore(MCIPath);

adLabels = repmat({'AD'}, numel(adImages.Files), 1);
controlLabels = repmat({'Control'}, numel(controlImages.Files), 1);
MCILabels = repmat({'MCI'}, numel(MCIImages.Files), 1);
labels = vertcat(controlLabels, adLabels, MCILabels);

data = imageDatastore(cat(1, controlImages.Files, adImages.Files, MCIImages.Files), 'Labels', labels);
labels = categorical(labels);
% Train Test Split
rng default
[trainImds,testImds] = splitEachLabel(data,0.8, 'randomized');
trainImages = readall(trainImds);
testImages = readall(testImds);

% Wavelet Image Scattering Transform (WIST)
sn = waveletScattering2('ImageSize',[644 780],'InvarianceScale',150,...
    'QualityFactors',[2 1],'NumRotations',[2 2]);
[~,npaths] = paths(sn);
sum(npaths)
coefficientSize(sn)
trainImages = cellfun(@(x) imresize(x, [644 780]), trainImages, 'UniformOutput', false);
testImages = cellfun(@(x) imresize(x, [644 780]), testImages, 'UniformOutput', false);
trainfeatures = cellfun(@(x)helperScatImages_mean(sn,x),trainImages,'Uni',0);
testfeatures = cellfun(@(x)helperScatImages_mean(sn,x),testImages,'Uni',0);
trainfeatures = cat(1,trainfeatures{:});
testfeatures = cat(1,testfeatures{:});

% converting to cell array
cellArray = cell(length(trainfeatures), 1);
for i = 1:length(trainfeatures)
    cellArray{i} = trainfeatures(i, :).';
end
cellArray_train=cellArray;

cellArray = cell(length(testfeatures), 1);

for i = 1:length(testfeatures)
    cellArray{i} = testfeatures(i, :).';
end
cellArray_test=cellArray;

trainLabels=categorical(trainImds.Labels);
testLabels=categorical(testImds.Labels);
%% Light Weight DNN
inputSize = sum(npaths);
numClasses = 3;
numHiddenUnits = "mention the number of hidden units for your DNN";
layers = [ ...
    sequenceInputLayer(inputSize)
    batchNormalizationLayer
    lstmLayer(numHiddenUnits,OutputMode="last")
    batchNormalizationLayer
    selfAttentionLayer(4, 16)
    dropoutLayer(0.5)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]

% set the hyperparameters
Maxepochs = "Maxepochs"; 
InitialLearnRate= "InitialLearnRate";
MiniBatchSize = "MiniBatchSize";
L2Regularization = "L2Regularization";

options = trainingOptions("adam", ...
    'ExecutionEnvironment', 'gpu', ...
    'MaxEpochs', Maxepochs, ...
    'InitialLearnRate', InitialLearnRate, ...
    'LearnRateDropPeriod', 100, ...
    'MiniBatchSize', MiniBatchSize, ...
    'L2Regularization', L2Regularization, ...
    'Plots', "training-progress", ...
    'Verbose', 0);

net = trainNetwork(cellArray_train,trainLabels,layers,options);

gpuInfo = gpuDevice;
disp(gpuInfo);

% Testing
YPred = classify(net, cellArray_test);
Accuracy = sum(YPred == testLabels) / numel(testLabels);

disp(['Test accuracy: ', num2str(Accuracy)]);