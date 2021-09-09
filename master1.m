clear, clc
TY = 1;
cd = -3.2;
%-----------------------------------------

%% 1. Load in all data Tower Pier

%Type 1 - 1911:1920;
%1911-1914
[D1] = control1;
%1915-1919
[D1a] = control1a;
%1920
[D1b] = control1b;

%Type 2 - 1921:1934;
%1921-1931
[D2] = control2;
%1932-1934
[D2b] = control2b;

%Type 3 - 1934:1953;
[D3] = control3;

%Type 4 - 1954:1973;
[D4] = control4;

%Type 5 - 1974:1995;
[D5] = control5;
%-----------------------------------------

%% 2. Datum corrections

%Type 1 - 1911:1920;
D1(:,2) = D1(:,2)+3.459-0.1524;
D1a(:,2) = D1a(:,2)+3.459-0.1524;
D1b(:,2) = D1b(:,2)+3.459-0.1524;

%Type 2 - 1921:1934;
D2(:,2) = D2(:,2)+3.459;
D2b(:,2) = D2b(:,2)+3.459;

%For Old Swan Pier (early part of London Bridge tide gauge), the gauge is relevelled on 25 June 1922 and lifted 6 inches, therefore all data before 25 June 1922 is substracted by 0.1524 m (6 inches).
for i = 1:length(D2(:,1))
    if D2(i,1) < 702173
       D2(i,2) = D2(i,2)-0.1524;
    end
end
clear i

%Type 3 - 1934:1953;
%Newlyn Datum
D3(:,2) = D3(:,2);

%Type 4 - 1954:1973;
%Newlyn Datum
D4(:,2) = D4(:,2);

%Type 5 - 1974:1995;
%Chart Datum
D5(:,2) = D5(:,2)-3.20;

%HW
i = find(D5(:,2)>=0);
D5(i,3) = 1;
%LW
j = find(D5(:,2)<0);
D5(j,3) = 0;        
clear i j 
%-----------------------------------------

%% 3. Joint together
D =[D1;D1a;D1b;D2;D2b;D3;D4;D5];
clear D1 D1a D1b D2 D3 D4 D5

%remove nans
i = find(isnan(D(:,1)));
D(i,:) = [];
clear i
%-----------------------------------------

%% 4 Separate into high and low waters
i = find(D(:,3)==1);
HW1 = D(i,:);
j = find(D(:,3)==0);
LW1 = D(j,:);
clear i j D4 D5 co ans f_out;

% datestr(HW1(1,1))
% datestr(HW1(end,1))
% 
% datestr(LW1(1,1))
% datestr(LW1(end,1))
%-----------------------------------------

%% 5. Load in modern data and combine

switch TY
    case 1  %just historic
        
        %sort
        [j,k] = sort(D(:,1));
        D = D(k,:);
        
        % 6. Export Data - Text File
        fid = fopen(['../../4_FINAL_DATASET/10-11_London_Bridge.txt'],'w');
        fprintf(fid,'Date and time, water level (m ODN), flag, HW=1 or LW=0\r\n');
        [DD(:,3),DD(:,2),DD(:,1),DD(:,4),DD(:,5),DD(:,6)] = datevec(D(:,1));
        DD(:,7) = D(:,2);
        DD(:,8) = D(:,3);
        fprintf(fid,'%2.2d/%2.2d/%4.2d %2.2d:%2.2d:%2.2d,%8.4f,%d\r\n',DD(:,:)');
        fclose(fid);
        
        co = 0;
        for i =1911:2020
            co =co+1;
            x(co) = datenum(i,1,1,0,0,0);
        end
        
        figure('units','normalized','position',[0.1 0.1 0.8 0.8]);
        hold on
        plot(HW1(:,1),HW1(:,2),'or');
        plot(LW1(:,1),LW1(:,2),'om');
        set(gca,'xlim',[datenum(1910,1,1,0,0,0) datenum(1997,1,1,0,0,0)],'xtick',x,'xticklabel',datestr(x,11));
        grid
        legend('High Water','Low Water');
        
        % 5. Save data
        D2 = D;
        save('MAT_FILES/mast1.mat','D2');
        
    case 2      %modern
        
        %delete data after 1994;
        i = find(HW1(:,1)>=datenum(1995,1,1,0,0,0));
        HW1(i,:) = [];
        clear i
        i = find(LW1(:,1)>=datenum(1995,1,1,0,0,0));
        LW1(i,:) = [];
        clear i
        
        
        [HW2,LW2]=loadin_modern;
        HW2(:,2) = HW2(:,2)-cd;
        LW2(:,2) = LW2(:,2)-cd;
        HW2(:,3) = 1;
        LW2(:,3) = 0;
        
        %combine into 1 single long file
        D2 = [HW1;LW1;HW2;LW2];
        [j,k] = sort(D2(:,1));
        D2 = D2(k,:);
        clear j k cd ans
        
        % 5. Save data
        save('MAT_FILES/mast1.mat','D2');
        
        % 6. Export Data - Text File
        fid = fopen(['../../4_FINAL_DATASET/10-11_London_Bridge_ALL.txt'],'w');
        fprintf(fid,'Date and time, water level (m ODN), flag, HW=1 or LW=0\r\n');
        [DD(:,3),DD(:,2),DD(:,1),DD(:,4),DD(:,5),DD(:,6)] = datevec(D2(:,1));
        DD(:,7) = D2(:,2);
        DD(:,8) = D2(:,3);
        fprintf(fid,'%2.2d/%2.2d/%4.2d %2.2d:%2.2d:%2.2d,%8.4f,%d\r\n',DD(:,:)');
        fclose(fid);
        
        % 7. Plot
        co = 0;
        for i =1911:2020
            co =co+1;
            x(co) = datenum(i,1,1,0,0,0);
        end
        
        figure('units','normalized','position',[0.1 0.1 0.8 0.8]);
        hold on
        plot(HW1(:,1),HW1(:,2),'or');
        plot(HW2(:,1),HW2(:,2),'om');
        plot(LW1(:,1),LW1(:,2),'ob');
        plot(LW2(:,1),LW2(:,2),'og');
        set(gca,'xlim',[min(x) max(x)],'xtick',x,'xticklabel',datestr(x,11));
        grid
        
        %clear
        clear x co i
end
%-----------------------------------------
