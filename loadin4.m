function [D] = loadin4(Y,M,fig);
% clear, clc
% Y = 1954;
% M = 1;
% fig = 'Y';
%-----------------------------------------

%% Create File Name
file_in = ['../../2_TABULATED_DATA/1934-1995/10_TOWER_PIER/Type 4 1954-1973/',num2str(Y),'_Tower_Pier.xlsx'];
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
D1(:,2) = a(:,2)*-1;
D1(:,3) = a(:,3);
D1(:,4) = a(:,4);
D1(:,5) = 0;

D2(:,1) = a(:,1);
D2(:,2) = a(:,5)*-1;
D2(:,3) = a(:,6);
D2(:,4) = a(:,7);
D2(:,5) = 0;

D3(:,1) = a(:,1);
D3(:,2) = a(:,8);
D3(:,3) = a(:,9);
D3(:,4) = a(:,10);
D3(:,5) = 1;

D4(:,1) = a(:,1);
D4(:,2) = a(:,11);
D4(:,3) = a(:,12);
D4(:,4) = a(:,13);
D4(:,5) = 1;

D = [D1;D2;D3;D4];
D(D==-999)=NaN;
D(D==999)=NaN;
clear D1 D2 D3 D4 a b c file_in
%-----------------------------------------

D = sortrows(D,1);

D(:,6) = datenum(Y,M,D(:,1),D(:,3),D(:,4),0);
D(:,2) = D(:,2)/3.281;
D(:,1) = D(:,6);
D(:,3) =[];
D(:,3) =[];
D(:,4) =[];
% %-----------------------------------------
% 
%% Figure
switch fig
    case 'Y'
        figure
        plot(D(:,1),D(:,2),'o');
end
% %-----------------------------------------
else
    D = [];
end
%
