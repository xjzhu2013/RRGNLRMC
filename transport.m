function [M_plus, U_p_plus, V_p_plus] =transport(U, V, U_p, M, V_p, U_plus, V_plus)
% 计算向量传输 T_{X->X_plus}(v)
% 输入:
%   U, V: 当前点 X = U*diag(S)*V' 的因子矩阵
%   U_p, M, V_p: 切向量 v = U*M*V' + U_p*V' + U*V_p'
%   U_plus, V_plus: 目标点 X_plus = U_plus*diag(S_plus)*V_plus' 的因子矩阵
% 输出:
%   M_plus, U_p_plus, V_p_plus: 传输后的切向量表示

% 步骤1: 计算投影矩阵
A_v = V' * V_plus;   % V^T V_plus
A_u = U' * U_plus;   % U^T U_plus

% 步骤2: 计算辅助矩阵
B_v = V_p' * V_plus; % V_p^T V_plus
B_u = U_p' * U_plus; % U_p^T U_plus

% 步骤3: 计算第一分量
M_plus1 = A_u' * M * A_v;
U_plus1 = U * (M * A_v);
V_plus1 = V * (M' * A_u);

% 步骤4: 计算第二分量
M_plus2 = B_u' * A_v;
U_plus2 = U_p * A_v;
V_plus2 = V * B_u;

% 步骤5: 计算第三分量
M_plus3 = A_u' * B_v;
U_plus3 = U * B_v;
V_plus3 = V_p * A_u;

% 步骤6: 合并M分量
M_plus = M_plus1 + M_plus2 + M_plus3;

% 步骤7: 合并并正交化U分量
U_p_plus = U_plus1 + U_plus2 + U_plus3;
proj_U = U_plus' * U_p_plus;     % 投影到U_plus空间
U_p_plus = U_p_plus - U_plus * proj_U; % 正交化

% 步骤8: 合并并正交化V分量
V_p_plus = V_plus1 + V_plus2 + V_plus3;
proj_V = V_plus' * V_p_plus;     % 投影到V_plus空间
V_p_plus = V_p_plus - V_plus * proj_V; % 正交化
end