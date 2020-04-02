function DI_out = DA_qad_DI_analysis(list, list2)

% This script runs the overall analysis on toe responses.
%
% "list" should be the dominant foot data
% "list2" should be the non-dominant foot data
%
% Created 130305 (NC)
% Edited 150203 (NC)
% Re-edited to make final figures: 150205 (NC)
% Re-edited to check correlations of dependent variables with footedness
% score  150304 (NC)

fid = fopen(list, 'r');
a = textscan(fid, '%s');

for n = 1:length(a{1})
    load(a{1}{n})
    
    [DI_output(:,n), resps_all(:,:,n), f_acc_indiv(:,n), t_acc_indiv(:,n)] = DA_get_dir(data);
    
end


% Some stat tests:

[hp(1,1), hp(1,2)] = ttest(DI_output(7,:)); % H0 Lillietest
[hp(2,1), hp(2,2)] = ttest(DI_output(8,:)); % H0 Lillietest
[hp(3,1), hp(3,2)] = signrank(DI_output(9,:)); % H1 Lillietest
[hp(4,1), hp(4,2)] = ttest([DI_output(7,:) DI_output(8,:) DI_output(9,:)]);

% [hp(1,1), hp(1,2)] = signrank(DI_output(7,:));
% [hp(2,1), hp(2,2)] = signrank(DI_output(8,:));
% [hp(3,1), hp(3,2)] = signrank(DI_output(9,:));

DI_out.DI_output = DI_output;
DI_out.f_acc_indiv = f_acc_indiv;
DI_out.t_acc_indiv = t_acc_indiv;
DI_out.toes234_dir_hp = hp;

DI_out.resps = resps_all;



% Getting population descriptive stats for accuracy on dominant toes

DI_out.t_acc_means = mean(DI_out.t_acc_indiv,2);
DI_out.t_acc_all_mean = mean(mean(DI_out.t_acc_indiv));

for j = 1:5
    DI_out.t_acc_sd(j) = std(DI_out.t_acc_indiv(j,:));
end
DI_out.t_acc_all_std = std(mean(DI_out.t_acc_indiv));

for j = 1:5
    DI_out.t_acc_range(j,1) = min(DI_out.t_acc_indiv(j,:));
    DI_out.t_acc_range(j,2) = max(DI_out.t_acc_indiv(j,:));
end
DI_out.t_acc_all_range(1) = min(mean(DI_out.t_acc_indiv));
DI_out.t_acc_all_range(2) = max(mean(DI_out.t_acc_indiv));

% Getting population descriptive stats for DI on dominant toes

DI_out.t_DI_means = mean(DI_out.DI_output(6:10,:),2);
DI_out.t_DI_all_mean = mean(mean(DI_out.DI_output(6:10,:)));

for j = 1:5
    DI_out.t_DI_sd(j) = std(DI_out.DI_output(j+5,:));
end
DI_out.t_DI_all_std = std(mean(DI_out.DI_output(6:10,:)));

for j = 1:5
    DI_out.t_DI_range(j,1) = min(DI_out.DI_output(j+5,:));
    DI_out.t_DI_range(j,2) = max(DI_out.DI_output(j+5,:));
end
DI_out.t_DI_all_range(1) = min(mean(DI_out.DI_output(6:10,:)));
DI_out.t_DI_all_range(2) = max(mean(DI_out.DI_output(6:10,:)));


% BAR CHART FOR GRAND MEAN FINGER RESPONSES

f_resps_gm = zeros(5,5);
t_resps_gm = zeros(5,5);

for i = 1:5 % for each finger
    
    f_resps_gm(:,i) = sum(resps_all(:,i,:), 3);
end


for i = 1:5 % for each toe
    
    t_resps_gm(:,i) = sum(resps_all(:,(i+5),:), 3);
end

DI_out.f_resps_gm = f_resps_gm;
DI_out.t_resps_gm = t_resps_gm;



%% ****************************
% **MAKING RESULTS & FIGURES**

% (FIGURE 1: BLACK & WHITE VERSION)
% 1a: Accuracy of finger responses (grand mean):

for i = 1:5 % for each finger
    
    f_acc(i) = f_resps_gm(i,i) / sum(f_resps_gm(:,i));
end

DI_out.f_acc = f_acc;


% 1b: Bar chart of finger responses (grand mean):

blackwhite = [0 0 0; 0.25 0.25 0.25; 0.5 0.5 0.5; 0.75 0.75 0.75; 1 1 1];

figure;
subplot(2,1,1);
bar(f_resps_gm','stacked');
colormap(blackwhite)
%title('Fingers', 'FontSize', 14);
xlabel('Finger ID', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('Total responses', 'FontSize', 12, 'FontName', 'Times New Roman');
legend('Response "1"', 'Response "2"', 'Response "3"', 'Response "4"', 'Response "5"', 'Location', 'BestOutside');
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman');
% 2a: Accuracy of toe responses (grand mean):

for i = 1:5 % for each finger
    
    t_acc(i) = t_resps_gm(i,i) / sum(t_resps_gm(:,i));
end

DI_out.t_acc = t_acc;

% 2b: Bar chart of toe responses (grand mean):

% Make colourmap for black-white bar chart:

subplot(2,1,2);

bar(t_resps_gm','stacked');
%applyhatch(gcf,'\-x./');
%title('Toes', 'FontSize', 14);
xlabel('Toe ID', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('Total responses', 'FontSize', 12, 'FontName', 'Times New Roman');
% legend('Respond digit 1', 'Respond digit 2', 'Respond digit 3', 'Respond digit 4', 'Respond digit 5', 'Location', 'BestOutside');
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman');

close

% (FIGURE 1: COLOUR VERSION)

figure;
subplot(2,1,1);
bar(f_resps_gm','stacked');
%colormap(blackwhite)
%title('Fingers', 'FontSize', 14);
xlabel('Finger ID', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('Total responses', 'FontSize', 12, 'FontName', 'Times New Roman');
legend('Response "1"', 'Response "2"', 'Response "3"', 'Response "4"', 'Response "5"', 'Location', 'BestOutside');
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman');

subplot(2,1,2);
bar(t_resps_gm','stacked');
%applyhatch(gcf,'\-x./');
%title('Toes', 'FontSize', 14);
xlabel('Toe ID', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('Total responses', 'FontSize', 12, 'FontName', 'Times New Roman');
% legend('Respond digit 1', 'Respond digit 2', 'Respond digit 3', 'Respond digit 4', 'Respond digit 5', 'Location', 'BestOutside');
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman');

close;


%% HISTOGRAMS
% 2c: Histograms and reports of directionality of errors for toes (grand
% mean) (NB. See DI_out.hp for the dir stats for the 3 middle toes):

% FIGURE 2: BLACK & WHITE VERSION

figure;
subplot(1,3,1);
h1 = histfit(DI_out.DI_output(7,:), 8);
set(h1(1), 'FaceColor', [0.5 0.5 0.5]);
delete(h1(2));
%set(h1(2), 'Color', 'k', 'LineWidth', 1.1);
axis([-1 1 0 5.25]);
set(gca, 'box', 'off');
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman');
%title('Toe 2', 'FontSize', 14);
%xlabel('Directionality index (DI)',  'FontSize', 14);
%ylabel('Number of individuals',  'FontSize', 14);
%grid on

subplot(1,3,2);
h2 = histfit(DI_out.DI_output(8,:), 10);
set(h2(1), 'FaceColor', [0.5 0.5 0.5]);
delete(h2(2));
%set(h2(2), 'Color', 'k', 'LineWidth', 1.1);
axis([-1 1 0 5.25]);
set(gca, 'box', 'off');
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman');
%xlabel('Directionality index (DI)',  'FontSize', 14);
%title('Toe 3',  'FontSize', 14);
%grid on

subplot(1,3,3);
h3 = histfit(DI_out.DI_output(9,:), 10);
set(h3(1), 'FaceColor', [0.5 0.5 0.5]);
delete(h3(2));
%set(h3(2), 'Color', 'k', 'LineWidth', 1.1);
axis([-1 1 0 5.25]);
set(gca, 'box', 'off');
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman');
%title('Toe 4',  'FontSize', 14);
%xlabel('Directionality index (DI)',  'FontSize', 14);
%ylabel('Number of individuals',  'FontSize', 14);
%grid on

%subplot(2,2,4);
%h4 = histfit([DI_out.DI_output(7,:) DI_out.DI_output(8,:) DI_out.DI_output(9,:)], 20);
%set(h4(1), 'FaceColor', 'k');
%set(h4(2), 'Color', [0.5 0.5 0.5]);
%axis([-1 1 0 5.25]);
%title('Toes 2,3 & 4 combined',  'FontSize', 14);
%xlabel('Directionality Index',  'FontSize', 14);
%grid on

%close

% FIGURE 2: COLOUR VERSION

figure;
subplot(1,3,1);
h1 = histfit(DI_out.DI_output(7,:), 8);
set(h1(1), 'FaceColor', 'r');
delete(h1(2));
%set(h1(2), 'Color', 'k', 'LineWidth', 1.1);
axis([-1 1 0 5.25]);
set(gca, 'box', 'off');
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman');
%title('Toe 2', 'FontSize', 14);
%xlabel('Directionality index (DI)',  'FontSize', 14);
%ylabel('Number of individuals',  'FontSize', 14);
%grid on

subplot(1,3,2);
h2 = histfit(DI_out.DI_output(8,:), 10);
set(h2(1), 'FaceColor', 'r');
delete(h2(2));
%set(h2(2), 'Color', 'k', 'LineWidth', 1.1);
axis([-1 1 0 5.25]);
set(gca, 'box', 'off');
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman');
%xlabel('Directionality index (DI)',  'FontSize', 14);
%title('Toe 3',  'FontSize', 14);
%grid on

subplot(1,3,3);
h3 = histfit(DI_out.DI_output(9,:), 10);
set(h3(1), 'FaceColor', 'r');
delete(h3(2));
%set(h3(2), 'Color', 'k', 'LineWidth', 1.1);
axis([-1 1 0 5.25]);
set(gca, 'box', 'off');
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman');
%title('Toe 4',  'FontSize', 14);
%xlabel('Directionality index (DI)',  'FontSize', 14);
%ylabel('Number of individuals',  'FontSize', 14);
%grid on

%DI_out.h1 = h1;
%DI_out.h2 = h2;
%DI_out.h3 = h3;
%DI_out.h4 = h4;

%close;



for i = 1:5 % for all toes:
    
    t_dir_gm(i) = mean(DI_out.DI_output((i+5),:));
end

DI_out.t_dir_gm = t_dir_gm;

%% FOOTEDNESS SCORES VS. ACCURACY, DI and MISSING TOE PERCEPT (WITH FIGURES)

% 3a. Compare overall accuracy for toes with (i) footedness lateralisation
% value and (ii) absolute footedness value:

load('DA_lateralization.mat');
abs_handedness = abs(handedness);
abs_footedness = abs(footedness);

% Overall toe accuracy value for each of the 19 individuals:
t_acc_indiv_all = mean(t_acc_indiv);
DI_out.t_acc_indiv_all = t_acc_indiv_all;

% figure;
% subplot(2,2,1);
% scatter(handedness, t_acc_indiv_all, 'kx', 'LineWidth', 2);
% 
% subplot(2,2,2);
% scatter(footedness, t_acc_indiv_all, 'kx', 'LineWidth', 2);
% 
% subplot(2,2,3);
% scatter(abs_handedness, t_acc_indiv_all, 'kx', 'LineWidth', 2);
% 
% subplot(2,2,4);
% scatter(abs_footedness, t_acc_indiv_all, 'kx', 'LineWidth', 2);

% Pearson's linear correlation coefficient between dominance value and
% accuracy:
[rp_acc(1,1), rp_acc(1,2)] = corr(handedness', t_acc_indiv_all');
[rp_acc(2,1), rp_acc(2,2)] = corr(footedness', t_acc_indiv_all');
[rp_acc(3,1), rp_acc(3,2)] = corr(abs_handedness', t_acc_indiv_all');
[rp_acc(4,1), rp_acc(4,2)] = corr(abs_footedness', t_acc_indiv_all');

DI_out.rp_acc = rp_acc;

% 3b. Compare accuracy for toes 2 and 3 with (i) footedness lateralization
% value and (ii) absolute footedness value:

% Toe 2 accuracy for each of the 19 individuals: 
toe2_acc = t_acc_indiv(2, :);

% Toe 3 accuracy for each of the 19 individuals: 
toe3_acc = t_acc_indiv(3,:);

% Pearson's correlation coefficient between footedness, or absolute
% footedness, and toe 2 or 3 accuracy:

[rp_acc2(1,1), rp_acc2(1,2)] = corr(footedness', toe2_acc');
[rp_acc2(2,1), rp_acc2(2,2)] = corr(abs_footedness', toe2_acc');

[rp_acc3(1,1), rp_acc3(1,2)] = corr(footedness', toe3_acc');
[rp_acc3(2,1), rp_acc3(2,2)] = corr(abs_footedness', toe3_acc');

DI_out.rp_acc2 = rp_acc2;
DI_out.rp_acc3 = rp_acc3;


% 3c. Compare DI for toes 2 and 3 separately with (i) footedness
% lateralization value and (ii) absolute footedness value:

% Toe 2 DI for each of the 19 individuals:
toe2_DI = DI_out.DI_output(7,:);

% Toe 3 DI for each of the 19 individuals:
toe3_DI = DI_out.DI_output(8,:);

figure;
subplot(2,2,1);
scatter(footedness, toe2_DI, 'kx', 'LineWidth', 2);

subplot(2,2,2);
scatter(abs_footedness, toe2_DI, 'kx', 'LineWidth', 2);

subplot(2,2,3);
scatter(footedness, toe3_DI, 'kx', 'LineWidth', 2);

subplot(2,2,4);
scatter(abs_footedness, toe3_DI, 'kx', 'LineWidth', 2);

% Pearson's correlation coefficient between footedness, or absolute
% footedness, and toe 2 or 3 DI:

[rp_DI2(1,1), rp_DI2(1,2)] = corr(footedness', toe2_DI');
[rp_DI2(2,1), rp_DI2(2,2)] = corr(abs_footedness', toe2_DI');

[rp_DI3(1,1), rp_DI3(1,2)] = corr(footedness', toe3_DI');
[rp_DI3(2,1), rp_DI3(2,2)] = corr(abs_footedness', toe3_DI');

DI_out.rp_DI2 = rp_DI2;
DI_out.rp_DI3 = rp_DI3;


% 3d. Compare directionality index for middle toes with (i) lateralization
% direction and (ii) absolute lateralization degree (R & L):

t_dir_indiv_mids = mean(DI_out.DI_output(7:8, :));
DI_out.t_dir_indiv_mids = t_dir_indiv_mids;

% figure;
% subplot(2,2,1);
% scatter(handedness, t_dir_indiv_mids, 'kx', 'LineWidth', 2);
%
% subplot(2,2,2);
% scatter(footedness, t_dir_indiv_mids, 'kx', 'LineWidth', 2);
%
% subplot(2,2,3);
% scatter(abs_handedness, t_dir_indiv_mids, 'kx', 'LineWidth', 2);
%
% subplot(2,2,4);
% scatter(abs_footedness, t_dir_indiv_mids, 'kx', 'LineWidth', 2);

[rp_dir(1,1), rp_dir(1,2)] = corr(handedness', t_dir_indiv_mids');
[rp_dir(2,1), rp_dir(2,2)] = corr(footedness', t_dir_indiv_mids');
[rp_dir(3,1), rp_dir(3,2)] = corr(abs_handedness', t_dir_indiv_mids');
[rp_dir(4,1), rp_dir(4,2)] = corr(abs_footedness', t_dir_indiv_mids');

DI_out.rp_dir = rp_dir;

%
% 3c. Compare accuracy and directionality index for dominant versus
% non-dominant feet:

fid = fopen(list2, 'r');
a = textscan(fid, '%s');

for n = 1:length(a{1})
    load(a{1}{n})
    
    [F_DI_output(:,n), F_resps_all(:,:,n), F_t_acc_indiv(:,n)] = DA_get_dir_F(data);
    
end

DI_out.F_DI_output = F_DI_output;
DI_out.F_resps_all = F_resps_all;
DI_out.F_t_acc_indiv = F_t_acc_indiv



% Getting population descriptive stats for accuracy on nondominant toes

DI_out.nondom_t_acc_means = mean(DI_out.F_t_acc_indiv,2);
DI_out.nondom_t_acc_all_mean = mean(mean(DI_out.F_t_acc_indiv));

for j = 1:5
    DI_out.nondom_t_acc_sd(j) = std(DI_out.F_t_acc_indiv(j,:));
end
DI_out.nondom_t_acc_all_std = std(mean(DI_out.F_t_acc_indiv));

for j = 1:5
    DI_out.nondom_t_acc_range(j,1) = min(DI_out.F_t_acc_indiv(j,:));
    DI_out.nondom_t_acc_range(j,2) = max(DI_out.F_t_acc_indiv(j,:));
end
DI_out.nondom_t_acc_all_range(1) = min(mean(DI_out.F_t_acc_indiv));
DI_out.nondom_t_acc_all_range(2) = max(mean(DI_out.F_t_acc_indiv));

% Getting population descriptive stats for DI on nondominant toes

DI_out.nondom_t_DI_means = mean(DI_out.F_DI_output,2);
DI_out.nondom_t_DI_all_mean = mean(mean(DI_out.F_DI_output));

for j = 1:5
    DI_out.nondom_t_DI_sd(j) = std(DI_out.F_DI_output(j,:));
end
DI_out.nondom_t_DI_all_std = std(mean(DI_out.F_DI_output));

for j = 1:5
    DI_out.nondom_t_DI_range(j,1) = min(DI_out.F_DI_output(j,:));
    DI_out.nondom_t_DI_range(j,2) = max(DI_out.F_DI_output(j,:));
end
DI_out.nondom_t_DI_all_range(1) = min(mean(DI_out.F_DI_output));
DI_out.nondom_t_DI_all_range(2) = max(mean(DI_out.F_DI_output));

% Some statistical tests for nondom DI middles toes:
[H, P] = lillietest(DI_out.F_DI_output(2,:));
[H, P] = lillietest(DI_out.F_DI_output(3,:));
[H, P] = lillietest(DI_out.F_DI_output(4,:));

[H, P, CI, STATS] = ttest(DI_out.F_DI_output(2,:));
[H, P, CI, STATS] = ttest(DI_out.F_DI_output(3,:));
[H, P, CI, STATS] = ttest(DI_out.F_DI_output(4,:));

% Need to index the DI outputs from the previous analyses above such that
% they are only of those subjects who also have non-dominant foot data.

idx_dom = [1 2 3 4 6 8 9 15 18 19];

% Accuracy comparisons:

clear hp;
dom_acc_overall = mean(t_acc_indiv(:,idx_dom)); % All toes combined
nondom_acc_overall = mean(F_t_acc_indiv); % All toes combined

% [hp(1,1), hp(1,2)] = ranksum(dom_acc_overall, nondom_acc_overall);
[hp(1,1), hp(1,2)] = ttest(dom_acc_overall, nondom_acc_overall); % H0 Lillietest
figure;
subplot(2,2,1);
scatter(dom_acc_overall, nondom_acc_overall);
axis([-1 1 -1 1]);
hold on
plot([-1 1],[-1 1]);

dom_acc_toe2 = t_acc_indiv(2,idx_dom);
nondom_acc_toe2 = F_t_acc_indiv(2,:);
% [hp(2,1), hp(2,2)] = ranksum(dom_acc_toe2, nondom_acc_toe2);
[hp(2,1), hp(2,2)] = ttest(dom_acc_toe2, nondom_acc_toe2); % H0 Lillietest
subplot(2,2,2);
scatter(dom_acc_toe2, nondom_acc_toe2);
axis([-1 1 -1 1]);
hold on
plot([-1 1],[-1 1]);

dom_acc_toe3 = t_acc_indiv(3,idx_dom);
nondom_acc_toe3 = F_t_acc_indiv(3,:);
% [hp(3,1), hp(3,2)] = ranksum(dom_acc_toe3, nondom_acc_toe3);
[hp(3,1), hp(3,2)] = ttest(dom_acc_toe3, nondom_acc_toe3); % H0 Lillietest
subplot(2,2,3);
scatter(dom_acc_toe3, nondom_acc_toe3);
axis([-1 1 -1 1]);
hold on
plot([-1 1],[-1 1]);

dom_acc_toe4 = t_acc_indiv(4,idx_dom);
nondom_acc_toe4 = F_t_acc_indiv(4,:);
% [hp(4,1), hp(4,2)] = ranksum(dom_acc_toe4, nondom_acc_toe4);
[hp(4,1), hp(4,2)] = ttest(dom_acc_toe4, nondom_acc_toe4); % H0 Lillietest
subplot(2,2,4);
scatter(dom_acc_toe4, nondom_acc_toe4);
axis([-1 1 -1 1]);
hold on
plot([-1 1],[-1 1]);
close;

DI_out.dom_acc_overall = dom_acc_overall;
DI_out.dom_acc_toe2 = dom_acc_toe2;
DI_out.dom_acc_toe3 = dom_acc_toe3;
DI_out.dom_acc_toe4 = dom_acc_toe4;
DI_out.nondom_acc_overall = nondom_acc_overall;
DI_out.nondom_acc_toe2 = nondom_acc_toe2;
DI_out.nondom_acc_toe3 = nondom_acc_toe3;
DI_out.nondom_acc_toe4 = nondom_acc_toe4;

DI_out.dom_nondom_acc_hp = hp;
%close;
%
clear hp;

% Directionality comparisons: done only for toes 2 and 3 which were
% significant for the dominant foot:

dom_dir_overall = mean(DI_output(7:8,idx_dom)); % Toes 2 & 3 combined by taking an average.
nondom_dir_overall = mean(F_DI_output(2:3, :)); % Toes 2 & 3 combined by taking an average.
% [hp(1,1), hp(1,2)] = ranksum(dom_acc_overall, nondom_acc_overall);
[hp(1,1), hp(1,2)] = ttest(dom_dir_overall, nondom_dir_overall); % H0 Lillietest
% figure;
% subplot(2,2,1);
% scatter(dom_dir_overall, nondom_dir_overall);
% axis([-1 1 -1 1]);
% hold on
% plot([-1 1],[-1 1]);

dom_dir_toe2 = DI_output(7,idx_dom); % Toe 2
nondom_dir_toe2 = F_DI_output(2,:);
% [hp(2,1), hp(2,2)] = ranksum(dom_acc_toe2, nondom_acc_toe2);
[hp(2,1), hp(2,2)] = ttest(dom_dir_toe2, nondom_dir_toe2); % H0 Lillietest
% subplot(2,2,2);
% scatter(dom_dir_toe2, nondom_dir_toe2);
% axis([-1 1 -1 1]);
% hold on
% plot([-1 1],[-1 1]);

dom_dir_toe3 = DI_output(8,idx_dom); % Toe 3
nondom_dir_toe3 = F_DI_output(3,:);
% [hp(2,1), hp(2,2)] = ranksum(dom_acc_toe2, nondom_acc_toe2);
[hp(3,1), hp(3,2)] = ttest(dom_dir_toe3, nondom_dir_toe3); % H0 Lillietest
% subplot(2,2,3);
% scatter(dom_dir_toe3, nondom_dir_toe3);
% axis([-1 1 -1 1]);
% hold on
% plot([-1 1],[-1 1]);

% dom_dir_toe4 = DI_output(9,idx_dom);
% nondom_dir_toe4 = F_DI_output(4,:);
% % [hp(2,1), hp(2,2)] = ranksum(dom_acc_toe2, nondom_acc_toe2);
% [hp(4,1), hp(4,2)] = ttest(dom_dir_toe4, nondom_dir_toe4);
% subplot(2,2,4);
% scatter(dom_dir_toe4, nondom_dir_toe4);
% axis([-1 1 -1 1]);
% hold on
% plot([-1 1],[-1 1]);

DI_out.dom_dir_overall = dom_dir_overall;
DI_out.dom_dir_toe2 = dom_dir_toe2;
DI_out.dom_dir_toe3 = dom_dir_toe3;
DI_out.nondom_dir_overall = nondom_dir_overall;
DI_out.nondom_dir_toe2 = nondom_dir_toe2;
DI_out.nondom_dir_toe3 = nondom_dir_toe3;

% Full statistical tests for indiv toes dom vs non-dom:

%[H, P, CI, STATS] = ttest(DI_out.dom_dir_toe2, clDI_out.nondom_dir_toe2)
%[H, P, CI, STATS] = ttest(DI_out.dom_dir_toe3, DI_out.nondom_dir_toe3)

DI_out.dom_nondom_dir_hp = hp;

% Figure
figure;
subplot(2,2,[1 2]);
scatter(dom_dir_toe2, nondom_dir_toe2, 'ok', 'LineWidth', 1.2, 'MarkerFaceColor', 'w');
hold on
scatter(dom_dir_toe3, nondom_dir_toe3, 'ok', 'LineWidth', 1.2, 'MarkerFaceColor', 'k');
hold on
plot([-0.2 1],[-0.2 1], 'k', 'LineWidth', 1);
axis([-0.2 1 -0.2 1]);
legend('toe 2', 'toe 3', 'Location', 'SouthEast');
%title('Directionality Errors: Toes 2 & 3', 'FontSize', 14);
xlabel('DI: dominant side', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('DI: non-dominant side', 'FontSize', 12, 'FontName', 'Times New Roman');
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman');
hold on

close


% %3d. What is the mean toe 2 & 3 dir biases for those 9 participants who
% %reported agnosia? Dominant side only.
%
% idx_agnosia = [1 3 4 6 7 9 10 11 19];
%
% t2_meandir_agnosia = mean(DI_output(7,idx_agnosia));
% t3_meandir_agnosia = mean(DI_output(8,idx_agnosia));



%3e. Effect of order of toe stimulation: Toes 2 & 3 on dominant side only.

% For each subject, need to get the response/dir values for toe 2
% stimulated either immediately after toe 1 or after toe 5. Then do a
% paired t-test or Wilcoxon test across subjects to see whether toe 2
% directionality is significantly affected by preceeding toe stimulation.

% To this end, need to write a new script that, for each subject, takes out
% all of the toe 2 responses that are after either toe 1 or toe 5
% stimulation, calculates the directionality, and spits it back here.

fid = fopen(list, 'r');
a = textscan(fid, '%s');


% TOE 2:
for n = 1:length(a{1})
    load(a{1}{n})
    
    [t2_dir_prev1(n), t2_dir_prev5(n)] = toe2_dir_preceeding(data);
    
end

DI_out.t2_dir_prev1 = t2_dir_prev1;
DI_out.t2_dir_prev5 = t2_dir_prev5;

fid = fopen(list, 'r');
a = textscan(fid, '%s');


% TOE 3:
for n = 1:length(a{1})
    load(a{1}{n})
    
    [t3_dir_prev1(n), t3_dir_prev5(n)] = toe3_dir_preceeding(data);
    
end

DI_out.t3_dir_prev1 = t3_dir_prev1;
DI_out.t3_dir_prev5 = t3_dir_prev5;


% TOE 4:
for n = 1:length(a{1})
    load(a{1}{n})
    
    [t4_dir_prev1(n), t4_dir_prev5(n)] = toe4_dir_preceeding(data);
    
end

DI_out.t4_dir_prev1 = t4_dir_prev1;
DI_out.t4_dir_prev5 = t4_dir_prev5;

% Figure and statistics:

%figure;
subplot(2,2,3);
scatter(t2_dir_prev1, t2_dir_prev5, 'ko', 'LineWidth', 1.1, 'MarkerFaceColor', 'w');
axis([-1 1.25 -1 1.25]);
hold on
plot([-1 1.25],[-1 1.25], 'k');
hold on
xlabel('DI: previous toe 1', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('DI: previous toe 5', 'FontSize', 12, 'FontName', 'Times New Roman');
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman');

subplot(2,2,4);
scatter(t3_dir_prev1, t3_dir_prev5, 'ko', 'LineWidth', 1.1, 'MarkerFaceColor', 'k');
axis([-1 1.25 -1 1.25]);
hold on
plot([-1 1.25],[-1 1.25], 'k');
xlabel('DI: previous toe 1', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('DI: previous toe 5', 'FontSize', 12, 'FontName', 'Times New Roman');
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman');

close

% % Plot results of toe 4, just out of interest:
% figure;
% scatter(t4_dir_prev1, t4_dir_prev5, 'ko', 'LineWidth', 1.1, 'MarkerFaceColor', 'k');
% axis([-1 1.25 -1 1.25]);
% hold on
% plot([-1 1.25],[-1 1.25], 'k');
% title('Stimulation Order: Toe 4', 'FontSize', 14);
% xlabel('DI (prev: Toe 1)', 'FontSize', 12);



[prev_hp(1,1), prev_hp(1,2)] = ranksum(t2_dir_prev1, t2_dir_prev5); % H1 Lillietest
[prev_hp(2,1), prev_hp(2,2)] = ttest(t3_dir_prev1, t3_dir_prev5); % H0 Lillietest
DI_out.prev_dir_hp = prev_hp;



% Extra Stats with DI_out data:
% [H, P, CI, STATS] = ttest(DI_out.DI_output(9,:))
% [H, P, CI, STATS] = ttest(DI_out.DI_output(8,:))
% [H, P, CI, STATS] = ttest(DI_out.DI_output(7,:))
% [H, P, CI, STATS] = ttest([DI_out.DI_output(7,:) DI_out.DI_output(8,:) DI_out.DI_output(9,:)])
% [H, P, CI, STATS] = ttest(DI_out.dom_dir_overall, DI_out.nondom_dir_overall)
% [H, P, CI, STATS] = ttest(DI_out.t2_dir_prev5, DI_out.t2_dir_prev1)
% [H, P, CI, STATS] = ttest(DI_out.t3_dir_prev5, DI_out.t3_dir_prev1)








end