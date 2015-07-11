function [nFrames] = getFrames(filename)
% GETFRAMES ... ��ȡmov��Ƶ�ļ�����֡��
%  
%   ... filenameΪmov�ļ�����������׺
%   ... nFramesΪ��֡��
%  nFrames = getFrames('1')

%% AUTHOR    : Ben 
%% $DATE     : 05-May-2015 20:42:07 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : getFrames.m 

movObj = VideoReader([filename,'.mov']);
nFrames = movObj.NumberOfFrames;

%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [getFrames.m] ======  
