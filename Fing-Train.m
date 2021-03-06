clear;close all; clc
load subject_3.mat
train=data.train;
test= data.test;

%fing signals analysis-----------------------------------------------------
fing= cell2mat(train(2));
fing17=fing(17,:,:); %Cz
fing16=fing(16,:,:); %C3
fing18=fing(18,:,:); %C4
s17=size(fing17);
s16=size(fing16);
s18=size(fing18);

a17=zeros(s17(3),s17(2));
a16=zeros(s16(3),s16(2));
a18=zeros(s18(3),s18(2));

% fing17_Cz
for i=1:s17(3)
    a17(i,:)=fing17(1,:,i);
end
fing17=a17(1,:);
waveletFunction = 'db8';
[C,L] = wavedec(fing17,1,waveletFunction);
cD17 = detcoef(C,L,1); %arm
D17  = wrcoef('d',C,L,waveletFunction,1); %arm
fing17=D17;
N=length(fing17);
D17 = detrend(D17,0);
xdft = fft(D17);
freq = 0:N/length(D17):N/2;
xdft = xdft(1:length(D17)/2+1);
figure;subplot(321);plot(freq,abs(xdft));title('Fing-FREQUENCY-Ch17');
[~,I] = max(abs(xdft));
%fprintf('Fing Ch.17:Maximum occurs at %3.2f Hz.\n',freq(I));


% fing16_C3
for i=1:s16(3)
    a16(i,:)=fing16(1,:,i);
end
fing16=a16(1,:);
waveletFunction = 'db8';
[C,L] = wavedec(fing16,1,waveletFunction);
cD16 = detcoef(C,L,1); %arm
D16  = wrcoef('d',C,L,waveletFunction,1); %arm
fing16=D16;
N=length(fing16);
D16 = detrend(D16,0);
xdft = fft(D16);
freq = 0:N/length(D16):N/2;
xdft = xdft(1:length(D16)/2+1);
subplot(323);plot(freq,abs(xdft));title('Fing-FREQUENCY-Ch.16');
[~,I] = max(abs(xdft));
%fprintf('Fing Ch.16:Maximum occurs at %3.2f Hz.\n',freq(I));


% fing18_C4
for i=1:s18(3)
    a18(i,:)=fing18(1,:,i);
end
fing18=a18(1,:);
waveletFunction = 'db8';
[C,L] = wavedec(fing18,1,waveletFunction);
cD18 = detcoef(C,L,1); %arm
D18  = wrcoef('d',C,L,waveletFunction,1); %arm
fing18=D18;
N=length(fing18);
D18 = detrend(D18,0);
xdft = fft(D18);
freq = 0:N/length(D18):N/2;
xdft = xdft(1:length(D18)/2+1);
subplot(325);plot(freq,abs(xdft));title('Fing-FREQUENCY-Ch.18');
[~,I] = max(abs(xdft));
%fprintf('Fing Ch.18:Maximum occurs at %3.2f Hz.\n',freq(I));

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


noise17=abs(fing17-test17);
R17=corrcoef(test17,fing17);
SNR17=10*log((mean(noise17))^2/(mean(fing17))^2);

noise16=abs(fing16-test16);
R16=corrcoef(test16,fing16);
SNR16=10*log((mean(noise16))^2/(mean(fing16))^2);

noise18=abs(fing18-test16);
R18=corrcoef(test16,fing18);
SNR18=10*log((mean(noise18))^2/(mean(fing18))^2);

SNR=[SNR17 SNR16 SNR18]
if (SNR(1)<100 && SNR(2)<100 && SNR(3)<100) && (abs(R17(1,2))>.8 ...
                                          || abs(R16(1,2))>0.8...
                                          || abs((R18(1,2))>0.8))
    fprintf('The fing is moved!')
end
