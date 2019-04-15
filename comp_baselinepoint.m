function [B1, B2, B3, B4,B5]=comp_baselinepoint(fs,qrspeaks,locs,D10, D9, D8, D7, D6,D5, D4)

% j=size(qrspeaks);
% 
% m=0:1:j(1,1)-1;
y11=D9+D8+D7+D6+D5+D4;
y11 = abs(y11).^1.5;
seg=[];
blp=[];
blp_a=[];
nl=[];
nr=[];
m=locs;
m=m';

for k=1:length(m)-1
    seg(k)=round(m(k)+0.66*(m(k+1)-(m(k))));
    %blp_a(k)=y11(blp(k));
   
end

% Detection of accurate baseline points
k1= numel(seg);

for k=1:k1
%    tp_arr= x1(seg(k)-40:seg(k)+40);    
    for k2=seg(k)-50:seg(k)+50
        k2
        slp_l(k2)=abs(y11(k2)-y11(k2-8));
        slp_r(k2)=abs(y11(k2)-y11(k2+8));
        mu_slp(k2)=(slp_l(k2)+slp_r(k2))/2;
    end 
    mn=100;
    
    for k2=seg(k)-50:seg(k)+50
        if mu_slp(k2)<=mn
            mn=mu_slp(k2);
            mn_ind=k2;
        end
    end   
    mn_ind
   
    blp(k)=mn_ind;
    blp_a(k)=y11(mn_ind);
     
    clear slp_l slp_r
end

for k5=1:length(blp)-1
    nl(k5)=m(k5+1)-blp(k5);                     % number of segments on left side
    nr(k5)= blp(k5+1)-m(k5+1);                  % number of segments on right side
end
nl
nr

arr_lbt= max(nl);

arr_rbt= max(nr);


clear a

 
 B1=[arr_lbt arr_rbt];
 B2=[nl' nr'];
 B3=[k5];
 B4=[blp'];
 B5=[blp_a'];
 
 


