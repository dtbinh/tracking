function [] = WriteSerial(obj_scom, str)
% WRITESERIAL ... �ڴ���д���ִ�
%  
%   ... obj_scomΪҪд��Ĵ��ڶ���strΪҪд����ִ�
%   ... 
%  WriteSerial(scom, str)

%% AUTHOR    : Ben 
%% $DATE     : 14-May-2015 19:15:55 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : WriteSerial.m 

% function WriteSerial(scom, str)
% fprintf(obj_scom, str ,'async'); % �첽��ʽ
fprintf(obj_scom, str);

%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [WriteSerial.m] ======  
