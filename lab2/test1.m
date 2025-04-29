% 读取图像
image = imread('/home/ubuntu/Downloads/matlab/lab2/fig/image1.bmp');

% 显示图像
figure;
imshow(image);
title('原图像');


% 获取输入的平移量
k = input('请输入斜率: ');
b = input('请输入截距: ');

% for quick test
% k = 1; % 水平平移量
% b = 20;  % 垂直平移量

new_image = image * k + b;
% 显示平移后的图像

figure;
imshow(new_image);
title('平移后的图像');

% 水平拼接两张图像
img_concatenated = cat(2, image, new_image);

% 保存拼接后的图像
imwrite(img_concatenated, '/home/ubuntu/Downloads/matlab/lab2/fig/image1_move.jpg');