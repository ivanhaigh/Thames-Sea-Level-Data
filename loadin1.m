function [D] = loadin1(Y,M,s,fig); 
% clear, clc
% Y = 1911;
% M = 1;
% s = 1;          
% fig = 'Y';

        %Richmond           s=1
        %Strand-on-Green    s=3
        %Temple Pier        s=5
        %Old Swan Pier      s=7
        %Cherry Garden Pier s=9
        %Gravesend          s=11
        %Southend           s=13
%-----------------------------------------

%% Create File Name
file_in = ['../../2_TABULATED_DATA/1911-1920/',num2str(Y),'_AllSites.xlsx'];
fid = fopen(file_in);
if fid >2
%-----------------------------------------

%% Load in and Format
switch M
    case 1
        MM = '01';
    case 2
        MM = '02';
    case 3
        MM = '03';
    case 4
        MM = '04';
    case 5
        MM = '05';
    case 6
        MM = '06';
    case 7
        MM = '07';
    case 8
        MM = '08';
    case 9
        MM = '09';
    case 10
        MM = '10';
    case 11
        MM = '11';
    case 12
        MM = '12';
end
[a,b,c] = xlsread(file_in,MM);

%add date for every row
 for i = 1:31
     j1 = find(a(:,1)==i);
     j2 = find(a(:,1)==i+1);
     k = j1+1:j2-1;
     a(k,1) = i;
     clear j1 j2 k
 end
 clear i  
 i = max(a(:,1));
 j = find(a(:,1)==i);
 a(j+1:end,1) = i;

i1 =[s:14:length(a(:,1))]';
i2 = [(s+1):14:length(a(:,1))]';
[i3] = [i1;i2];
[c,b] = sort(i3);
i3 = c;

D1 = a(i3,:);
a = D1;
clear D1

%low water A.M.
 D1(:,1) = a(:,1);
 D1(:,2) = a(:,3)*-1;
 D1(:,3) = a(:,4)*-1;
 D1(:,4) = a(:,5);
 i =find(isnan(D1(:,4))); %find all Low Water A.M.
 D1(i,2) = NaN;
 D1(i,3) = NaN; 
 D1(:,5) = a(:,6);
 D1(:,6) = 0;
 clear i

 %low water P.M.
 D2(:,1) = a(:,1);
 D2(:,2) = a(:,3)*-1;
 D2(:,3) = a(:,4)*-1;
 D2(:,4) = a(:,7);
 for i = 1:length(D2(:,4))
     if D2(i,4) ~= 12
     D2(i,4) = D2(i,4)+12;
     end
 end
 clear i
 i =find(isnan(D2(:,4)));
 D2(i,2) = NaN;
 D2(i,3) = NaN; 
 D2(:,5) = a(:,8);
 D2(:,6) = 0;
 clear i

%high water A.M.
D3(:,1) = a(:,1);
D3(:,2) = a(:,9);
D3(:,3) = a(:,10);
D3(:,4) = a(:,11)*-1;
D3(:,5) = a(:,12)*-1;
i =find(~isnan(D3(:,4)));
D3(i,2) = D3(i,4);
D3(i,3) = D3(i,5);
D3(:,4) = a(:,13);
D3(:,5) = a(:,14);
clear i 
i =find(isnan(D3(:,4)));
D3(i,2) = NaN;
D3(i,3) = NaN;
D3(:,6) = 1;
clear i 

%high water P.M.
D4(:,1) = a(:,1);
D4(:,2) = a(:,9);
D4(:,3) = a(:,10);
D4(:,4) = a(:,11)*-1;
D4(:,5) = a(:,12)*-1;
i =find(~isnan(D4(:,4)));
D4(i,2) = D4(i,4);
D4(i,3) = D4(i,5);
clear i 
D4(:,4) = a(:,15);
for i = 1:length(D4(:,4))
    if D4(i,4) ~= 12
    D4(i,4) = D4(i,4)+12;
    end
end 
D4(:,5) = a(:,16);
clear i 
i =find(isnan(D4(:,4)));
D4(i,2) = NaN;
D4(i,3) = NaN;
D4(:,6) = 1;
clear i 

D = [D1;D2;D3;D4];
D(D==-999)=NaN;
D(D==999)=NaN;

clear D1 D2 D3 D4 a b c file_in
% %-----------------------------------------
% 
D = sortrows(D,1);
% 
D(:,7) = datenum(Y,M,D(:,1),D(:,4),D(:,5),0);
D(:,8) = D(:,3)/12;
D(:,2) = D(:,2)+D(:,8); 
D(:,2) = D(:,2)/3.281;
D(:,1) = D(:,7);
D(:,3) =[];
D(:,3) =[];
D(:,3) =[];
D(:,4) =[];
D(:,4) =[];
% 
%% Figure
switch fig
    case 'Y'
        figure
        plot(D(:,1),D(:,2),'o');
end

%-----------------------------------------

else
    D = [];
 end
