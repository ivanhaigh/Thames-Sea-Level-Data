function [D] = control2b;
%clear, clc

%% Load in Data
D =[];
for Y = 1932:1934
    Y
    for M = 1:12
    %Richmond                       s=1
    %Tower Pier                     s=2
    %Cherry Garden Pier             s=3
    %Gallions Pier (Albert Dock)    s=4
    %Gravesend                      s=5
    %Southend                       s=6
        s = [2];
        [d] = loadin2b(Y,M,s,'N');
        D = [D;d];
        clear d
    end
end


%% Figure

% figure;
% hold on
% plot(D(:,1),D(:,2),'or');
%-----------------------------------------
