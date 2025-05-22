% 对图像 flower1.jpg 设置运动位移 30 个像素、运动方向 45 度，产生运动模糊图
% 像，对其采用逆滤波和维纳滤波进行恢复，显示、对比分析恢复结果图像。对产生
% 的运动模糊图像加高斯噪声，产生有噪声图像，分别对其采用逆滤波和维纳滤波进
% 行恢复，显示、对比分析恢复结果图像。


image = imread("/home/ubuntu/Downloads/matlab/lab5/fig/flower1.jpg");

image_double = im2double(image);

% 运动模糊
angle = 45; % 运动方向
len = 30; % 运动位移
h = fspecial('motion', len, angle); % 运动模糊滤波器
% blurred_image = imfilter(image_double, h, 'conv', 'circular'); % 运动模糊图像
blurred_image = imfilter(image_double, h, 'conv'); % 运动模糊图像
% blurred_image = imfilter(image_double, h, 'conv', 'replicate'); % 运动模糊图像
% blurred_image = imfilter(image_double, h, 'conv', 'symmetric'); % 运动模糊图像
% hint: 发现只有 'circular' 方式能得到较好的效果
% 搜索明白，采用的滤波手段对频率成分敏感，而其他参数会引入非周期性的错误频率，极大影响滤波效果

% 加高斯噪声
noise = imnoise(blurred_image, 'gaussian', 0, 0.01); % 高斯噪声

% 修复
% 逆滤波
result_inverse_1 = deconvwnr(blurred_image, h); % 逆滤波
result_inverse_2 = deconvwnr(noise, h); % 逆滤波

% 维纳滤波
% 需要信噪比的倒数，对于没有高斯噪声的情况，设置一个超小值
result_wiener_1 = deconvwnr(blurred_image, h, 0.0001); % 维纳滤波
num =  var(noise(:)) / 0.01; % 计算信噪比
result_wiener_2 = deconvwnr(noise, h, 1/num); % 维纳滤波


subplot(2, 4, 1); imshow(image_double); title('原始图像');
subplot(2, 4, 2); imshow(blurred_image); title('运动模糊图像');
subplot(2, 4, 3); imshow(noise); title('运动模糊+高斯噪声图像');

subplot(2, 4, 5); imshow(result_inverse_1); title('逆滤波恢复图像');
subplot(2, 4, 6); imshow(result_wiener_1); title('维纳滤波恢复图像');
subplot(2, 4, 7); imshow(result_inverse_2); title('高斯+逆滤波恢复图像');
subplot(2, 4, 8); imshow(result_wiener_2); title('高斯+维纳滤波恢复图像');

% 保存
filename = '/home/ubuntu/Downloads/matlab/lab5/fig/';
saveas(gcf, [filename 'temp1.png']);