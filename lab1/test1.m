% 读取图像
image = imread('image1.jpg');

% 显示图像
figure;
imshow(image);
title('原图像');

% 获取图像的大小
[height, width, channels] = size(image);

% 获取输入的平移量
hx = input('请输入水平平移量: ');
vy = input('请输入垂直平移量: ');

% for quick test
% hx = 100; % 水平平移量
% vy = 50;  % 垂直平移量

% 创建平移矩阵
move = [1 0 hx; 0 1 vy; 0 0 1];

% 创建一个对应大小的空白图像
new_image = zeros(height, width, channels, 'uint8');
% figure;
% imshow(new_image);

% 对每个像素进行平移
for x = 1:width
    for y = 1:height

        % 原始扩展坐标
        original = [x; y; 1];

        % 计算新的坐标
        new = move * original;
        new_x = new(1);
        new_y = new(2);

        % 检查新的坐标是否在图像范围内
        if new_x > 0 && new_x <= width && new_y > 0 && new_y <= height
            % 将原图像的像素值赋值给新图像
            new_image(new_y, new_x, :) = image(y, x, :);
        end
        
    end
end

% 显示平移后的图像
figure;
imshow(new_image);
title('平移后的图像');