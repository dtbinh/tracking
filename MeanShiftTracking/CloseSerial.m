function [] = CloseSerial(obj_scom)
% CLOSESERIAL ... 关闭串口
%  
%   ... obj_scom为要关闭的串口对象
%   ... CloseSerial(obj_scom)
%  

%% AUTHOR    : Ben 
%% $DATE     : 14-May-2015 19:18:11 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : CloseSerial.m 

try
    fclose(obj_scom);
    fprintf('%s已关闭。\n', obj_scom.name);
catch
    fprintf('%s关闭失败。\n', obj_scom.name);
    return;
end

delete(obj_scom);

%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [CloseSerial.m] ======  
