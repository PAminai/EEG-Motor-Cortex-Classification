clear;close all; clc
load subject_1.mat
train=data.train;
test= data.test;
%initialization
Leg=0;
Arm=0;
NaN=0;
Fing=0;

%arm signals analysis------------------------------------------------------
arm= cell2mat(train(1));
arm17=arm(17,:,:); %Cz
arm16=arm(16,:,:); %C3
arm18=arm(18,:,:); %C4
s17=size(arm17);
s16=size(arm16);
s18=size(arm18);

a17=zeros(s17(3),s17(2));
a16=zeros(s16(3),s16(2));
a18=zeros(s18(3),s18(2));

% arm17_Cz
for i=1:s17(3)
    a17(i,:)=arm17(1,:,i);
end
arm17=a17(1,:);
waveletFunction = 'db8'; % 8 frequency component in fourier transform
[C,L] = wavedec(arm17,1,waveletFunction);
cD17 = detcoef(C,L,1); %arm
D17  = wrcoef('d',C,L,waveletFunction,1); %arm
arm17=D17;
N=length(arm17);
D17 = detrend(D17,0);
xdft = fft(D17);
freq = 0:N/length(D17):N/2;
xdft = xdft(1:length(D17)/2+1);
figure;subplot(321);plot(freq,abs(xdft));title('Arm Training Signal-Ch17');
[~,I] = max(abs(xdft));
%fprintf('Arm Ch.17:Maximum occurs at %3.2f Hz.\n',freq(I));


% arm16_C3
for i=1:s16(3)
    a16(i,:)=arm16(1,:,i);
end
arm16=a16(1,:);
waveletFunction = 'db8';
[C,L] = wavedec(arm16,1,waveletFunction);
cD16 = detcoef(C,L,1); %arm
D16  = wrcoef('d',C,L,waveletFunction,1); %arm
arm16=D16;
N=length(arm16);
D16 = detrend(D16,0);
xdft = fft(D16);
freq = 0:N/length(D16):N/2;
xdft = xdft(1:length(D16)/2+1);
subplot(323);plot(freq,abs(xdft));title('Arm Training Signal-Ch.16');
[~,I] = max(abs(xdft));
%fprintf('Arm Ch.16:Maximum occurs at %3.2f Hz.\n',freq(I));


% arm18_C4
for i=1:s18(3)
    a18(i,:)=arm18(1,:,i);
end
arm18=a18(1,:);
waveletFunction = 'db8';
[C,L] = wavedec(arm18,1,waveletFunction);
cD18 = detcoef(C,L,1); %arm
D18  = wrcoef('d',C,L,waveletFunction,1); %arm
arm18=D18;
N=length(arm18);
D18 = detrend(D18,0);
xdft = fft(D18);
freq = 0:N/length(D18):N/2;
xdft = xdft(1:length(D18)/2+1);
subplot(325);plot(freq,abs(xdft));title('Arm Training Signal-Ch.18');
[~,I] = max(abs(xdft));
%fprintf('Arm Ch.18:Maximum occurs at %3.2f Hz.\n',freq(I));

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
subplot(322);plot(freq,abs(xdft));title('Test Signal-Ch17');
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
subplot(324);plot(freq,abs(xdft));title('Test Signal-Ch.16');
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
subplot(326);plot(freq,abs(xdft));title('Test Signal-Ch.18');
[~,I] = max(abs(xdft));
%fprintf('Test Ch.18:Maximum occurs at %3.2f Hz.\n',freq(I));


noise17=abs(arm17-test17);
R17=corrcoef(test17,arm17);
SNR17=10*log((mean(noise17))^2/(mean(arm17))^2);

noise16=abs(arm16-test16);
R16=corrcoef(test16,arm16);
SNR16=10*log((mean(noise16))^2/(mean(arm16))^2);

noise18=abs(arm18-test16);
R18=corrcoef(test16,arm18);
SNR18=10*log((mean(noise18))^2/(mean(arm18))^2);

SNR_Arm=[SNR17 SNR16 SNR18];
R_Arm=[R17 R16 R18];

if (80<SNR_Arm(1)<100 && 80<SNR_Arm(2)<100 && 80<SNR_Arm(3)<100) 
    if ((abs(R17(1,2))>.8 &&  abs(R16(1,2))>0.8)) || ((abs(R16(1,2))>.8 &&  abs(R18(1,2))>0.8)) || ((abs(R17(1,2))>.8 &&  abs(R18(1,2))>0.8))
    Arm=1;                                  
    fprintf('The arm is moved!')
end
end


if Arm==0
close all; clc;    
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
figure;subplot(321);plot(freq,abs(xdft));title('Fing Training Signal-Ch17');
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
subplot(323);plot(freq,abs(xdft));title('Fing Training Signal-Ch.16');
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
subplot(325);plot(freq,abs(xdft));title('Fing Training Signal-Ch.18');
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
subplot(322);plot(freq,abs(xdft));title('Test Signal-Ch17');
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
subplot(324);plot(freq,abs(xdft));title('Test Signal-Ch.16');
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
subplot(326);plot(freq,abs(xdft));title('Test Signal-Ch.18');
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

SNR_Fing=[SNR17 SNR16 SNR18];
R_Fing=[R17 R16 R18];

if (80<SNR_Fing(1)<100 && 80<SNR_Fing(2)<100 && 80<SNR_Fing(3)<100) 
   if ((abs(R17(1,2))>.8 &&  abs(R16(1,2))>0.8)) || ((abs(R16(1,2))>.8 &&  abs(R18(1,2))>0.8)) || ((abs(R17(1,2))>.8 &&  abs(R18(1,2))>0.8))
    Fing=1;                                  
    fprintf('The finger is moved!')
   end
end
end  



if Fing==0 && Arm==0
close all; clc;
%leg signals analysis-----------------------------------------------------
leg= cell2mat(train(3));
leg17=leg(17,:,:); %Cz
leg16=leg(16,:,:); %C3
leg18=leg(18,:,:); %C4
s17=size(leg17);
s16=size(leg16);
s18=size(leg18);

a17=zeros(s17(3),s17(2));
a16=zeros(s16(3),s16(2));
a18=zeros(s18(3),s18(2));

% leg17_Cz
for i=1:s17(3)
    a17(i,:)=leg17(1,:,i);
end
leg17=a17(1,:);
waveletFunction = 'db8';
[C,L] = wavedec(leg17,1,waveletFunction);
cD17 = detcoef(C,L,1); %leg
D17  = wrcoef('d',C,L,waveletFunction,1); %leg
leg17=D17;
N=length(leg17);
D17 = detrend(D17,0);
xdft = fft(D17);
freq = 0:N/length(D17):N/2;
xdft = xdft(1:length(D17)/2+1);
figure;subplot(321);plot(freq,abs(xdft));title('Leg Training Signal-Ch17');
[~,I] = max(abs(xdft));
%fprintf('Leg Ch.17:Maximum occurs at %3.2f Hz.\n',freq(I));


% leg16_C3
for i=1:s16(3)
    a16(i,:)=leg16(1,:,i);
end
leg16=a16(1,:);
waveletFunction = 'db8';
[C,L] = wavedec(leg16,1,waveletFunction);
cD16 = detcoef(C,L,1); %leg
D16  = wrcoef('d',C,L,waveletFunction,1); %leg
leg16=D16;
N=length(leg16);
D16 = detrend(D16,0);
xdft = fft(D16);
freq = 0:N/length(D16):N/2;
xdft = xdft(1:length(D16)/2+1);
subplot(323);plot(freq,abs(xdft));title('Leg Training Signal.16');
[~,I] = max(abs(xdft));
%fprintf('Leg Ch.16:Maximum occurs at %3.2f Hz.\n',freq(I));


% leg18_C4
for i=1:s18(3)
    a18(i,:)=leg18(1,:,i);
end
leg18=a18(1,:);
waveletFunction = 'db8';
[C,L] = wavedec(leg18,1,waveletFunction);
cD18 = detcoef(C,L,1); %leg
D18  = wrcoef('d',C,L,waveletFunction,1); %leg
leg18=D18;
N=length(leg18);
D18 = detrend(D18,0);
xdft = fft(D18);
freq = 0:N/length(D18):N/2;
xdft = xdft(1:length(D18)/2+1);
subplot(325);plot(freq,abs(xdft));title('Leg Training Signal-Ch.18');
[~,I] = max(abs(xdft));
%fprintf('leg Ch.18:Maximum occurs at %3.2f Hz.\n',freq(I));

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
subplot(322);plot(freq,abs(xdft));title('Test Signal-Ch17');
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
subplot(324);plot(freq,abs(xdft));title('Test Signal-Ch.16');
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
subplot(326);plot(freq,abs(xdft));title('Test Signal-Ch.18');
[~,I] = max(abs(xdft));
%fprintf('Test Ch.18:Maximum occurs at %3.2f Hz.\n',freq(I));


noise17=abs(leg17-test17);
R17=corrcoef(test17,leg17);
SNR17=10*log((mean(noise17))^2/(mean(leg17))^2);

noise16=abs(leg16-test16);
R16=corrcoef(test16,leg16);
SNR16=10*log((mean(noise16))^2/(mean(leg16))^2);

noise18=abs(leg18-test16);
R18=corrcoef(test16,leg18);
SNR18=10*log((mean(noise18))^2/(mean(leg18))^2);

SNR_Leg=[SNR17 SNR16 SNR18];
R_Leg=[R17 R16 R18];

if (80<SNR_Leg(1)<100 && 80<SNR_Leg(2)<100 && 80<SNR_Leg(3)<100) 
    if ((abs(R17(1,2))>.8 &&  abs(R16(1,2))>0.8)) || ((abs(R16(1,2))>.8 &&  abs(R18(1,2))>0.8)) || ((abs(R17(1,2))>.8 &&  abs(R18(1,2))>0.8))
    Leg=1;                                  
    fprintf('The leg is moved!')
    end
end



if Leg==0 && Arm==0 && Fing==0
close all, clc;
fprintf('NaN !!')
end

end












