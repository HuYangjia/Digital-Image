% 多种方式比较

filename = '/home/ubuntu/Downloads/matlab/lab3/fig/';
image = imread([filename 'cameraman.bmp']);
image_pepper = imread([filename 'pepper_noise.png']);
image_gaussian = imread([filename 'gaussian_noise.png']);
image_random = imread([filename 'random_noise.png']);


% 均值滤波
filter_average = fspecial('average', 3);
image_average_pepper = imfilter(image_pepper, filter_average);
image_average_gaussian = imfilter(image_gaussian, filter_average);
image_average_random = imfilter(image_random, filter_average);

% 中值滤波
image_median_pepper = medfilt2(image_pepper, [3 3]);
image_median_gaussian = medfilt2(image_gaussian, [3 3]);
image_median_random = medfilt2(image_random, [3 3]);

% 超限邻域平均法
image_overaverage_pepper = over_average(image_pepper);
image_overaverage_gaussian = over_average(image_gaussian);
image_overaverage_random = over_average(image_random);

% 超限邻域中值法
image_overmedian_pepper = over_median(image_pepper);
image_overmedian_gaussian = over_median(image_gaussian);
image_overmedian_random = over_median(image_random);

% 显示所有
subplot(5, 4, [1, 5, 9, 13, 17]);imshow(image);title('原始图像');
subplot(5, 4, 2);imshow(image_pepper);title('椒盐噪声图像');
subplot(5, 4, 3);imshow(image_gaussian);title('高斯噪声图像');
subplot(5, 4, 4);imshow(image_random);title('随机噪声图像');
subplot(5, 4, 6);imshow(image_average_pepper);title('均值滤波椒盐噪声图像');
subplot(5, 4, 7);imshow(image_average_gaussian);title('均值滤波高斯噪声图像');
subplot(5, 4, 8);imshow(image_average_random);title('均值滤波随机噪声图像');
subplot(5, 4, 10);imshow(image_median_pepper);title('中值滤波椒盐噪声图像');
subplot(5, 4, 11);imshow(image_median_gaussian);title('中值滤波高斯噪声图像');
subplot(5, 4, 12);imshow(image_median_random);title('中值滤波随机噪声图像');
subplot(5, 4, 14);imshow(image_overaverage_pepper);title('超限邻域平均椒盐噪声图像');
subplot(5, 4, 15);imshow(image_overaverage_gaussian);title('超限邻域平均高斯噪声图像');
subplot(5, 4, 16);imshow(image_overaverage_random);title('超限邻域平均随机噪声图像');
subplot(5, 4, 18);imshow(image_overmedian_pepper);title('超限邻域中值椒盐噪声图像');
subplot(5, 4, 19);imshow(image_overmedian_gaussian);title('超限邻域中值高斯噪声图像');
subplot(5, 4, 20);imshow(image_overmedian_random);title('超限邻域中值随机噪声图像');

% 调整子图间距
set(gcf, 'Position', get(0,'Screensize')); % 使图形窗口最大化

saveas(gcf, [filename 'subplot_all.png']);




function result = over_average(input)
    % 得到均值滤波后的图像
    filter_average = fspecial('average', 3);
    image_tmp = imfilter(input, filter_average);
    
    % 计算差值
    T = 50;
    place = abs(input - image_tmp) > T;

    % 应用超限邻域平均法
    result = input; 
    result(place) = image_tmp(place); 
    % 返回结果
    return;
end

function result = over_median(input)
    % 得到中值滤波后的图像
    image_tmp = medfilt2(input, [3 3]);
    
    % 计算差值
    T = 20;
    place = abs(input - image_tmp) > T;

    % 应用超限中值平均法
    result = input; 
    result(place) = image_tmp(place); 
    % 返回结果
    return;
end
    