% TEST_SERIAL ... 
%  
%   ... 

%% AUTHOR    : Ben 
%% $DATE     : 14-May-2015 15:31:23 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : test_serial.m 

% obj_s = serial('com5');
% fopen(obj_s)
% disp(obj_s)
% out = fread(obj_s,20); 
% a = 25;
% fwrite(obj_s,25);
% fclose(obj_s)
% delete(obj_s)
obj_scom = OpenSerial('com5');

    % write
% WriteSerial(obj_scom, 'Hello');
% fwrite(obj_scom,25);
    % read
n = obj_scom.BytesAvailable;             % 判断串口此时是否有进入的数据
% out = fread(obj_scom,1);
% out = fscanf(obj_scom,'%f');

CloseSerial(obj_scom);


%% End_of_File  
% Created with NM.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [test_serial.m] ======  
