clear

%   讀取柴犬飛飛.jpg
img_path = "柴犬飛飛.jpg";
img = imread(img_path);

%   取得image的size
[X,Y,Z] = size(img);

%   轉成double格式
double_img = im2double(img);

%   --------------------(a)小題--------------------
%   取得R、G、B的3個channel
R = double_img(:,:,1);
G = double_img(:,:,2);
B = double_img(:,:,3);

%   zero padding
z1_R = zeros(642);
z1_G = zeros(642);
z1_B = zeros(642);
z2_R = zeros(646);
z2_G = zeros(646);
z2_B = zeros(646);
z3_R = zeros(652);
z3_G = zeros(652);
z3_B = zeros(652);
for i = 1 : 640
    for j = 1 : 640
        z1_R(i+1, j+1) = R(i,j);
        z1_G(i+1, j+1) = G(i,j);
        z1_B(i+1, j+1) = B(i,j);
        z2_R(i+3, j+3) = R(i,j);
        z2_G(i+3, j+3) = G(i,j);
        z2_B(i+3, j+3) = B(i,j);
        z3_R(i+6, j+6) = R(i,j);
        z3_G(i+6, j+6) = G(i,j);
        z3_B(i+6, j+6) = B(i,j);
    end
end

%   3 Gaussian filters
G1 = fspecial( 'gaussian', [3 3], 1);
G2 = fspecial( 'gaussian', [7 7], 1);
G3 = fspecial( 'gaussian', [13 13], 1);
%   (b)小題的3個gaussian filter，使用不同的sigma值
G4 = fspecial( 'gaussian', [3 3], 1);
G5 = fspecial( 'gaussian', [3 3], 30);
G6 = fspecial( 'gaussian', [3 3], 100);
G7 = [-1 -1 -1;-1 8 -1;-1 -1 -1];
G8 = [-1 -2 -1;0 0 0;1 2 1];
G9 = [-1 0 1;-2 0 2;-1 0 1];

%   新的rgb channel
R1_new = [640,640];
G1_new = [640,640];
B1_new = [640,640];
R2_new = [640,640];
G2_new = [640,640];
B2_new = [640,640];
R3_new = [640,640];
G3_new = [640,640];
B3_new = [640,640];
R4_new = [640,640];
G4_new = [640,640];
B4_new = [640,640];
R5_new = [640,640];
G5_new = [640,640];
B5_new = [640,640];
R6_new = [640,640];
G6_new = [640,640];
B6_new = [640,640];
R7_new = [640,640];
G7_new = [640,640];
B7_new = [640,640];
R8_new = [640,640];
G8_new = [640,640];
B8_new = [640,640];
R9_new = [640,640];
G9_new = [640,640];
B9_new = [640,640];

%   做圖片的捲積
for i = 1 : X
   for j = 1 : Y
    %   ----------------------------------------------------------------
    %   3*3 gaussian filter   
    %   --------R channel--------
    
    tmp = z1_R([i:i+2],[j:j+2]);    %   找出3*3matrix
    value = sum(sum(G1.*tmp));   %   跟gaussian filter相乘並算出sum
    R1_new(i,j) = value;  %   存放到新的位置
    %   b小題
    value = sum(sum(G4.*tmp));  %   sigma = 1    
    R4_new(i,j) = value;
    value = sum(sum(G5.*tmp));  %   sigma = 30     
    R5_new(i,j) = value;  
    value = sum(sum(G6.*tmp));  %   sigma = 100    
    R6_new(i,j) = value;
    %   c小題
    value = sum(sum(G7.*tmp));  %   sigma = 1   
    R7_new(i,j) = value;
    value = sum(sum(G8.*tmp));  %   sigma = 1   
    R8_new(i,j) = value;
    value = sum(sum(G9.*tmp));  %   sigma = 1   
    R9_new(i,j) = value;
    
    %   --------G channel--------
    
    tmp = z1_G([i:i+2],[j:j+2]);   %   找出3*3matrix
    value = sum(sum(G1.*tmp));  %   跟gaussian filter相乘並算出sum
    G1_new(i,j) = value;  %   存放到新的位置 
    %   b小題
    value = sum(sum(G4.*tmp));  %   sigma = 1   
    G4_new(i,j) = value;
    value = sum(sum(G5.*tmp));  %   sigma = 30   
    G5_new(i,j) = value;  
    value = sum(sum(G6.*tmp));  %   sigma = 100    
    G6_new(i,j) = value;
    %   c小題
    value = sum(sum(G7.*tmp));  %   sigma = 1   
    G7_new(i,j) = value;
    value = sum(sum(G8.*tmp));  %   sigma = 1   
    G8_new(i,j) = value;
    value = sum(sum(G9.*tmp));  %   sigma = 1   
    G9_new(i,j) = value;
    
    %   --------B channel--------
    
    tmp = z1_B([i:i+2],[j:j+2]);   %   找出3*3matrix
    value = sum(sum(G1.*tmp));  %   跟gaussian filter相乘並算出sum
    B1_new(i,j) = value; %   存放到新的位置
    %   b小題
    value = sum(sum(G4.*tmp));  %   sigma = 1     
    B4_new(i,j) = value;
    value = sum(sum(G5.*tmp));  %   sigma = 30     
    B5_new(i,j) = value;  
    value = sum(sum(G6.*tmp));  %   sigma = 100    
    B6_new(i,j) = value;
    %   c小題
    value = sum(sum(G7.*tmp));  %   sigma = 1   
    B7_new(i,j) = value;
    value = sum(sum(G8.*tmp));  %   sigma = 1   
    B8_new(i,j) = value;
    value = sum(sum(G9.*tmp));  %   sigma = 1   
    B9_new(i,j) = value;
    
    %   ----------------------------------------------------------------
    %   7*7 gaussian filter   
    %   --------R channel--------
    
    tmp = z2_R([i:i+6],[j:j+6]);    %   找出3*3matrix
    value = sum(sum(G2.*tmp));   %   跟gaussian filter相乘並算出sum
    R2_new(i,j) = value;  %   存放到新的位置
    
    %   --------G channel--------
    
    tmp = z2_G([i:i+6],[j:j+6]);   %   找出3*3matrix
    value = sum(sum(G2.*tmp));  %   跟gaussian filter相乘並算出sum
    G2_new(i,j) = value;  %   存放到新的位置
    
    %   --------B channel--------
    
    tmp = z2_B([i:i+6],[j:j+6]);   %   找出3*3matrix
    value = sum(sum(G2.*tmp));  %   跟gaussian filter相乘並算出sum
    B2_new(i,j) = value; %   存放到新的位置
    
    %   ----------------------------------------------------------------
    %   13*13 gaussian filter   
    %   --------R channel--------
    
    tmp = z3_R([i:i+12],[j:j+12]);    %   找出3*3matrix
    value = sum(sum(G3.*tmp));   %   跟gaussian filter相乘並算出sum
    R3_new(i,j) = value;  %   存放到新的位置
    
    %   --------G channel--------
    
    tmp = z3_G([i:i+12],[j:j+12]);   %   找出3*3matrix
    value = sum(sum(G3.*tmp));  %   跟gaussian filter相乘並算出sum
    G3_new(i,j) = value;  %   存放到新的位置
    
    %   --------B channel--------
    
    tmp = z3_B([i:i+12],[j:j+12]);   %   找出3*3matrix
    value = sum(sum(G3.*tmp));  %   跟gaussian filter相乘並算出sum
    B3_new(i,j) = value; %   存放到新的位置
    
    %   ----------------------------------------------------------------
   end
end

%   把rgb合併
a1_img = cat(3, R1_new, G1_new, B1_new);
a2_img = cat(3, R2_new, G2_new, B2_new);
a3_img = cat(3, R3_new, G3_new, B3_new);
b1_img = cat(3, R4_new, G4_new, B4_new);
b2_img = cat(3, R5_new, G5_new, B5_new);
b3_img = cat(3, R6_new, G6_new, B6_new);
c1_img = cat(3, R7_new, G7_new, B7_new);
c2_img = cat(3, R8_new, G8_new, B8_new);
c3_img = cat(3, R9_new, G9_new, B9_new);

%   寫檔
imwrite(a1_img,'a_1.jpg');
imwrite(a2_img,'a_2.jpg');
imwrite(a3_img,'a_3.jpg');
imwrite(b1_img,'b_1.jpg');
imwrite(b2_img,'b_2.jpg');
imwrite(b3_img,'b_3.jpg');
imwrite(c1_img, 'unsharp.jpg');
imwrite(c2_img, 'horizontal_edge.jpg');
imwrite(c3_img, 'vertical_edge.jpg');

%   計算psnr
ret = psnr(a1_img, double_img);
ret
ret = psnr(a2_img, double_img);
ret
ret = psnr(a3_img, double_img);
ret
ret = psnr(b1_img, double_img);
ret
ret = psnr(b2_img, double_img);
ret
ret = psnr(b3_img, double_img);
ret
ret = psnr(c1_img, double_img);
ret
ret = psnr(c2_img, double_img);
ret
ret = psnr(c3_img, double_img);
ret

%   --------------------(b)小題--------------------


%   新的RGB

