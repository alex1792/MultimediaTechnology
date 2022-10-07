clear

file_path = '.\dataset\training\';
img_path_list = dir(strcat(file_path,'*.bmp'));%獲取該資料夾中所有bmp格式的影象
training_num = length(img_path_list);%獲取影象總數量

%read testing images
test_path = ".\dataset\test\";
test_img_path_list = dir(strcat(test_path, '*.bmp'));
test_num = length(test_img_path_list);

%test_num = 10;
%   start comparing 
%   test data
for i = 1:test_num
   SSD_dist(i) = uint32(0); %   dist of SSD 
   SAD_dist(i) = uint32(0); %   dist of SAD
   
   test_name(i) = strcat(test_path, test_img_path_list(i).name);    %   test image name
   test = int16(imread(test_name(i)));  %   test image
   
   SSD_target_name(i) = ""; %   SSD 對應到image的file name
   SAD_target_name(i) = ""; %   SAD 對應到image的file name
   
   %training data
   for j = 1:training_num
       %    read training data and calculate dist
       training = int16(imread(strcat(file_path, img_path_list(j).name)));
       ans1 = int16(abs(test - training));
       tmp = ans1.^2;
       SSD_cons = uint32(sum(sum(tmp))); 
       SAD_cons = uint32(sum(sum(abs(ans1))));
       if j == 1
           %    save distance and target file name 
           SSD_dist(i) = uint32(SSD_cons);
           SSD_target_name(i) = strcat(file_path, img_path_list(j).name);
           
           SAD_dist(i) = uint32(SAD_cons);
           SAD_target_name(i) = strcat(file_path, img_path_list(j).name);
       else
           if SSD_cons < SSD_dist(i)
               %    save distance and target file name
               SSD_dist(i) = SSD_cons;
               SSD_target_name(i) = strcat(file_path, img_path_list(j).name);
           end
           if SAD_cons < SAD_dist(i)
               SAD_dist(i) = SAD_cons;
               SAD_target_name(i) = strcat(file_path, img_path_list(j).name);
           end
       end
       fprintf('%s\t%s%d\t%s%d\n',strcat('processing...'), strcat("image"),i, strcat("image"),j);
   end
end

%fprintf('%s\t%s\n', 'test_file', 'target_file');
SSD_correctCnt = int16(0);
SAD_correctCnt = int16(0);
for i = 1:test_num
    %   extract the catagories from file names
    SSD_target_cat = extractBetween(SSD_target_name(i), "-", "-");
    SAD_target_cat = extractBetween(SAD_target_name(i), "-", "-");
    test_cat = extractBetween(test_name(i), "-", "-");
    
    %   check if training and testing image are both same catagory
    if (strcmp(SSD_target_cat, test_cat) == 1)
        SSD_correctCnt = SSD_correctCnt + 1;
    end
    if (strcmp(SAD_target_cat, test_cat) == 1)
        SAD_correctCnt = SAD_correctCnt + 1;
    end
    %fprintf('%s\t%s\n',test_cat, target_cat);
    %fprintf('%s \t %s\n', test_name(i), SSD_target_name(i));
end

%   calculate accuracy
fprintf("%s %f\n", strcat("SAD accuracy:"), double(SAD_correctCnt) / test_num);
fprintf("%s %f\n", strcat("SSD accuracy:"), double(SSD_correctCnt) / test_num);

%   前九張圖片的測試比對結果
cnt = 0;
for i = 1:9
        testImg = imread(test_name(i));
        trainingImg = imread(SAD_target_name(i));
   
        if i == 3 || i == 6 || i == 9
            j = i + 3 * cnt;
            cnt = cnt + 1;
        else
            j = i + cnt * 3;
        end
        str1 = extractAfter(test_name(i), test_path);
        str2 = extractAfter(SAD_target_name(i), file_path);
        subplot(3, 6, j), imshow(testImg), title(str1);
        subplot(3, 6, j + 3), imshow(trainingImg), title(str2);
end


% imread()讀近來會變成unsign int 需要透過int16(imread())將
% 讀入的bmp轉成sign int，這樣算距離才不會有負數變成0的問題