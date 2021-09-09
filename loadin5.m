function [D] = loadin5(Y,M,fig);
% clear, clc
% Y = 1980;
% M = 3;
% fig = 'Y';
%-----------------------------------------

%% Create File Name
file_in = ['../../2_TABULATED_DATA/1934-1995/10_TOWER_PIER/Type 5 1974-1995/',num2str(Y),'_Tower_Pier.xlsx'];
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


D1(:,1) = a(:,1);
D1(:,2) = a(:,2);
D1(:,3) = a(:,3);

D2(:,1) = a(:,4);
D2(:,2) = a(:,5);
D2(:,3) = a(:,6);

D3(:,1) = a(:,7);
D3(:,2) = a(:,8);
D3(:,3) = a(:,9);

D4(:,1) = a(:,10);
D4(:,2) = a(:,11);
D4(:,3) = a(:,12);

D = [D1;D2;D3;D4];
D(D==-999)=NaN;
D(D==999)=NaN;
D(D==-999999)=NaN;
D(D==999999)=NaN;
clear D1 D2 D3 D4 a b c file_in
%-----------------------------------------

%% Lo
for i = 1:31
    j1 = find(D(:,1)==i);
    j2 = find(D(:,1)==i+1);
    k = j1+1:j2-1;
    D(k,1) = i;
    clear j1 j2 k
end
clear i  
i = max(D(:,1));
j = find(D(:,1)==i);
D(j+1:end,1) = i;

i =find(isnan(D(:,3)));
D(i,:) =[];
D(:,1) = D(:,1)-1;
D(:,4) = D(:,1)+D(:,2);
D(:,4) = D(:,4)+datenum(Y,M,1,0,0,0);

D(:,1) = D(:,4);
D(:,2) =[];
D(:,3) =[];
%-----------------------------------------

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





