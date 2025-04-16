% 读取图像
image = imread('image1.jpg');

% 获取图像的大小
[height, width, channels] = size(image);

% 获取输入的平移量
a = input('请输入a: ');
b = input('请输入b: ');

% for quick test
% a = 2;
% b = 2;

% 计算真的平移量
% a = a+width/2;
% b = b+height/2;


% 创建并计算移动矩阵
fact = [a 0 0; 0 b 0; 0 0 1];
fact = fact';

% 反向计算新图像的一个点在原图像中的位置

% 创建一个对应大小的空白图像
nearist = zeros(height, width, channels, 'uint8');
bilinear = zeros(height, width, channels, 'uint8');

% 对每个像素进行平移
for x = 1:width
    for y = 1:height

        % 目标扩展坐标
        original = [x; y; 1];

        % 计算原始坐标
        new = fact * original;
        new_x = new(1);
        new_y = new(2);

        % if(x==a+1 && y==b+1)
        %     fprintf('x = %d, y = %d\n', new_x, new_y);
        % end

        % 检查新的坐标是否在图像范围内
        if new_x >= 1 && new_x <= width && new_y >= 1 && new_y <= height
            % 最近邻相关
            x_floor = floor(new_x);
            y_floor = floor(new_y);
            x_ceil = ceil(new_x);
            y_ceil = ceil(new_y);
            % 采用最近点法，选取距离最近点的像素赋给新图像
            if (new_x - x_floor) <= (x_ceil - new_x)
                new_x = x_floor;
            else
                new_x = x_ceil;
            end
            if (new_y - y_floor) <= (y_ceil - new_y)
                new_y = y_floor;
            else
                new_y = y_ceil;
            end
            nearist(y, x, :) = image(new_y, new_x, :); % 最近邻插值法
        end
        % 双线性插值
        if new_x >= 2 && new_x <= width - 2 && new_y >= 2 && new_y <= height - 2
            
            x_1 = floor(new_x);
            x_2 = floor(new_x) + 1;
            x_3 = floor(new_x);
            x_4 = floor(new_x) + 1;

            y_1 = floor(new_y);
            y_2 = floor(new_y);
            y_3 = floor(new_y) + 1;
            y_4 = floor(new_y) + 1;

            p1 = image(y_1, x_1, :);
            p2 = image(y_2, x_2, :);
            p3 = image(y_3, x_3, :);
            p4 = image(y_4, x_4, :);
            
            s = new_x - x_1;
            t = new_y - y_1;
            bilinear(y, x, :) = (1 - s) * (1 - t) * p1 + (1 - s) * t * p3 + (1 - t) * s * p2 + s * t * p4; % 双线性插值法
        end
    end
end

% 显示平移后的图像
figure;
imshow(nearist),
title('最近邻');

figure;
imshow(bilinear),
title('双线性');

% 水平拼接两张图像
img_concatenated = cat(2, image, nearist, bilinear);

% 保存拼接后的图像
imwrite(img_concatenated, '/home/ubuntu/Downloads/matlab/lab1/image3_move.jpg');