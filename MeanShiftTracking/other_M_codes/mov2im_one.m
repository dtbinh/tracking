function [I] = mov2im_one(filename,idx)
% MOV2IM_ONE ... ��ȡָ��mov��Ƶ��ָ��һ֡ͼ��
%  
%   ... filenameΪmov�ļ�����idxΪָ��֡
%   ... IΪ�������ͼ������
%  I = mov2im_one('1',2)

%% AUTHOR    : Ben 
%% $DATE     : 05-May-2015 17:20:12 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : mov2im_one.m 

movObj = VideoReader([filename,'.mov']);
nFrames = movObj.NumberOfFrames;
if idx > nFrames                                   % �ж�ʱ���Ƿ񳬳���֡��
    msgbox('�����֡��������֡�������������룡');
    I = false;
    return;
end
I = read(movObj,idx);                               % ��ͼ

%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [mov2im_one.m] ======  
