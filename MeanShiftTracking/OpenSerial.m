function [obj_scom] = OpenSerial(scom_name)
% OPENSERIAL ... �򿪴���
%  
%   ... scom_nameΪҪ�򿪵Ĵ���
%   ... obj_scomΪ�򿪵Ĵ��ڶ���
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
    fprintf('%s��ʧ�ܡ�\n', scom_name);
    return;
end

fprintf('%s�ɹ��򿪡�\n', scom_name);

%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [OpenSerial.m] ======  
