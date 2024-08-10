function X = mixed_radix_fft(x, factors)
    % 确保输入序列长度与因子乘积相等
    N = length(x);
    if prod(factors) ~= N
        error('输入序列的长度与因子乘积不相等');
    end

    % 初始化输出向量
    X = zeros(size(x));

    % 基本情况：当输入序列长度为1时，直接返回输入序列
    if N == 1
        X = x;
    else
        % 混合基FFT的因子分解
        num_factors = length(factors);
        factors = [factors, 1]; % 添加额外的1以处理最后一层

        % 递归地计算混合基FFT
        for i = 1:num_factors
            % 对当前因子进行FFT
            factor = factors(i);
            sub_length = N / factor;
            sub_indices = 1:sub_length;

            for j = 0:(factor-1)
                % 求取每个因子的基数根
                twiddle_factor = exp(-2i * pi * j * sub_indices / N);

                % 对每个子序列进行FFT
                start_index = j * sub_length + 1;
                end_index = (j + 1) * sub_length;
                sub_x = x(start_index:end_index);
                sub_fft = mixed_radix_fft(sub_x, factors(1:end_index-1));

                % 合并每个子序列的FFT结果
                X(start_index:end_index) = twiddle_factor .* sub_fft;
            end
        end
    end
end
