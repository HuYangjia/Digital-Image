% 读取图像
image1 = imread("/home/ubuntu/Downloads/matlab/lab4/fig/Girl.bmp");

% 添加椒盐噪声
image11 = imnoise(image1, 'salt & pepper', 0.03);

% 添加高斯噪声 , mu=0, sigma=0.1
image12 = imnoise(image1, 'gaussian', 0, 0.03); 

% rect1
M = size(image1, 1);
N = size(image1, 2);
D0 = 40;
% 设计滤波器
ideal = get_filter(1, M, N, D0, 2, 0);
btw = get_filter(2, M, N, D0, 2, 0);
gaussion = get_filter(3, M, N, D0, 2, 0);

% 进行滤波，椒盐噪声
output_1_ideal = freqfilter(image11, ideal);
output_1_btw = freqfilter(image11, btw);
output_1_gaussion = freqfilter(image11, gaussion);
% 进行滤波，高斯噪声
output_2_ideal = freqfilter(image12, ideal);
output_2_btw = freqfilter(image12, btw);
output_2_gaussion = freqfilter(image12, gaussion);

% 显示结果
figure;
subplot(2, 5, [1,6]); imshow(image1); title('原始图像1');

subplot(2, 5, 2); imshow(output_1_ideal, []); title('理想低通滤波器');
subplot(2, 5, 3); imshow(output_1_btw, []); title('巴特沃斯低通滤波器');
subplot(2, 5, 4); imshow(output_1_gaussion, []); title('高斯低通滤波器');
subplot(2, 5, 5); imshow(image11, []); title('椒盐噪声');

subplot(2, 5, 7); imshow(output_2_ideal, []); title('理想低通滤波器');
subplot(2, 5, 8); imshow(output_2_btw, []); title('巴特沃斯低通滤波器');
subplot(2, 5, 9); imshow(output_2_gaussion, []); title('高斯低通滤波器');
subplot(2, 5, 10); imshow(image12, []); title('高斯噪声');


set(gcf, 'Position', get(0,'Screensize')); % 使图形窗口最大化
% 保存
filename = '/home/ubuntu/Downloads/matlab/lab4/fig/';
saveas(gcf, [filename 'test4.png']);


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
            H = D <= D0;
        case 2
            if n == 0
                error('The order of Butterworth filter cannot be 0.');
            end
            H = 1./(1 + (D./D0).^(2*n));
        case 3
            H = exp(-(D./D0).^n);
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