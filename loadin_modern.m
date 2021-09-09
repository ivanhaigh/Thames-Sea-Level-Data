function [HW,LW]=loadin_modern;

load('../../3a_PLA_MODERN_DATA_EXTRACT_HW_LW/1_EXTRACT_HW_LWS/2_MAT_FILES/tower_pier.mat');
%remove nan's
i = find(isnan(HW(:,1)));
HW(i,:) = [];
clear i
i = find(isnan(LW(:,1)));
LW(i,:) = [];
clear i


% datestr(HW(1,1))
% datestr(HW(end,1))
% 
% datestr(LW(1,1))
% datestr(LW(end,1))