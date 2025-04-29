% 读取图像
image = imread('/home/ubuntu/Downloads/matlab/lab2/fig/image1.bmp');

% 显示图像
figure;
imshow(image);
title('原图像');


% 获取输入的平移量
x1 = input('请输入x1: ');
y1 = input('请输入y1: ');
x2 = input('请输入x2: ');
y2 = input('请输入y2: ');

% for quick test
% x1 = 50;
% y1 = 20;
% x2 = 200;
% y2 = 230;


[m, n] = size(image); 
new_image = zeros(m, n);
for i = 1 : m
    for j = 1 : n
        if (image(i, j) < x1)
            temp = y1 / x1 * image(i, j);
        elseif (image(i, j) <= x2)
            temp = (y2 - y1)/(x2 - x1) * (image(i, j) - x1) + y1;
        else
            temp = (255 - y2) / (255 - x2) * (image(i, j) - x2) + y2;
        end


        temp = round(temp);
        if (temp < 0)
            temp = 0;
        elseif (temp > 255)
            temp = 255;
        end
%         temp
        new_image(i, j) = temp;
    end
end


% figure;
% imshow(new_image);
% title('平移后的图像');

% 水平拼接两张图像
img_concatenated = cat(2, image, new_image);
imshow(img_concatenated)
% 保存拼接后的图像
imwrite(img_concatenated, '/home/ubuntu/Downloads/matlab/lab2/fig/image2_move.jpg');