function main3()
filenames = {'m5kr30_1.mat','m5kr30_2.mat','m5kr30_3.mat','m5kr30_4.mat', ...
             'm5kr30_5.mat','m5kr30_6.mat','m5kr30_7.mat','m5kr30_8.mat', ...
             'm5kr30_9.mat','m5kr30_10.mat'};

numfiles = length(filenames);
num_algs = 4;  % out1 ~ out4
alg_names = {'RRGN', 'RRN', 'RCG', 'RGD'};
line_styles = {'-r', '--b', '-.g', ':m'};  % 彩色线型

recordg_all = cell(num_algs, 1);
maxlen_each = zeros(num_algs, 1);

% 第一步：加载数据
for i = 1:numfiles
    data = load(filenames{i});
    for j = 1:num_algs
        tmp = data.(['out' num2str(j)]).recordg(:);
        if i == 1
            recordg_all{j} = {tmp};
        else
            recordg_all{j}{end+1} = tmp;
        end
        maxlen_each(j) = max(maxlen_each(j), length(tmp));
    end
end

% 计算每个算法的平均迭代步数
mean_iters = zeros(num_algs, 1);
for j = 1:num_algs
    mean_iters(j) = mean(cellfun(@length, recordg_all{j}));
end
mean_iters=round(mean_iters);

% 第二步：平均并对齐长度（NaN填补）
mean_recordg = cell(num_algs, 1);
for j = 1:num_algs
    rec_mat = NaN(maxlen_each(j), numfiles);
    for i = 1:numfiles
        vec = recordg_all{j}{i};
        rec_mat(1:length(vec), i) = vec;
    end
    mean_recordg{j} = mean(rec_mat, 2, 'omitnan');
end

% 找到最长的曲线长度（用于横坐标范围）
maxlen = max(cellfun(@length, mean_recordg));

% 第三步：统一长度，短的补NaN，保持semilogy的格式
for j = 1:num_algs
    %len = length(mean_recordg{j});
    len=mean_iters(j);
    if len < maxlen
        mean_recordg{j}(len+1:maxlen) = NaN;
    end
end
save('figm5kr30.mat','mean_recordg','num_algs','maxlen','line_styles','alg_names');
% figure;
% hold on;
% for j = 1:num_algs
%     plot(1:maxlen, log10(mean_recordg{j}), line_styles{j}, 'LineWidth', 2);
% end
% hold off;
% 
% % 坐标轴调整为log10刻度（纵轴值为 log10(norm)）
% yticks(-12:2:0);
% yticklabels({'10^{-12}', '10^{-10}', '10^{-8}','10^{-6}', '10^{-4}', '10^{-2}',  '10^{0}'});
% ylim([-12, 0]);
% 
% % 其他设置
% xlim([1 maxlen]);
% xticks(0:50:maxlen);
% set(gca, 'FontSize',13, 'LineWidth', 1.5);
% xlabel('Iteration', 'FontSize',14 , 'FontWeight', 'bold');
% ylabel('log_{10}(Gradient Norm)', 'FontSize',14 , 'FontWeight', 'bold');
% legend(alg_names, 'Location', 'northeast', 'FontSize', 13);
% grid on;
% title(' Matrix size m=n=7500 and rank r=50', 'FontSize', 14);
