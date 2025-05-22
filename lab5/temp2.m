lena = (imread("/home/ubuntu/Downloads/matlab/lab5/fig/lena.bmp"));
[m, n] = size(lena);


% graythresh 函数使用大津法（OTSU）自动计算图像的阈值。
% T 是一个标量，表示计算得到的阈值，范围在0到1之间。用于imbinarize的二值分割
T = graythresh(lena);
lena_2 = imbinarize(lena, T);

count = tabulate(lena(:));
total = m * n;

% 选择237的原因是，最大为238，否则会超出count的范围，导致报错，这是实验出来的

max = 0;
for i = 2 : 237
    n0 = sum(count(1:i - 1, 2));
    w0 = n0 / total;
    n1 = sum(count(i + 1:238, 2));
    w1 = n1 / total;
    % u0,u1计算灰度均值
    if (n0 == 0)
        u0 = 0;
    else
        u0 = sum(count(1:i-1, 2) .* count(1:i-1, 1)) / n0;
    end
    if (n1 == 0)
        u1 = 0;
    else
        u1 = sum(count(i+1:238, 2) .* count(i+1:238, 1)) / n1;
    end
    
    g = w0 * w1 * (u0 - u1)^2;
    if g > max
        max = g;
        maxT = i;
    end
end

lena_3 = imbinarize(lena, maxT/256);

figure();
subplot(1, 3, 1);
imshow(lena);
title("Lena 原始图");

subplot(1, 3, 2);
imshow(lena_2, []);
title("Lena 二值分割图（调用函数实现）");

subplot(1, 3, 3);
imshow(lena_3, []);
title("Lena 二值分割图（自己实现）");


filename = '/home/ubuntu/Downloads/matlab/lab5/fig/';
saveas(gcf, [filename 'temp2.png']);