function [D] = control5;
%clear, clc

%% Load in Data
D =[];
for Y = 1974:1995;
    Y
    for M = 1:12
        [d] = loadin5(Y,M,'N');
        D = [D;d];
        clear d
    end
end


%% Figure

% figure;
% hold on
% plot(D(:,1),D(:,2),'or');
%-----------------------------------------


