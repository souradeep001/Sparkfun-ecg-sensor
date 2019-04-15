function [D, D1]=dist_RRpeak(fs,qrspeaks,locs)

% j=size(qrspeaks);
% 
% m=0:1:j(1,1)-1;
% 
locs

m=locs;
m=m';
m

 k=length(m);
 k
 n1=[];
 time=0;  
for i1=1:k-1
    if (i1+1)>i1
       n1(:,i1)=(m(:,i1+1)- m(:,i1));
       time(i1)=i1/fs;
    end
end
% n1(n1==0)=[];
% time(time==0)=[];     
mm=(time);               
kk=length(n1);

D=[mm];
D1=[kk];

%comp_baselinepoint(k,m,n1,time,mm,kk,fs,locs,qrspeaks,y11)

