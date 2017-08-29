% recalibrate

function newvalue = ReCalibrate(oldvalue ,offset)
newvalue = zeros(size(oldvalue));
for i = 1:length(oldvalue)
    newvalue(i,:) = oldvalue(i,:) - offset;
end

% function [newL_LC, newR_LC, newL_FP, newR_FP] = ReCalibrate(L_LC, R_LC, L_FP, R_FP, LLC_offset, RLC_offset, LFP_offset, RFP_offset)
% newL_LC = zeros(size(L_LC));
% newR_LC = zeros(size(R_LC));
% newL_FP = zeros(size(L_FP));
% newR_FP = zeros(size(R_FP));
% for i = 1:length(L_LC)
%     newL_LC(i,:) = L_LC(i,:) - LLC_offset;
%     newR_LC(i,:) = R_LC(i,:) - RLC_offset;
%     newL_FP(i,:) = L_FP(i,:) - LFP_offset;
%     newR_FP(i,:) = R_FP(i,:) - RFP_offset;
% end