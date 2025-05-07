% 均值滤波

filename = '/home/ubuntu/Downloads/matlab/lab3/fig/';
image = imread([filename 'cameraman.bmp']);
image_pepper = imread([filename 'pepper_noise.png']);
image_gaussian = imread([filename 'gaussian_noise.png']);
image_random = imread([filename 'random_noise.png']);

% 均值滤波
filter_average = fspecial('average', 3);

image_average_pepper = imfilter(image_pepper, filter_average);
image_average_gaussian = imfilter(image_gaussian, filter_average);
image_average_random = imfilter(image_random, filter_average);

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
title('均值滤波椒盐噪声图像');

subplot(2, 4, 7);
imshow(image_average_gaussian);
title('均值滤波高斯噪声图像');

subplot(2, 4, 8);
imshow(image_average_random);
title('均值滤波随机噪声图像');

% 调整子图间距
set(gcf, 'Position', get(0,'Screensize')); % 使图形窗口最大化
% subplots_adjust('hspace', 0.5); % 增加垂直间距

% 保存均值滤波结果
saveas(gcf, [filename 'subplot_average.png']);