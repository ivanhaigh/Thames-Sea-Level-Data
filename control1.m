function [D] = control1;
%clear, clc

%% Load in Data
D =[];
for Y = 1911:1914
    Y
    for M = 1:12
        %Richmond           s=1
        %Strand-on-Green    s=3
        %Temple Pier        s=5
        %Old Swan Pier      s=7
        %Cherry Garden Pier s=9
        %Gravesend          s=11
        %Southend           s=13
        s = [7];
        [d] = loadin1(Y,M,s,'N');
        D = [D;d];
        clear d
    end
end


%% Figure

% figure;
% hold on
% plot(D(:,1),D(:,2),'or');
%-----------------------------------------
