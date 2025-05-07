% 用超限邻域平均法去除图像中的噪声

% 似乎没有直接的函数实现

% 与均值滤波，相比，每个像素在均值前后的差值决定了选择均值还是原值，可以利用这一点做文章
filename = '/home/ubuntu/Downloads/matlab/lab3/fig/';
image = imread([filename 'cameraman.bmp']);
image_pepper = imread([filename 'pepper_noise.png']);
image_gaussian = imread([filename 'gaussian_noise.png']);
image_random = imread([filename 'random_noise.png']);

% 均值滤波
filter_average = fspecial('average', 3);

% image_average_pepper_tmp = imfilter(image_pepper, filter_average);
% image_average_gaussian_tmp = imfilter(image_gaussian, filter_average);
% image_average_random_tmp = imfilter(image_random, filter_average);

image_average_pepper = myFun(image_pepper);
image_average_gaussian = myFun(image_gaussian);
image_average_random = myFun(image_random);

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
imshow(image_average_pepper);
title('超限邻域椒盐噪声图像');

subplot(2, 4, 7);
imshow(image_average_gaussian);
title('超限邻域高斯噪声图像');

subplot(2, 4, 8);
imshow(image_average_random);
title('超限邻域随机噪声图像');

subplot(2, 4, 5);
imshow(imfilter(image_pepper, filter_average));
title('均值滤波椒盐噪声图像');

% 调整子图间距
set(gcf, 'Position', get(0,'Screensize')); % 使图形窗口最大化

% 保存均值滤波结果
saveas(gcf, [filename 'subplot_overlimit.png']);


function result = myFun(input)
%myFun - Description
%
% Syntax: output = myFun(input)
%
% Long description
    % 得到均值滤波后的图像
    filter_average = fspecial('average', 3);
    image_tmp = imfilter(input, filter_average);
    
    % 计算差值
    T = 50;
    place = abs(input - image_tmp) > T;

    % 应用超限邻域平均法
    result = input; 
    result(place) = image_tmp(place); 
    % 返回结果
    return;
end
