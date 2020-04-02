function [DI, resps, f_acc_indiv, t_acc_indiv] = DA_get_dir(data)
% Calclating the Direction Index for each digit for a given dataset. 
%
% 130305 (NC)

f_idx_1 = find(data(1:100,2) == 1);
f_idx_2 = find(data(1:100,2) == 2);
f_idx_3 = find(data(1:100,2) == 3);
f_idx_4 = find(data(1:100,2) == 4);
f_idx_5 = find(data(1:100,2) == 5);

t_idx_1 = find(data(101:250,2) == 1);
t_idx_2 = find(data(101:250,2) == 2);
t_idx_3 = find(data(101:250,2) == 3);
t_idx_4 = find(data(101:250,2) == 4);
t_idx_5 = find(data(101:250,2) == 5);

t_idx_1 = t_idx_1 + 100;
t_idx_2 = t_idx_2 + 100;
t_idx_3 = t_idx_3 + 100;
t_idx_4 = t_idx_4 + 100;
t_idx_5 = t_idx_5 + 100;


% (1) ACCURACY OF EACH FINGER RESPONSE:

f_acc(1,1) = (size(find(data(f_idx_1, 3) == 1),1))/20;
f_acc(2,1) = (size(find(data(f_idx_2, 3) == 2),1))/20;
f_acc(3,1) = (size(find(data(f_idx_3, 3) == 3),1))/20;
f_acc(4,1) = (size(find(data(f_idx_4, 3) == 4),1))/20;
f_acc(5,1) = (size(find(data(f_idx_5, 3) == 5),1))/20;


% (2) MEAN VALUE AND VARIANCE OF EACH FINGER RESPONSE:

f_acc(1,2) = mean((data(f_idx_1, 3)));
f_acc(2,2) = mean((data(f_idx_2, 3)));
f_acc(3,2) = mean((data(f_idx_3, 3)));
f_acc(4,2) = mean((data(f_idx_4, 3)));
f_acc(5,2) = mean((data(f_idx_5, 3)));

f_acc(1,3) = std((data(f_idx_1, 3)));
f_acc(2,3) = std((data(f_idx_2, 3)));
f_acc(3,3) = std((data(f_idx_3, 3)));
f_acc(4,3) = std((data(f_idx_4, 3)));
f_acc(5,3) = std((data(f_idx_5, 3)));

% (3) ACCURACY OF EACH TOE RESPONSE:

t_acc(1,1) = (size(find(data(t_idx_1, 3) == 1),1))/30;
t_acc(2,1) = (size(find(data(t_idx_2, 3) == 2),1))/30;
t_acc(3,1) = (size(find(data(t_idx_3, 3) == 3),1))/30;
t_acc(4,1) = (size(find(data(t_idx_4, 3) == 4),1))/30;
t_acc(5,1) = (size(find(data(t_idx_5, 3) == 5),1))/30;

% (4) MEAN VALUE AND VARIANCE OF EACH TOE RESPONSE:

t_acc(1,2) = mean((data(t_idx_1, 3)));
t_acc(2,2) = mean((data(t_idx_2, 3)));
t_acc(3,2) = mean((data(t_idx_3, 3)));
t_acc(4,2) = mean((data(t_idx_4, 3)));
t_acc(5,2) = mean((data(t_idx_5, 3)));

t_acc(1,3) = std((data(t_idx_1, 3)));
t_acc(2,3) = std((data(t_idx_2, 3)));
t_acc(3,3) = std((data(t_idx_3, 3)));
t_acc(4,3) = std((data(t_idx_4, 3)));
t_acc(5,3) = std((data(t_idx_5, 3)));

% DIRECTIONALITY INDEX:

f_acc(1,4) = f_acc(1,2) - 1;
f_acc(2,4) = f_acc(2,2) - 2;
f_acc(3,4) = f_acc(3,2) - 3;
f_acc(4,4) = f_acc(4,2) - 4;
f_acc(5,4) = f_acc(5,2) - 5;

t_acc(1,4) = t_acc(1,2) - 1;
t_acc(2,4) = t_acc(2,2) - 2;
t_acc(3,4) = t_acc(3,2) - 3;
t_acc(4,4) = t_acc(4,2) - 4;
t_acc(5,4) = t_acc(5,2) - 5;

f_acc_indiv = f_acc(:,1);
t_acc_indiv = t_acc(:,1);
%f_acc_indiv = f_acc(:,3); % Should be indexed as 1
%t_acc_indiv = t_acc(:,3); % Should be indexed as 1

% OUTPUTS

output = [f_acc; t_acc];

DI = output(:,4);
%DI = output;

% (4) ABSOLUTE RESPONSES


for i = 1:5
    
    resps(i,1) = (size(find(data(f_idx_1, 3) == i),1));
end

for i = 1:5
    
    resps(i,2) = (size(find(data(f_idx_2, 3) == i),1));
end

for i = 1:5
    
    resps(i,3) = (size(find(data(f_idx_3, 3) == i),1));
end

for i = 1:5
    
    resps(i,4) = (size(find(data(f_idx_4, 3) == i),1));
end

for i = 1:5
    
    resps(i,5) = (size(find(data(f_idx_5, 3) == i),1));
end


for i = 1:5
    
    resps(i,6) = (size(find(data(t_idx_1, 3) == i),1));
end

for i = 1:5
    
    resps(i,7) = (size(find(data(t_idx_2, 3) == i),1));
end

for i = 1:5
    
    resps(i,8) = (size(find(data(t_idx_3, 3) == i),1));
end

for i = 1:5
    
    resps(i,9) = (size(find(data(t_idx_4, 3) == i),1));
end

for i = 1:5
    
    resps(i,10) = (size(find(data(t_idx_5, 3) == i),1));
end












end

