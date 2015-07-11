function [] = WriteSerial(obj_scom, str)
% WRITESERIAL ... 在串口写入字串
%  
%   ... obj_scom为要写入的串口对象，str为要写入的字串
%   ... 
%  WriteSerial(scom, str)

%% AUTHOR    : Ben 
%% $DATE     : 14-May-2015 19:15:55 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : WriteSerial.m 

% function WriteSerial(scom, str)
% fprintf(obj_scom, str ,'async'); % 异步方式
fprintf(obj_scom, str);

%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [WriteSerial.m] ======  
