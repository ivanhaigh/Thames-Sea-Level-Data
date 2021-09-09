function [D] = control2;
%clear, clc

%% Load in Data
D =[];
for Y = 1921:1931
    Y
    for M = 1:12
    %Richmond                       s=1
    %Stand-on-Green                 s=2
    %Old Swan Pier                  s=3
    %Cherry Garden Pier             s=4
    %Gallions Pier (Albert Dock)    s=5
    %Gravesend                      s=6
    %Southend                       s=7
        s = [3];
        [d] = loadin2(Y,M,s,'N');
        D = [D;d];
        clear d
    end
end


%% Figure

% figure;
% hold on
% plot(D(:,1),D(:,2),'or');
%-----------------------------------------
