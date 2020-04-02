function [DI_mt_out, DI_nmt_out, H, P, CI, STATS] = DA_missingtoe_DI(list_mt, list_nmt)

% This script calculates and saves DI values for toes 2 & 3 (and their
% average) for individuals with a recorded missing toe report and for
% individuals without a missing toe report.
%
% Input list_mt is the list for datasets with missing toe report,
% input list_nmt s the list for datasets without missing toe report.
%
% 150105 NC
% Edited 150304 (NC) to include footedness checks. 

% (1) Calculate DI for toes 2 & 3 (and average) for missing toe (mt)
% individuals

fid = fopen(list_mt, 'r');
a = textscan(fid, '%s');

for n = 1:length(a{1})
    load(a{1}{n})
    
    [DI_output_mt(:,n), resps_all_mt(:,:,n), f_acc_indiv_mt(:,n), t_acc_indiv_mt(:,n)] = DA_get_dir(data);
    
end

DI_mt_out.DIs_toe2_mt = DI_output_mt(7,:);
DI_mt_out.DIs_toe3_mt = DI_output_mt(8,:);
DI_mt_out.DIs_ave23_mt = (DI_mt_out.DIs_toe2_mt + DI_mt_out.DIs_toe3_mt)/2;


% (2) Calculate DI for toes 2 & 3 (and average) for no missing toe (nmt)
% individuals

fid = fopen(list_nmt, 'r');
a = textscan(fid, '%s');

for n = 1:length(a{1})
    load(a{1}{n})
    
    [DI_output_nmt(:,n), resps_all_nmt(:,:,n), f_acc_indiv_nmt(:,n), t_acc_indiv_nmt(:,n)] = DA_get_dir(data);
    
end

DI_nmt_out.DIs_toe2_nmt = DI_output_nmt(7,:);
DI_nmt_out.DIs_toe3_nmt = DI_output_nmt(8,:);
DI_nmt_out.DIs_ave23_nmt = (DI_nmt_out.DIs_toe2_nmt + DI_nmt_out.DIs_toe3_nmt)/2;


% %(3) Test for normalcy using Lilliefors
% 
% [H(1),P] = lillietest(DI_mt_out.DIs_toe2_mt);
% [H(2),P] = lillietest(DI_mt_out.DIs_toe3_mt);
% [H(3),P] = lillietest(DI_mt_out.DIs_ave23_mt);
% [H(4),P] = lillietest(DI_nmt_out.DIs_toe2_nmt);
% [H(5),P] = lillietest(DI_nmt_out.DIs_toe2_nmt);
% [H(6),P] = lillietest(DI_nmt_out.DIs_ave23_nmt);
% 
% % Conclusion: all data are normal. Go ahead with ttest.


%(4) Test for difference between the two groups, using parametric test:

[H(:,1), P(:,1), CI(:,1), STATS(:,1)] = ttest2(DI_mt_out.DIs_toe2_mt, DI_nmt_out.DIs_toe2_nmt);

[H(:,2), P(:,2), CI(:,2), STATS(:,2)] = ttest2(DI_mt_out.DIs_toe3_mt, DI_nmt_out.DIs_toe3_nmt);

[H(:,3), P(:,3), CI(:,3), STATS(:,3)] = ttest2(DI_mt_out.DIs_ave23_mt, DI_nmt_out.DIs_ave23_nmt);


% (5) Find means of the DI for the two groups: 

mean(DI_mt_out.DIs_toe2_mt)
mean(DI_mt_out.DIs_toe3_mt)
mean(DI_mt_out.DIs_ave23_mt)
mean(DI_nmt_out.DIs_toe2_nmt)
mean(DI_nmt_out.DIs_toe2_nmt)
mean(DI_nmt_out.DIs_ave23_nmt)


% (6) Check whether footedness or abs_footedness values differ by missing
% toe report presence or absence: 

% Load the DA handedness and footedness values for 19 participants:
load('DA_lateralization.mat');
abs_handedness = abs(handedness);
abs_footedness = abs(footedness);

% Index for missing toe report (1 = missing toe report; 0 = no such report)
idx_mt = [1 2 3 4 6 7 9 10 19];
idx_nmt = [5 8 11 12 13 14 15 16 17 18];

ftness_mt = footedness(idx_mt);
ftness_nmt = footedness(idx_nmt);
abs_ftness_mt = abs_footedness(idx_mt);
abs_ftness_nmt = abs_footedness(idx_nmt);

[H(:,4), P(:,4), CI(:,4), STATS(:,4)] = ttest2(ftness_mt, ftness_nmt);
[H(:,5), P(:,5), CI(:,5), STATS(:,5)] = ttest2(abs_ftness_mt, abs_ftness_nmt);

DI_mt_out.ftness_mt = ftness_mt;
DI_mt_out.abs_ftness_mt = abs_ftness_mt;
DI_nmt_out.ftness_nmt = ftness_nmt;
DI_nmt_out.abs_ftness_nmt = abs_ftness_nmt;








end