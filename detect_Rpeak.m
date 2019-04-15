function [E, E1]=detect_Rpeak(y11,fs,D10, D9, D8, D7, D6,D5, D4)

y11=D9+D8+D7+D6+D5+D4;
y11 = abs(y11).^1.5;


y2=D6+D5;




THR_SIG = max(y2)*0.5;
 
 k=size(y11);
% % k=length(y11);
% 
%t1=(0:k-1)/fs;
% 
% 
 t1=0:1:k(1,1)-1;

% [t1' y11]


size(y11)
size(t1)
size(y2)


[qrspeaks,locs] = findpeaks(y11,t1,'MinPeakHeight',THR_SIG, 'MinPeakDistance', 60);
figure
plot(t1,y11)
hold on
plot(locs,qrspeaks,'rx'); title('R - PEAK POINTS DETECTED IN ECG SIGNAL')    
xlabel('time')
ylabel('amplitude')


size(qrspeaks)
locs=locs';

E=[locs qrspeaks];
E1=[y2];
