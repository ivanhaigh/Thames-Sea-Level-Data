clear, clc
%-----------------------------------------

%% 1. load data
load('MAT_FILES/mast1.mat');
i = find(D2(:,3)==1);
HW = D2(i,:);
clear i
i = find(D2(:,3)==0);
LW = D2(i,:);
clear i
%-----------------------------------------

%% 2. Annual Means
co = 0;
for i =1911:2019
    co =co+1;
    
    AM(co,1) =i;
    j1 = find(HW(:,1)>=datenum(i,1,1,0,0,0) & HW(:,1)<datenum(i+1,1,1,0,0,0) );
    AM(co,2) = nanmean(HW(j1,2));
    
    j2 = find(LW(:,1)>=datenum(i,1,1,0,0,0) & LW(:,1)<datenum(i+1,1,1,0,0,0) );
    AM(co,3) = nanmean(LW(j2,2));
    
    DQ(co,1) = i;
    DQ(co,2) = length(j1);
    DQ(co,3) = (length(j1)/706)*100;
    DQ(co,4) = length(j2);
    DQ(co,5) = (length(j2)/706)*100;
    clear j1 j2
   
end

%remove data less than 60%
i = find(DQ(:,3)<60);
AM(i,2) = NaN;
clear i
i = find(DQ(:,5)<60);
AM(i,3) = NaN;
clear i

%MTR and MTL
AM(:,4) = AM(:,2)-AM(:,3);
D = AM(:,2:3)';
AM(:,5) = mean(D)
clear D co

%Remove all values with no data
AM2 = AM;
i = find(isnan(AM2(:,2)));
AM2(i,:) = [];

%Cut data off before 1938
% i = find(AM(:,1)<1938);
% AM(i,:) = [];
%-----------------------------------------

%% 3. Trend
[T(1,:),yfit1] = trend_new(1,AM2(:,1),AM2(:,2)*1000,1,'N');
[T(2,:),yfit2] = trend_new(1,AM2(:,1),AM2(:,3)*1000,1,'N');
[T(3,:),yfit3] = trend_new(1,AM2(:,1),AM2(:,4)*1000,1,'N');
[T(4,:),yfit4] = trend_new(1,AM2(:,1),AM2(:,5)*1000,1,'N');
%-----------------------------------------

%% 4. Save Data
%save('../../4_FINAL_DATASET/MAT_FILES/1_WALTON_ON_NAZE.mat','HW','LW');
%-----------------------------------------

%% 6. Plot - Annual Mean
figure('units','normalized','position',[0.1 0.1 0.8 0.8]);
subplot(411)
hold on
plot(AM2(:,1),AM2(:,2),'-or');
plot(AM2(:,1),yfit1/1000,'-r','linewidth',2);
set(gca,'xlim',[1960 2000],'xtick',[1960:10:2000]);
grid
title(['(a) MHW ', num2str(T(1,1)),' +/- ',num2str(T(1,2)),' mm/yr'],'fontweight','bold','fontsize',16);

box on
subplot(412)
hold on
plot(AM2(:,1),AM2(:,3),'-ob');
plot(AM2(:,1),yfit2/1000,'-b','linewidth',2);
set(gca,'xlim',[1960 2000],'xtick',[1910:10:2000]);
grid
title(['(b) MLW ', num2str(T(2,1)),' +/- ',num2str(T(2,2)),' mm/yr'],'fontweight','bold','fontsize',16);
box on

subplot(413)
hold on
plot(AM2(:,1),AM2(:,4),'-ok');
plot(AM2(:,1),yfit3/1000,'-k','linewidth',2);
set(gca,'xlim',[1960 2000],'xtick',[1960:10:2000]);
grid
title(['(c) MTR ', num2str(T(3,1)),' +/- ',num2str(T(3,2)),' mm/yr'],'fontweight','bold','fontsize',16);
box on

subplot(414)
hold on
plot(AM2(:,1),AM2(:,5),'-ok');
plot(AM2(:,1),yfit4/1000,'-k','linewidth',2);
set(gca,'xlim',[1960 2000],'xtick',[1960:10:2000]);
grid
title(['(d) MTL (MSL) ', num2str(T(4,1)),' +/- ',num2str(T(4,2)),' mm/yr'],'fontweight','bold','fontsize',16);
box on
%-----------------------------------------

