% TEST_CAMERA ... 
%  
%   ... 

%% AUTHOR    : Ben 
%% $DATE     : 17-May-2015 18:30:32 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : test_camera.m 

info = imaqhwinfo                                 % ���ϵͳ������ͷ  

win_info = imaqhwinfo('winvideo')
dev_win_info = win_info.DeviceInfo
dev_win_info.SupportedFormats                     % ����ͷ֧�ֵ�ͼ���ʽ

% vid = videoinput('winvideo',1);
% preview(vid)
% closepreview
% delete vid

obj_v = videoinput('winvideo',1,'MJPG_640x480');

frame = getsnapshot(obj_v);
imshow(frame)

delete(obj_v);

%% End_of_File  
% Created with NM.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [test_camera.m] ======  
