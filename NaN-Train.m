clear;close all; clc
load subject_1.mat
train=data.train;
test= data.test;

%NaN signals analysis-----------------------------------------------------
NaN= cell2mat(train(4));
NaN17=NaN(17,:,:); %Cz
NaN16=NaN(16,:,:); %C3
NaN18=NaN(18,:,:); %C4
s17=size(NaN17);
s16=size(NaN16);
s18=size(NaN18);

a17=zeros(s17(3),s17(2));
a16=zeros(s16(3),s16(2));
a18=zeros(s18(3),s18(2));

% NaN17_Cz
for i=1:s17(3)
    a17(i,:)=NaN17(1,:,i);
end
NaN17=a17(1,:);
waveletFunction = 'db8';
[C,L] = wavedec(NaN17,1,waveletFunction);
cD17 = detcoef(C,L,1); %NaN
D17  = wrcoef('d',C,L,waveletFunction,1); %NaN
NaN17=D17;
N=length(NaN17);
D17 = detrend(D17,0);
xdft = fft(D17);
freq = 0:N/length(D17):N/2;
xdft = xdft(1:length(D17)/2+1);
figure;subplot(321);plot(freq,abs(xdft));title('NaN-FREQUENCY-Ch17');
[~,I] = max(abs(xdft));
%fprintf('NaN Ch.17:Maximum occurs at %3.2f Hz.\n',freq(I));


% NaN16_C3
for i=1:s16(3)
    a16(i,:)=NaN16(1,:,i);
end
NaN16=a16(1,:);
waveletFunction = 'db8';
[C,L] = wavedec(NaN16,1,waveletFunction);
cD16 = detcoef(C,L,1); %NaN
D16  = wrcoef('d',C,L,waveletFunction,1); %NaN
NaN16=D16;
N=length(NaN16);
D16 = detrend(D16,0);
xdft = fft(D16);
freq = 0:N/length(D16):N/2;
xdft = xdft(1:length(D16)/2+1);
subplot(323);plot(freq,abs(xdft));title('NaN-FREQUENCY-Ch.16');
[~,I] = max(abs(xdft));
%fprintf('Leg Ch.16:Maximum occurs at %3.2f Hz.\n',freq(I));


% leg18_C4
for i=1:s18(3)
    a18(i,:)=NaN18(1,:,i);
end
NaN18=a18(1,:);
waveletFunction = 'db8';
[C,L] = wavedec(NaN18,1,waveletFunction);
cD18 = detcoef(C,L,1); %NaN
D18  = wrcoef('d',C,L,waveletFunction,1); %NaN
NaN18=D18;
N=length(NaN18);
D18 = detrend(D18,0);
xdft = fft(D18);
freq = 0:N/length(D18):N/2;
xdft = xdft(1:length(D18)/2+1);
subplot(325);plot(freq,abs(xdft));title('NaN-FREQUENCY-Ch.18');
[~,I] = max(abs(xdft));
%fprintf('NaN Ch.18:Maximum occurs at %3.2f Hz.\n',freq(I));

sprintf('\n\n');
% Test Proseccing
size_test=size(test);
%Ch.17 test
t17=zeros(size_test(3),size_test(2));
for i=1:size_test(3)
    t17(i,:)=test(17,:,i);
end
test17=t17(1,:);
%Ch.16 test
t16=zeros(size_test(3),size_test(2));
for i=1:size_test(3)
    t16(i,:)=test(16,:,i);
end
test16=t16(1,:);


%Ch.18 test
t18=zeros(size_test(3),size_test(2));
for i=1:size_test(3)
    t18(i,:)=test(18,:,i);
end
test18=t18(1,:);


waveletFunction = 'db8';
[C,L] = wavedec(test17,1,waveletFunction);
cD17 = detcoef(C,L,1); 
D17  = wrcoef('d',C,L,waveletFunction,1); 
test17=D17;
N=length(test17);
D17 = detrend(D17,0);
xdft = fft(D17);
freq = 0:N/length(D17):N/2;
xdft = xdft(1:length(D17)/2+1);
subplot(322);plot(freq,abs(xdft));title('Test-FREQUENCY-Ch17');
[~,I] = max(abs(xdft));
%fprintf('Test Ch.17:Maximum occurs at %3.2f Hz.\n',freq(I));


waveletFunction = 'db8';
[C,L] = wavedec(test16,1,waveletFunction);
cD16 = detcoef(C,L,1); 
D16  = wrcoef('d',C,L,waveletFunction,1); 
test16=D16;
N=length(test16);
D16 = detrend(D16,0);
xdft = fft(D16);
freq = 0:N/length(D16):N/2;
xdft = xdft(1:length(D16)/2+1);
subplot(324);plot(freq,abs(xdft));title('Test-FREQUENCY-Ch.16');
[~,I] = max(abs(xdft));
%fprintf('Test Ch.16:Maximum occurs at %3.2f Hz.\n',freq(I));


waveletFunction = 'db8';
[C,L] = wavedec(test18,1,waveletFunction);
cD18 = detcoef(C,L,1); 
D18  = wrcoef('d',C,L,waveletFunction,1); 
test18=D18;
N=length(test18);
D18 = detrend(D18,0);
xdft = fft(D18);
freq = 0:N/length(D18):N/2;
xdft = xdft(1:length(D18)/2+1);
subplot(326);plot(freq,abs(xdft));title('Test-FREQUENCY-Ch.18');
[~,I] = max(abs(xdft));
%fprintf('Test Ch.18:Maximum occurs at %3.2f Hz.\n',freq(I));


noise17=abs(NaN17-test17);
R17=corrcoef(test17,NaN17);
SNR17=10*log((mean(noise17))^2/(mean(NaN17))^2);

noise16=abs(NaN16-test16);
R16=corrcoef(test16,NaN16);
SNR16=10*log((mean(noise16))^2/(mean(NaN16))^2);

noise18=abs(NaN18-test16);
R18=corrcoef(test16,NaN18);
SNR18=10*log((mean(noise18))^2/(mean(NaN18))^2);

SNR=[SNR17 SNR16 SNR18]
if (SNR(1)<100 && SNR(2)<100 && SNR(3)<100) && (abs(R17(1,2))>.8 ...
                                          || abs(R16(1,2))>0.8...
                                          || abs((R18(1,2))>0.8))
    fprintf('NaN !!')
end
