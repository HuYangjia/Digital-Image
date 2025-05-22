% 中值滤波器

filename = '/home/ubuntu/Downloads/matlab/lab3/fig/';
image = imread([filename 'cameraman.bmp']);
image_pepper = imread([filename 'pepper_noise.png']);
image_gaussian = imread([filename 'gaussian_noise.png']);
image_random = imread([filename 'random_noise.png']);


% 中值滤波
image_median_pepper = medfilt2(image_pepper, [3 3]);
image_median_gaussian = medfilt2(image_gaussian, [3 3]);
image_median_random = medfilt2(image_random, [3 3]);

% 显示原始图像和中值滤波图像
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
title('中值滤波椒盐噪声图像');

subplot(2, 4, 7);
imshow(image_median_gaussian);
title('中值滤波高斯噪声图像');

subplot(2, 4, 8);
imshow(image_median_random);
title('中值滤波随机噪声图像');

saveas(gcf, [filename 'subplot_median.png']);
