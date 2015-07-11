function [] = parse_mov(mov_name)
% PARSE_MOV ... 解析视频，把视频解析成图片
%  
%   ... mov_name视频文件名，不含后缀
%   ... 
%  parse_mov('1')

%% AUTHOR    : Ben 
%% $DATE     : 11-May-2015 10:52:55 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : parse_mov.m 

nFrames = getFrames(mov_name);

mkdir(mov_name);

for i = 1:nFrames
    temp_im = mov2im_one(mov_name,i);
    imwrite(temp_im,[mov_name,'\',num2str(i),'.jpg']);
end


%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [parse_mov.m] ======  
