% Having run the main DA analysis script, DA_qad_DI_analysis.m, run this
% script in order to investigate dom vs non-dom DI effect on toes 2 and 3
% in a two-way ANOVA. 
%
% 150123 (NC)

% First run the script DI_out: DI_out = DA_qad_DI_analysis('DA_list.txt', 'F_list.txt')

% Some renaming: 
dom_dir_toe2 = DI_out.dom_dir_toe2;
dom_dir_toe3 = DI_out.dom_dir_toe3;
nondom_dir_toe2 = DI_out.nondom_dir_toe2;
nondom_dir_toe3 = DI_out.nondom_dir_toe3;

% I believe that we have a situation in which there are two levels for the
% column A factor (Dom versus NonDom foot), two levels for the row factor B
% (toe 2 versus toe 3), and there are 10 replications (reps = 10) because
% there are 10 participants.

test_dom = [dom_dir_toe2' nondom_dir_toe2'; dom_dir_toe3' nondom_dir_toe3'];

[P, TABLE, STATS] = anova2(test_dom, 10);
