% 用原始图像 lena.bmp 或 cameraman.bmp 分别加产生的 3%椒盐噪声、高斯噪声、随机噪声合成有噪声的图像并显示

image = imread("/home/ubuntu/Downloads/matlab/lab3/fig/cameraman.bmp");

% 添加椒盐噪声
pepper_noise = imnoise(image, 'salt & pepper', 0.03);

% 添加高斯噪声 , mu=0, sigma=0.1
gaussian_noise = imnoise(image, 'gaussian', 0, 0.03); 

% 添加随机噪声(乘性噪声)
random_noise = imnoise(image, 'speckle', 0.03);

% 显示原始图像和噪声图像
subplot(2, 2, 1);
imshow(image);
title('原始图像');

subplot(2, 2, 2);
imshow(pepper_noise);
title('椒盐噪声图像');

subplot(2, 2, 3);
imshow(gaussian_noise);
title('高斯噪声图像');

subplot(2, 2, 4);
imshow(random_noise);
title('随机噪声图像');


% 保存相关图像
saveas(gcf, '/home/ubuntu/Downloads/matlab/lab3/fig/subplot.png');
filename = '/home/ubuntu/Downloads/matlab/lab3/fig/'; % 定义文件名
imwrite(pepper_noise, [filename  'pepper_noise.png']); % 保存椒盐噪声图像
imwrite(gaussian_noise, [filename 'gaussian_noise.png']); % 保存高斯噪声图像
imwrite(random_noise, [filename 'random_noise.png']); % 保存随机噪声图像