% 超限中值滤波器去除图像中的噪声


filename = '/home/ubuntu/Downloads/matlab/lab3/fig/';
image = imread([filename 'cameraman.bmp']);
image_pepper = imread([filename 'pepper_noise.png']);
image_gaussian = imread([filename 'gaussian_noise.png']);
image_random = imread([filename 'random_noise.png']);


image_median_pepper = myFun(image_pepper);
image_median_gaussian = myFun(image_gaussian);
image_median_random = myFun(image_random);

% 显示原始图像和均值滤波图像
subplot(2, 4, 1);
imshow(image);
title('原始图像');

subplot(2, 4, 2);
imshow(image_pepper);
title('椒盐噪声图像');

subplot(2, 4, 3);
imshow(image_gaussian);
title('高斯噪声图像');

subplot(2, 4, 4);
imshow(image_random);
title('随机噪声图像');

subplot(2, 4, 6);
imshow(image_median_pepper);
title('超限中值椒盐噪声图像');

subplot(2, 4, 7);
imshow(image_median_gaussian);
title('超限中值高斯噪声图像');

subplot(2, 4, 8);
imshow(image_median_random);
title('超限中值随机噪声图像');

subplot(2, 4, 5);
imshow(medfilt2(image_pepper, [3 3]));
title('中值滤波椒盐噪声图像');


% 调整子图间距
set(gcf, 'Position', get(0,'Screensize')); % 使图形窗口最大化

% 保存滤波结果
saveas(gcf, [filename 'subplot_overlimit_median.png']);


function result = myFun(input)
    % 得到中值滤波后的图像
    image_tmp = medfilt2(input, [3 3]);
    
    % 计算差值
    T = 20;
    place = abs(input - image_tmp) > T;

    % 应用超限中值平均法
    result = input; 
    result(place) = image_tmp(place); 
    % 返回结果
    return;
end
