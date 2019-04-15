function [O, O1, O2, O3]=segment(a11n,fs,b3,b7,b8,b9,arr_beat,N)

    
x4=a11n(b8:b9);
L41=length(x4);
t42=0:1:L41-1;
t42=t42*(1/fs);
t42=t42';
   
x1=a11n(b8:b3);
L11=length(x1);
t12=0:1:L11-1;
t12=t12*(1/fs);
t12=t12';
M=length(x1);
K1=1:length(M);
Y1=x1;
x=t12;

x2=a11n(b3+1:b7);
L21=length(x2);
t22=0:1:L21-1;
t22=t22*(1/fs);
t22=t22';
y=t22;

x3=a11n(b7+1:b9);
L31=length(x3);
t32=0:1:L31-1;
t32=t32*(1/fs);
t32=t32';
z=t32;

O=[x1];
O1=[x2];
O2=[x3];
O3=[x4];