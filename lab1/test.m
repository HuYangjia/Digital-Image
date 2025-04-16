% 读取图像
image = imread('image1.jpg');

% 显示图像
figure;
imshow(image);
title('原图像');

% 获取图像的大小
[height, width, channels] = size(image);

% 设置旋转角度（以弧度为单位）
theta = deg2rad(30); % 旋转角度为0度

% 计算图像中心
cx = width / 2;
cy = height / 2;

% 创建旋转矩阵
rotate = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];

% 创建平移矩阵（先平移到原点，再平移回中心）
move_to_origin = [1 0 -cx; 0 1 -cy; 0 0 1];
move_back = [1 0 cx; 0 1 cy; 0 0 1];

% 组合变换矩阵
transform = move_back * rotate * move_to_origin;
transform
% 创建输出图像
bilinear = zeros(height, width, channels, 'uint8');

% 对每个像素进行变换
for x = 1:width
    for y = 1:height
        % 原始坐标
        original = [x; y; 1];
        % 变换后的坐标
        new = transform * original;
        new_x = new(1);
        new_y = new(2);
        
        % 检查新坐标是否在图像范围内
        if new_x >= 1 && new_x < width && new_y >= 1 && new_y < height
            % 双线性插值
            x_floor = floor(new_x);
            y_floor = floor(new_y);
            x_ceil = x_floor + 1;
            y_ceil = y_floor + 1;
            
            % 确保不超出边界
            x_ceil = min(x_ceil, width);
            y_ceil = min(y_ceil, height);
            
            % 插值权重
            alpha = new_x - x_floor;
            beta = new_y - y_floor;
            
            % 双线性插值计算
            for c = 1:channels
                bilinear(y, x, c) = ...
                    (1 - alpha) * (1 - beta) * image(y_floor, x_floor, c) + ...
                    alpha * (1 - beta) * image(y_floor, x_ceil, c) + ...
                    (1 - alpha) * beta * image(y_ceil, x_floor, c) + ...
                    alpha * beta * image(y_ceil, x_ceil, c);
            end
        end
    end
end

% 显示双线性插值后的图像
figure;
imshow(bilinear);
title('双线性插值后的图像');
