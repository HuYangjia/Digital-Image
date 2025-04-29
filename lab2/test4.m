image = imread('/home/ubuntu/Downloads/matlab/lab2/fig/pout.bmp');
subplot(3,2,1);
imshow(image);
title('原始图像');
subplot(3,2,2);
% histogram函数，用于显示图像的直方图
histogram(image);
title('原始图像直方图');

% histeq函数用于直方图均衡化
image2 = histeq(image);
subplot(3,2,3);
imshow(image2);
title('直方图均衡化后的图像');
subplot(3,2,4);
histogram(image2);
title('直方图均衡化后的图像直方图');



% 规定化需要一个目标直方图，而且是高斯分布的，使用 normpdf((0:1:255), 128, 50)产生
% normpdf(x,mu,sigma)，由于像素是离散的256哥点，所以x=0:1:255，均值mu=128，标准差sigma=50是自己设置的
image3 = histeq(image, normpdf((0:1:255), 128, 50));
subplot(3,2,5);
imshow(image3);
title('直方图规定化后的图像');
subplot(3,2,6);
histogram(image3);
title('直方图规定化后的图像直方图');