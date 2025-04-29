% 读取图像
image = imread('/home/ubuntu/Downloads/matlab/lab2/fig/pout.bmp');

% 显示图像
figure;
imshow(image);
title('原图像');



% low = input("input low: ");
% high = input("input high: ");

% for quick test
low = 50;
high = 200;



gray_range = [low, high];
num_bins = diff(gray_range) + 1;
counts = histcounts(image, num_bins, 'BinLimits', gray_range); 
bar(gray_range(1):gray_range(2), counts); % 显示灰度直方图
xlim([low high]); % 设置X轴范围
xlabel('Gray level'); % 设置X轴标签
ylabel('Count'); % 设置Y轴标签

% 保存直方图
saveas(gcf, '/home/ubuntu/Downloads/matlab/lab2/fig/histogram.png'); % 保存为PNG格式

% figure;
% histogram(image);



% % 水平拼接两张图像
% img_concatenated = cat(2, image, new_image);
% imshow(img_concatenated)
% % 保存拼接后的图像
% imwrite(img_concatenated, '/home/ubuntu/Downloads/matlab/lab2/fig/image2_move.jpg');