function [Z, Z1, Z2, Z3, Z4]=baselineremoval(y,fs)

c= y;


[c,l]=wavedec(c,12,'db5');
cA12= appcoef(c,l,'db5',12);
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
cD11=detcoef(c,l,11);
cD12=detcoef(c,l,12);


A12=wrcoef('a',c,l,'db5',12);
D1=wrcoef('d',c,l,'db5',1);
D2=wrcoef('d',c,l,'db5',2);
D3=wrcoef('d',c,l,'db5',3);
D4=wrcoef('d',c,l,'db5',4);
D5=wrcoef('d',c,l,'db5',5);
D6=wrcoef('d',c,l,'db5',6);
D7=wrcoef('d',c,l,'db5',7);
D8=wrcoef('d',c,l,'db5',8);
D9=wrcoef('d',c,l,'db5',9);
D10=wrcoef('d',c,l,'db5',10);
D11=wrcoef('d',c,l,'db5',11);
D12=wrcoef('d',c,l,'db5',12);


y11=D9+D8+D7+D6+D5+D4;



N11=length(y11);
% 
% 
t1=(0:N11-1)/fs;


Z=[y];

Z1=c;

Z2=fs;
Z3=[D10 D9 D8 D7 D6 D5 D4];
Z4=[y11];



