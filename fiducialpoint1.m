function [M, M1, M2, M3, M4]=fiducialpoint1(fs,arr_beat,a11,B, N)

 
L=length(a11);
t11=0:1:L-1;
t11=t11*(1/fs);
t11=t11';

 c= a11;
[c,l]=wavedec(c,10,'db5');
cA10= appcoef(c,l,'db5',10);
cD1=detcoef(c,l,1);
cD2=detcoef(c,l,2);
cD3=detcoef(c,l,3);
cD4=detcoef(c,l,4);
cD5=detcoef(c,l,5);
cD6=detcoef(c,l,6);
cD7=detcoef(c,l,7);
cD8=detcoef(c,l,8);
cD9=detcoef(c,l,9);
cD10=detcoef(c,l,10);


A10=wrcoef('a',c,l,'db5',10);
DD1=wrcoef('d',c,l,'db5',1);
DD2=wrcoef('d',c,l,'db5',2);
DD3=wrcoef('d',c,l,'db5',3);
DD4=wrcoef('d',c,l,'db5',4);
DD5=wrcoef('d',c,l,'db5',5);
DD6=wrcoef('d',c,l,'db5',6);
DD7=wrcoef('d',c,l,'db5',7);
DD8=wrcoef('d',c,l,'db5',8);
DD9=wrcoef('d',c,l,'db5',9);
DD10=wrcoef('d',c,l,'db5',10);


arr_beat
N=size(arr_beat)

for l=1:N(1,2)
    n=l;

    a11=arr_beat(4:end,n);
    
%  str3='Wavelet Reconstruction of Beat:-';
%  str4=strcat(str3,int2str(l));

a11n=DD4+DD5+DD6+DD7+DD8;
% figure;
%  plot(a11)
%  hold on
% plot(a11n); title(str4)
%end
 a11R=DD6+DD7;
% figure
% plot(a11R)



THR_SIG2 = max(a11R);

%a11n = abs(a11n).^2;
%for l=1:N(1,2)
  %  n=l;
[Rpeaks,Rpeaklocs] = findpeaks(a11n,t11,'MinPeakHeight',THR_SIG2);
% for l=1:N(1,2)
%     n=l;
% str5='R-peak of Beat:-';
% 
% str6=strcat(str5,int2str(l)); 
% figure;
% 
% plot(a11n)
% hold on
% plot(Rpeaklocs,Rpeaks,'rx'),title(str6)
%end

k=length(a11R(1:Rpeaklocs));
l=length(a11R(Rpeaklocs:end));



%P wave detection

a2=Rpeaklocs-(k-1):Rpeaklocs-25;

m3=max(a11n(a2));

b2=find(a11n(a2)==m3);

b2=b2(1);

b2=a2(b2);

Ploc1=b2;

Pamp1=m3;

kk=length(a11n(1:Ploc1));

%Q wave detection

a3=Rpeaklocs-50:Rpeaklocs;

m4=min(a11n(a3));

b3=find(a11n(a3)==m4);

b3=b3(1);

b3=a3(b3);

Qloc1=b3;

Qamp1=m4;

% T wave detection
a5=Rpeaklocs+25:Rpeaklocs+(l-1);

m6=max(a11n(a5));

b5=find(a11n(a5)==m6);

b5=b5(1);

b5=a5(b5);

Tloc1=b5;

Tamp1=m6;



%S-Wave Detection

a4=Rpeaklocs+5:Rpeaklocs+50;

m5=min(a11n(a4));

b4=find(a11n(a4)==m5);

b4=b4(1);

b4=a4(b4);

Sloc1=b4;

Samp1=m5;



% P-onset Detection
    
a8=Ploc1-(kk-1):Ploc1;

m9=min(a11n(a8));

b8=find(a11n(a8)==m9);

b8=b8(1);

b8=a8(b8);

Ponloc1=b8;

Ponamp1=m9;

%Q-onset Detection
    
a6=Ploc1:Qloc1-30;

m7=min(a11n(a6));

b6=find(a11n(a6)==m7);

b6=b6(1);

b6=a6(b6);

Qonloc1=b6;

Qonamp1=m7;
          
%S offset detection
a7=Sloc1+5:Sloc1+30;

m8=max(a11n(a7));

b7=find(a11n(a7)==m8);

b7=b7(1);

b7=a7(b7);

Soffloc1=b7;

Soffamp1=m8;


%T-offset Detection
 ll=length(a11n(Tloc1:end));
 
a9=Tloc1:Tloc1+(ll-1);

m10=min(a11n(a9));

b9=find(a11n(a9)==m10);

b9=b9(1);

b9=a9(b9);

Toffloc1=b9;

Toffamp1=m10;

%for l=1:N(1,2)
%    n=l;
% str7='Fiducial point of Beat:-';
% 
% str8=strcat(str7,int2str(l)); 
% figure;                 
% plot (a11n)
% hold on
% plot(Ploc1,Pamp1, 'og')
% plot(Qloc1,Qamp1, 'ob')
% plot(Rpeaklocs,Rpeaks,'rx')
% plot(Sloc1,Samp1, 'xg')
% plot(Tloc1,Tamp1, 'og')
% plot(Ponloc1,Ponamp1, 'xm')
% plot(Qonloc1,Qonamp1, 'Xm')
% plot(Soffloc1,Soffamp1, 'om')
% plot(Toffloc1,Toffamp1, 'om');
% title(str8)
% legend 'ECG Signal'...
%        'P-wave'...
%        'Q-wave'...
%        'R-peak'...
%        'S-wave'...
%        'T-wave'...
%        'P-onset'...
%        'Q-onset'...
%        'S-offset'...
%        'Toffset'
end
   disp('R-peak time')
   
Rpeaklocs

disp('R-peak amplitude')

Rpeaks
disp('P-peak time')

Ploc1
disp('P-peak amplitude')

Pamp1
disp('Q-peak time')

Qloc1

disp('Q-peak amplitude')

Qamp1

disp('S-peak timr')
Sloc1

disp('S-peak amplitude')

Samp1

disp('T-peak time')

Tloc1
disp('T-peak amplitude')


Tamp1

disp('P-onset time')

Ponloc1

disp('P-onset amplitude')

Ponamp1

disp('Q-onset time')


Qonloc1

disp('Q-onset amplitude')

Qonamp1

disp('S-offset time')

Soffloc1

disp('S-offset amplitude')
Soffamp1

disp('T-offset time')

Toffloc1

disp('T-offset amplitude')

Toffamp1



M=[a11n];
M1=[b3 b7 b8 b9];
M2=[Rpeaks Rpeaklocs];
M3=[Ploc1 Pamp1 Qloc1 Qamp1 Sloc1 Samp1 Tloc1 Tamp1 Ponloc1 Ponamp1 Qonloc1 Qonamp1 Soffloc1 Soffamp1 Toffloc1 Toffamp1 ] ;
M4=[DD4 DD5 DD6 DD7 DD8];

% XZ=[];
% XZ=[XZ;M3];


%segment(a11n,fs,b3,b7,b8,b9)




