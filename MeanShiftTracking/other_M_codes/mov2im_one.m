function [I] = mov2im_one(filename,idx)
% MOV2IM_ONE ... 读取指定mov视频的指定一帧图像
%  
%   ... filename为mov文件名，idx为指定帧
%   ... I为读出后的图像数据
%  I = mov2im_one('1',2)

%% AUTHOR    : Ben 
%% $DATE     : 05-May-2015 17:20:12 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : mov2im_one.m 

movObj = VideoReader([filename,'.mov']);
nFrames = movObj.NumberOfFrames;
if idx > nFrames                                   % 判断时候是否超出总帧数
    msgbox('输入的帧数超出总帧数！请重新输入！');
    I = false;
    return;
end
I = read(movObj,idx);                               % 读图

%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [mov2im_one.m] ======  
