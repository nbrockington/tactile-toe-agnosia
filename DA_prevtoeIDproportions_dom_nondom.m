% Script to analyse whether the previous toe ID proportions are different
% between the dominant and non-dominant feet for toes 2 and 3, for those
% subjects in whom both feet were tested.
%
% 150621 (NC)

%%
% Need to be in the analysis directory ~/data/DA_data/analysis

clear all; close all;

load('toe_order_dom.mat');
load('toe_order_nondom.mat');


%%

% Checking the overall values: in this subgroup of subjects, how to overall
% proportions of preceding toe IDs compare? This data is already available
% for nondom foot in Supp Figure 3, so only calculating for dominant foot
% in this subgroup here:

% toe 1

idx_toe1 = find(toe_order_dom == 1);
idx_toe1_prev = idx_toe1 - 1;
idx_toe1_prev = idx_toe1_prev(mod(idx_toe1_prev, 50) ~= 0);
toe1_prevIDs = toe_order_dom(idx_toe1_prev);

for i = 1:5
    
    toe1_prevIDprops(i) = sum(toe1_prevIDs == i)/size(toe1_prevIDs, 1);
    
end

% toe 2

idx_toe2 = find(toe_order_dom == 2);
idx_toe2_prev = idx_toe2 - 1;
idx_toe2_prev = idx_toe2_prev(mod(idx_toe2_prev, 50) ~= 0);
toe2_prevIDs = toe_order_dom(idx_toe2_prev);

for i = 1:5
    
    toe2_prevIDprops(i) = sum(toe2_prevIDs == i)/size(toe2_prevIDs, 1);
    
end

% toe 3

idx_toe3 = find(toe_order_dom == 3);
idx_toe3_prev = idx_toe3 - 1;
idx_toe3_prev = idx_toe3_prev(mod(idx_toe3_prev, 50) ~= 0);
toe3_prevIDs = toe_order_dom(idx_toe3_prev);

for i = 1:5
    
    toe3_prevIDprops(i) = sum(toe3_prevIDs == i)/size(toe3_prevIDs, 1);
    
end


% toe 4 (NB. This is the first toe, so ignore idx one when looking at prev
% toes).

idx_toe4 = find(toe_order_dom == 4);
idx_toe4_prev = idx_toe1(2:end) - 1;
idx_toe4_prev = idx_toe4_prev(mod(idx_toe4_prev, 50) ~= 0);
toe4_prevIDs = toe_order_dom(idx_toe4_prev);

for i = 1:5
    
    toe4_prevIDprops(i) = sum(toe4_prevIDs == i)/size(toe4_prevIDs, 1);
    
end

% toe 5

idx_toe5 = find(toe_order_dom == 5);
idx_toe5_prev = idx_toe5 - 1;
idx_toe5_prev = idx_toe5_prev(mod(idx_toe5_prev, 50) ~= 0);
toe5_prevIDs = toe_order_dom(idx_toe5_prev);

for i = 1:5
    
    toe5_prevIDprops(i) = sum(toe5_prevIDs == i)/size(toe5_prevIDs, 1);
    
end

% Barchart for preceding toe ID proportions for each toe

toe1_props = [0 toe1_prevIDprops(1) sum(toe1_prevIDprops(2:5))];
toe2_props = [toe2_prevIDprops(1) toe2_prevIDprops(2) sum(toe2_prevIDprops(3:5))];
toe3_props = [sum(toe3_prevIDprops(1:2)) toe3_prevIDprops(3) sum(toe3_prevIDprops(4:5))];
toe4_props = [sum(toe4_prevIDprops(1:3)) toe4_prevIDprops(4) toe4_prevIDprops(5)];
toe5_props = [sum(toe5_prevIDprops(1:4)) toe5_prevIDprops(5) 0];

barvalues = [toe1_props; toe2_props; toe3_props; toe4_props; toe5_props];
errors = zeros(5,3);
width = [];
groupnames = {'toe 1', 'toe 2', 'toe 3', 'toe 4', 'toe 5'};
bw_title = [];
bw_xlabel = 'Toe ID current trial';
bw_ylabel = 'Proportions of previous toe IDs';
bw_colormap = bone;
gridstatus = 'none';
bw_legend = {'medial toe', 'same toe', 'lateral toe'};

handles = barweb(barvalues, errors, width, groupnames, bw_title, bw_xlabel, bw_ylabel, bw_colormap, gridstatus, bw_legend);
axis([0.5 5.5 0 1]);


set(get(gcf,'CurrentAxes'),'FontName','Times New Roman');
set(get(gcf,'CurrentAxes'),'FontSize', 16);
xhandle = xlabel('Toe ID current trial');
set(xhandle, 'Fontsize', 16);
set(xhandle, 'Fontname', 'Times New Roman');
yhandle = ylabel('Proportions of previous toe IDs');
set(yhandle, 'Fontsize', 16);
set(yhandle, 'Fontname', 'Times New Roman');
set(handles.legend, 'Fontsize', 15);
set(handles.ax, 'Fontsize', 15);
%close;


%%

% Looping through the 10 subjects, calculate the previous toe ID
% proportions for toes 2 and 3 for each one.


for n = 1:10
    
    idx = 150*(n-1)+1:150*n;
    s_toe_order_dom = toe_order_dom(idx);
    s_toe_order_nondom = toe_order_nondom(idx);
    
    % DOMINANT FOOT
    
    % toe 2
    
    idx_toe2 = find(s_toe_order_dom == 2);
    idx_toe2_prev = idx_toe2 - 1;
    idx_toe2_prev = idx_toe2_prev(mod(idx_toe2_prev, 50) ~= 0);
    toe2_prevIDs = s_toe_order_dom(idx_toe2_prev);
    
    for i = 1:5
        
        toe2_prevIDprops(i) = sum(toe2_prevIDs == i)/size(toe2_prevIDs, 1);
        
    end
    
    % toe 3
    
    idx_toe3 = find(s_toe_order_dom == 3);
    idx_toe3_prev = idx_toe3 - 1;
    idx_toe3_prev = idx_toe3_prev(mod(idx_toe3_prev, 50) ~= 0);
    toe3_prevIDs = s_toe_order_dom(idx_toe3_prev);
    
    for i = 1:5
        
        toe3_prevIDprops(i) = sum(toe3_prevIDs == i)/size(toe3_prevIDs, 1);
        
    end
    
    toe2_toeprops_DN.dom(n,:) = [toe2_prevIDprops(1) toe2_prevIDprops(2) sum(toe2_prevIDprops(3:5))];
    toe3_toeprops_DN.dom(n,:) = [sum(toe3_prevIDprops(1:2)) toe3_prevIDprops(3) sum(toe3_prevIDprops(4:5))];

    % NON-DOM FOOT
    
    % toe 2
    
    idx_toe2 = find(s_toe_order_nondom == 2);
    idx_toe2_prev = idx_toe2 - 1;
    idx_toe2_prev = idx_toe2_prev(mod(idx_toe2_prev, 50) ~= 0);
    toe2_prevIDs = s_toe_order_nondom(idx_toe2_prev);
    
    for i = 1:5
        
        toe2_prevIDprops(i) = sum(toe2_prevIDs == i)/size(toe2_prevIDs, 1);
        
    end
    
    % toe 3
    
    idx_toe3 = find(s_toe_order_nondom == 3);
    idx_toe3_prev = idx_toe3 - 1;
    idx_toe3_prev = idx_toe3_prev(mod(idx_toe3_prev, 50) ~= 0);
    toe3_prevIDs = s_toe_order_nondom(idx_toe3_prev);
    
    for i = 1:5
        
        toe3_prevIDprops(i) = sum(toe3_prevIDs == i)/size(toe3_prevIDs, 1);
        
    end
    
    toe2_toeprops_DN.nondom(n,:) = [toe2_prevIDprops(1) toe2_prevIDprops(2) sum(toe2_prevIDprops(3:5))];
    toe3_toeprops_DN.nondom(n,:) = [sum(toe3_prevIDprops(1:2)) toe3_prevIDprops(3) sum(toe3_prevIDprops(4:5))];
    
    
end


%%

% Graph and statistical comparisons of previous toe proportions 
% (medial-lateral): 

toe2_toeprops_DN.dom(:,4) = toe2_toeprops_DN.dom(:,3) - toe2_toeprops_DN.dom(:,1);
toe2_toeprops_DN.nondom(:,4) = toe2_toeprops_DN.nondom(:,3) - toe2_toeprops_DN.nondom(:,1);

toe3_toeprops_DN.dom(:,4) = toe3_toeprops_DN.dom(:,3) - toe3_toeprops_DN.dom(:,1);
toe3_toeprops_DN.nondom(:,4) = toe3_toeprops_DN.nondom(:,3) - toe3_toeprops_DN.nondom(:,1);

figure;
subplot(1,2,1);
scatter(toe2_toeprops_DN.dom(:,4), toe2_toeprops_DN.nondom(:,4), 'ko');
hold on;
axis([0 1 0 1]);
plot([0 1], [0 1], 'k-');

subplot(1,2,2);
scatter(toe3_toeprops_DN.dom(:,4), toe3_toeprops_DN.nondom(:,4), 'ko');
hold on;
axis([-0.5 0.5 -0.5 0.5]);
plot([-0.5 0.5], [-0.5 0.5], 'k-');
close;

% Only toe3_toeproprs_DN.nondom(:,4) is not norm dist, so we use parametric
% statistics (results are same with signrank test): 

[H_p(1), P_p(1), CI_p(1).CI, STATS_p(1).stats] = ttest(toe2_toeprops_DN.dom(:,4), toe2_toeprops_DN.nondom(:,4));
[H_p(2), P_p(2), CI_p(2).CI, STATS_p(2).stats] = ttest(toe2_toeprops_DN.dom(:,4), toe2_toeprops_DN.nondom(:,4));

[P_np(1), H_np(1), STATS_np(1).stats] = signrank(toe2_toeprops_DN.dom(:,4), toe2_toeprops_DN.nondom(:,4));
[P_np(2), H_np(2), STATS_np(2).stats] = signrank(toe2_toeprops_DN.dom(:,4), toe2_toeprops_DN.nondom(:,4));


dom_combined = mean([toe2_toeprops_DN.dom(:,4) toe3_toeprops_DN.dom(:,4)], 2);
nondom_combined = mean([toe2_toeprops_DN.nondom(:,4) toe3_toeprops_DN.nondom(:,4)], 2);

[H_p(3), P_p(3), CI_p(3).CI, STATS_p(3). stats] = ttest(dom_combined, nondom_combined);

[P_np(3), H_np(3), STATS_np(3). stats] = signrank(dom_combined, nondom_combined);
















