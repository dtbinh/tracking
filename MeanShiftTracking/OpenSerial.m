function [obj_scom] = OpenSerial(scom_name)
% OPENSERIAL ... 打开串口
%  
%   ... scom_name为要打开的串口
%   ... obj_scom为打开的串口对象
%  obj_scom = OpenSerial('com5')

%% AUTHOR    : Ben 
%% $DATE     : 14-May-2015 19:11:09 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : OpenSerial.m 
% function scom = OpenSerial(sname, HReadFcn)

obj_scom = serial(scom_name);
% obj_scom.BytesAvailableFcnMode = 'terminator';
% obj_scom.Terminator = '.';
% obj_scom.BytesAvailableFcn = HReadFcn;

try
    fopen(obj_scom);
catch
    fprintf('%s打开失败。\n', scom_name);
    return;
end

fprintf('%s成功打开。\n', scom_name);

%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [OpenSerial.m] ======  
