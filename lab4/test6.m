% 读取图像
image1 = imread("/home/ubuntu/Downloads/matlab/lab4/fig/pout.bmp");


% rect1
M = size(image1, 1);
N = size(image1, 2);
D0 = 10;
% 设计滤波器
ideal = get_filter(1, M, N, D0, 2, 0);
btw = get_filter(2, M, N, D0, 2, 0);
gaussion = get_filter(3, M, N, D0, 2, 0);

% 进行高通滤波
output_1_ideal = freqfilter(image1, ideal);
output_1_btw = freqfilter(image1, btw);
output_1_gaussion = freqfilter(image1, gaussion);

% 直方图均衡化
output1 = histeq((uint8(output_1_ideal)));
output2 = histeq((uint8(output_1_btw)));
output3 = histeq((uint8(output_1_gaussion)));

% 先直方图均衡化
image12 = histeq(image1);

% 进行滤波，高斯噪声
output_2_ideal = freqfilter(image12, ideal);
output_2_btw = freqfilter(image12, btw);
output_2_gaussion = freqfilter(image12, gaussion);

% 显示结果
figure;
subplot(2, 4, 1); imshow(image1); title('原始图像1');
subplot(2, 4, 2); imshow(output1, []); title('ideal + histeq');
subplot(2, 4, 3); imshow(output2, []); title('btw + histeq');
subplot(2, 4, 4); imshow(output3, []); title('gaussion + histeq');
% subplot(2, 4, 5); imshow(image12, []); title('');
subplot(2, 4, 6); imshow(output_2_ideal, []); title('histeq + ideal');
subplot(2, 4, 7); imshow(output_2_btw, []); title('histeq + btw');
subplot(2, 4, 8); imshow(output_2_gaussion, []); title('histeq + gaussion');




set(gcf, 'Position', get(0,'Screensize')); % 使图形窗口最大化
% 保存
filename = '/home/ubuntu/Downloads/matlab/lab4/fig/';
saveas(gcf, [filename 'test6.png']);


function H = get_filter(type, M, N, D0, n, check)
    % 为M*N大小的图像生成一个滤波器
    % type: 滤波器类型
    % 1- idea
    % 2- Butterworth
    % 3- Gaussian
    % D0: 截止频率
    % n: 指数/阶数
    % check: 是否显示滤波器，用于展示
    [U,V] = meshgrid(-N/2:N/2-1,-M/2:M/2-1); %构建坐标,默认已经将频域的中心移到矩阵的中心
    D = hypot(U,V);%计算中心偏移距离
    
    % Generate filter based on type
    switch type
        case 1
            H = D > D0;
        case 2
            if n == 0
                error('The order of Butterworth filter cannot be 0.');
            end
            H = 1./(1 + (D0./D).^(2*n));
        case 3
            H = exp(-(D0./D).^n);
        otherwise
            error('Unsupported filter type.');
    end
    
    if check
        % Normalize filter to range [0, 1]
        H = H / max(H(:));
        % Create a 2D filter
        % H = H .* (H > 0.01); % Apply threshold to filter
        % Display filter if check is true
        figure;
        imshow(H, []);
        title(['Filter Type: ', num2str(type)]);
        colormap(gray);
        colorbar;
    end
    % return H;
end

function output = freqfilter(img, H)
    % 傅里叶变换并且将频谱移到中心
    F = fft2(img);
    F = fftshift(F);
    
    % 对每一个点进行滤波检查操作，等价于执行get_filter函数对对应点规定的函数
    G = F .* H;
    
    % 将频谱移回原点并且进行反傅里叶变换
    G = ifftshift(G);
    output = abs(ifft2(G));
end