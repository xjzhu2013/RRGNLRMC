function main1(alg_names,line_styles,maxlen,mean_recordg,num_algs)

figure;
hold on;
for j = 1:num_algs
    plot(1:maxlen, log10(mean_recordg{j}), line_styles{j}, 'LineWidth', 2);
end
hold off;

% 坐标轴调整为log10刻度（纵轴值为 log10(norm)）
yticks(-12:2:0);
yticklabels({'10^{-12}', '10^{-10}', '10^{-8}','10^{-6}', '10^{-4}', '10^{-2}',  '10^{0}'});
ylim([-12, 0]);

% 其他设置
xlim([1 maxlen]);
xticks(0:50:maxlen);
set(gca, 'FontSize',15, 'LineWidth', 1.5);
xlabel('Iteration', 'FontSize',15 , 'FontWeight', 'bold');
ylabel('log_{10}(Gradient Norm)', 'FontSize',15 , 'FontWeight', 'bold');
legend(alg_names, 'Location', 'northeast', 'FontSize', 15);
grid on;
title(' Matrix size m=n=5000 and rank r=30', 'FontSize', 15);
end