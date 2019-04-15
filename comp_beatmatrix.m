function [U,N1, N2, N3, N4]=comp_beatmatrix(fs,locs,arr_lbt,arr_rbt,nl,nr,blp,blp_a,D10, D9, D8, D7, D6,D5, D4)

y11=D9+D8+D7+D6+D5+D4;

m=locs;
m=m';
lt=[];
rt=[];
arr_beat=[];

% part-1 : from BLP to R-peak
 for k1=1:length(m)-2
     if nl(k1) < arr_lbt
        pad_l = arr_lbt-nl(k1);                 % calculating the pad length
        lt(k1)= pad_l;          % number of padding array for left side
        for k2= 1:pad_l
            a(k2)=0;        %blp_a(k1);                    % padding
            
        end
       
        a1 = a';
     temp_l = y11(blp(k1)+1:m(k1+1));
     t= vertcat(a1,temp_l);
     
     t_l(:,k1) =t;
     else
        temp_l = y11(blp(k1)+1:m(k1+1)); 
         t_l(:,k1) =temp_l;
     
     end
     clear a pad_l temp_l a1
 
 end   
 
 clear a
 %part-2: from R-peak to next BLP   
 for k1=1:length(m)-2
     if nr(k1) < arr_rbt
        pad_r = arr_rbt-nr(k1);
         rt(k1)=pad_r;          % Number of paddings for right side
        for k2= 1:pad_r
            a(k2)=0;    %blp_a(k1+1);                   % padding
           
        end
       
        a2 = a';
        temp_r = y11(m(k1+1)+1:blp(k1+1));
     tt= vertcat(temp_r,a2);
     
     t_r(:,k1) =tt;
     else
        temp_r = y11(m(k1+1)+1:blp(k1+1)); 
         t_r(:,k1) =temp_r;
     
     end
     clear a pad_r 
 
 end 
%r_pk = arr_lbt; 
beat_t = vertcat(t_l,t_r);
len_bt=length(beat_t(:,1));

for k11=1:length(lt)          % column index
       
   k22=1;
        arr_beat(k22,k11)=arr_lbt;
        k22=k22+1;
        
        
        arr_beat(k22,k11)=lt(k11);
        k22=k22+1;
        
        
        arr_beat(k22,k11)=rt(k11);
        k22=k22+1;
       
        arr_beat(k22:len_bt+3,k11)=beat_t(:,k11);
        
    
end 
arr_beat

[P,Q]=size(arr_beat);

disp('array beats')
No_of_beat=Q;
No_of_beat

N=size(arr_beat);

% Z=[];


    
%n=input('Enter Beat Number : ');



%n=l;
a11=[];
B=[];
% str1='Beat:-';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
for l=1:N(1,2)
    n=l;
% str2=strcat(str1,int2str(l));
 
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
% figure;
% 
% plot(a11); 
% %title('Single Beat')
% title(str2)

% Z1=fiducialpoint1(fs,arr_beat,a11,B)

%Z=[Z;Z1];
%savefig(str2)


end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Z
U=arr_beat
size(U)
%save('beat_matrix.txt','U','-ascii')

%save('fiducial_point.txt','Z','-ascii','-tabs')

N1=[arr_beat];
N2=[a11];
N3=[B];
N4=[N]
