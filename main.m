2
clc
close all


 [fname path]=uigetfile('*.txt','-ascii');
% ld = input ('Enter the Lead column L :   '); 
% 
% fname=strcat(path,fname);
 y=load(fname );
%y=x(1:end,ld);


%y=load('Dataset_raw.txt','-ascii');


fs=1;% sampling Frequency
%N1=length(y);
%t=[0:N1-1]/fs; %time periode


figure;
plot(y,'b'); title('RAW ECG DATA PLOTTING');
xlabel('time (msec)')
ylabel('Amplitute (mv)')

% pause


[z, z1, z2, z3, z4]=baselineremoval(y,fs);



%Z=[x t' y y11 t1' ]
% Z1=[c];
% 
% Z2=[N1 fs];
% Z3=[D6 D5];
% Z4=[y11];

%x=z(:,1);  
y=z(:,1); 
c=z1(:,1);
fs=z2(:,1);
D10=z3(:,1); D9=z3(:,2); D8=z3(:,3);D7=z3(:,4); D6=z3(:,5);D5=z3(:,6);D4=z3(:,7);
y11=z4(:,1);

figure
plot(y);
hold on
plot(y11);
legend 'Original Data'...
        'Reconstructed Data'...

[e, e1]=detect_Rpeak(y11,fs,D10, D9, D8, D7, D6,D5, D4);


% E=[locs' qrspeaks]
% E1=[y2]


  locs=e(:,1);qrspeaks=e(:,2);
  y2=e1(:,1);
figure
plot (y11)
hold on
plot(y2); title ('R-peak region')

  
% x=e2(:,1); t=e2(:,2); y=e2(:,3); y11=e2(:,4); t1=e2(:,5);
% N1=e3(:,1); N11=e3(:,2); fs=e3(:,3);
% D6=e4(:,1); D5=e4(:,2);
% c=e5(:,1);

[d, d1]=dist_RRpeak(fs,qrspeaks,locs);

C=[locs, qrspeaks];

save('R_peakpoint.txt','C','-ascii','-tabs')


% D=[n1];

y11=D9+D8+D7+D6+D5+D4;
y11 = abs(y11).^1.5;


[b1, b2, b3, b4,b5]=comp_baselinepoint(fs,qrspeaks,locs,D10, D9, D8, D7, D6,D5, D4);



%  B1=[arr_lbt arr_rbt];
%  B2=[nl nr];
%  B3=[k5];
%  B4=[blp' blp_a];

arr_lbt=b1(:,1); arr_rbt=b1(:,2);
nl=b2(:,1); nr=b2(:,2);
k5=b3(:,1);
blp=b4(:,1); 
blp_a=b5(:,1);

figure;
plot(y11)
hold on
plot(locs,qrspeaks,'xr'); 
plot (blp,blp_a,'or'); title('Detected Base Line Point')   
xlabel('time')
ylabel('amplitude')
legend 'Data'...
       'R-Peak'...
       'BLP Point'...



MN=[blp,blp_a];

save('blp_point.txt','MN','-ascii','-tabs')

[u,n1, n2, n3, n4]=comp_beatmatrix(fs,locs,arr_lbt,arr_rbt,nl,nr,blp,blp_a,D10, D9, D8, D7, D6,D5, D4);


 save('beat_matrix.txt','u','-ascii','-tabs')
 

% N1=[arr_beat];
% N2=[a11];
% N3=[B];



arr_beat=n1
a11=n2(:,1);
B=n3(:,1);
N=n4(:,1);
arr_beat

N=size(arr_beat)
str1='Beat:-';
for l=1:N(1,2)
    n=l;
 str2=strcat(str1,int2str(l));
 
    a11=arr_beat(4:end,n)

[K,M]=size(a11);


B=[];
for i=1:K
    if (a11(i)~=0)
              
        B=[B;a11(i)];
    end
end
    
a11=B;

n=size(a11);
L=length(a11);
t11=0:1:L-1;
t11=t11*(1/fs);
t11=t11';
figure;

plot(a11); 
%title('Single Beat')
title(str2)



[m, m1, m2, m3, m4]=fiducialpoint1(fs,arr_beat,a11,B, N);

% M=[a11n];
% M1=[b3 b7 b8 b9];
% M2=[Rpeaks Rpeaklocs];
% M3=[Ploc1 Pamp1 Qloc1 Qamp1 Sloc1 Samp1 Tloc1 Tamp1 Ponloc1 Ponamp1 Qonloc1 Qonamp1 Soffloc1 Soffamp1 Toffloc1 Toffamp1 ] ;
% M4=[DD4 DD5 DD6 DD7];
a11n=m(:,1);
b3=m1(:,1); b7=m1(:,2); b8=m1(:,3); b9=m1(:,4);
Rpeaks=m2(:,1); Rpeaklocs=m2(:,2);
Ploc1=m3(:,1); Pamp1=m3(:,2); Qloc1=m3(:,3); Qamp1=m3(:,4); Sloc1=m3(:,5); Samp1=m3(:,6); Tloc1=m3(:,7); Tamp1=m3(:,8); Ponloc1=m3(:,9); Ponamp1=m3(:,10); Qonloc1=m3(:,11); Qonamp1=m3(:,12); Soffloc1=m3(:,13); Soffamp1=m3(:,14); Toffloc1=m3(:,15); Toffamp1=m3(:,16);
DD4=m4(:,1); DD5=m4(:,2); DD6=m4(:,3); DD7=m4(:,4);DD8=m4(:,5);

N=size(arr_beat);
% 
% for l=1:N(1,2)
%     n=l;
%     a11=arr_beat(4:end,n);
%     [K,M]=size(a11);
% 
% 
% B=[];
% for i=1:K
%     if (a11(i)~=0)
%               
%         B=[B;a11(i)];
%     end
% end
    
%a11=B;
a11n=DD4+DD5+DD6+DD7+DD8;
 str3='Wavelet Reconstruction of Beat:-';
 str4=strcat(str3,int2str(l));
 
 size(a11)
 
 
 figure;
 plot(a11)
 hold on
 plot(a11n); title(str4)
%end

% for l=1:N(1,2)
%     n=l;
%     a11=arr_beat(4:end,n);
%     [K,M]=size(a11);
% 
% 
% B=[];
% for i=1:K
%     if (a11(i)~=0)
%               
%         B=[B;a11(i)];
%     end
% end
%     
% a11=B;
str5='R-peak of Beat:-';

str6=strcat(str5,int2str(l)); 
figure;

plot(a11n)
hold on
plot(Rpeaklocs,Rpeaks,'rx'),title(str6)
%end

% for l=1:N(1,2)
%     n=l;
%     a11=arr_beat(4:end,n);
%     [K,M]=size(a11);
% 
% 
% B=[];
% for i=1:K
%     if (a11(i)~=0)
%               
%         B=[B;a11(i)];
%     end
% end
%     
% a11=B;
str7='Fiducial point of Beat:-';

str8=strcat(str7,int2str(l)); 
figure;                 
plot (a11n)
hold on
plot(Ploc1,Pamp1, 'og')
plot(Qloc1,Qamp1, 'ob')
plot(Rpeaklocs,Rpeaks,'rx')
plot(Sloc1,Samp1, 'xg')
plot(Tloc1,Tamp1, 'og')
plot(Ponloc1,Ponamp1, 'xm')
plot(Qonloc1,Qonamp1, 'Xm')
plot(Soffloc1,Soffamp1, 'om')
plot(Toffloc1,Toffamp1, 'om');
title(str8)
legend 'ECG Signal'...
       'P-wave'...
       'Q-wave'...
       'R-peak'...
       'S-wave'...
       'T-wave'...
       'P-onset'...
       'Q-onset'...
       'S-offset'...
       'Toffset'
M3=[Ploc1 Pamp1 Qloc1 Qamp1 Sloc1 Samp1 Tloc1 Tamp1 Ponloc1 Ponamp1 Qonloc1 Qonamp1 Soffloc1 Soffamp1 Toffloc1 Toffamp1 ] ;  
XZ=[];

XZ=[XZ;M3];
save('fiducial_point.txt','XZ','-ascii','-tabs')


[o, o1, o2, o3]=segment(a11n,fs,b3,b7,b8,b9,arr_beat,N);
%O=[x1];
% O1=[x2];
% O2=[x3];
% O3=[x4];


x1=o(:,1); x2=o1(:,1); x3=o2(:,1); x4=o3(:,1);

str9='From P-onset to T-offset of Beat:-'; 
str10=strcat(str9,int2str(l)); 
figure
plot(x4); title(str10)

str11='Zone 1:From P-onset to Q-Wave of Beat:-'; 
str12=strcat(str11,int2str(l)); 
figure
plot(x1); title(str12)

x2=a11n(b3+1:b7);
str13='Zone 2:From Q-wave to S-offset of Beat:-'; 
str14=strcat(str13,int2str(l)); 
figure
plot(x2); title(str14)

str15='Zone 3:From S-offset to T-offset of Beat:-'; 
str16=strcat(str15,int2str(l)); 
figure
plot(x3); title(str16)

end
