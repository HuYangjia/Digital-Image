% open a picture
ab2 = imread('alphabet2.jpg');
ab1 = imread("alphabet1.jpg");

[mp, fp] = cpselect(ab2, ab1, 'Wait', true);

% get the coordinates of the points
tform = fitgeotrans(mp, fp, 'projective');
correct = imwarp(ab2, tform, 'OutputView', imref2d(size(ab2)));

figure;
imshow(correct);
title('Corrected Image');

% 假设ab1、ab2和correct已经是加载好的图像变量

% 创建一个新的图形窗口
figure;

% 使用subplot进行布局
subplot(1, 3, 1); % 第一个位置
imshow(ab1);
title('Image 1');

subplot(1, 3, 2); % 第二个位置
imshow(ab2);
title('Image 2');

subplot(1, 3, 3); % 第三个位置
imshow(correct);
title('Correct Image');

% 调整子图之间的间距
sgtitle('Concatenated Images'); % 可以添加总的标题

% 保存整个图形窗口为一个图像文件
print('-dpng', '/home/ubuntu/Downloads/matlab/lab1/image4_move.jpg');

