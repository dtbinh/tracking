% MAIN ... 

%% AUTHOR    : Ben 
%% $DATE     : 25-May-2015 11:09:49 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : main.m 

clc;
close all;
clear all;
%% %%%%%%%%%%%%%%%% ����һ��Ŀ��ȫ�ɼ���ͼ��Ȧ������Ŀ�� %%%%%%%%%%%%%%%%%%%%%%%

obj_v = videoinput('winvideo',1,'MJPG_320x240');    % ������ͷ,�ɵ�
obj_scom = OpenSerial('com5');                      % �򿪴��ڣ��ɵ�

% % �ɴ��ڷ��͡�f5��ָ��ſ�ʼ��ͼ����
% while(1)
%     if ((obj_scom.BytesAvailable) && (fread(obj_scom,1) == hex2dec('f5')))
%         break;
%     end
% end

%     % �����趨��rect�Զ�ѡȡĿ��
% I = getsnapshot(obj_v);                             % ץȡһ������ͷͼ��
% figure(1);
% imshow(I);
% rect = [95.5100   75.5100  129.9800  104.9800];     % rectΪ�����Ŀ������
% rect = [132.5100   65.5100   43.9800  108.9800];
% temp = imcrop(I,round(rect));                        % ��ͼ����ѡĿ��ģ�� 
% [a,b,c]=size(temp);                                  

    % �ֶ�ѡȡĿ��
I = getsnapshot(obj_v);                              % ץȡһ������ͷͼ��
im_width = size(I,2);                                % im_widthͼ����
figure(1);
imshow(I);
[temp,rect]=imcrop(I);                               % ��ͼ����ѡĿ��ģ�� 
[rows_temp,cols_temp,c]=size(temp);                  % ˫��ѡ�е�Ŀ��ģ�� ��ʼִ�к�������

%% %%%%%%%%%%%%%%%%%%%%%%%%%%% ����Ŀ��ͼ���Ȩֵ���� %%%%%%%%%%%%%%%%%%%%%

center_des(1)=rows_temp/2;                          % center_des���Ŀ���������
center_des(2)=cols_temp/2;
m_wei=zeros(rows_temp,cols_temp);                   % m_weiȨֵ����
h=sqrt(center_des(1)^2+center_des(2)^2) ;           % h����
for i=1:rows_temp
    for j=1:cols_temp
        dist=sqrt((i-center_des(1))^2+(j-center_des(2))^2);           % ����ÿһ�㵽���ĵľ���
        m_wei(i,j)=1-dist/h;                        % epanechnikov profile    �˺���     ���ݾ������Ȩ�أ�����Խ��ֵԽ��
    end
end
C=1/sum(sum(m_wei));                                % CΪ��һ��ϵ��

%����Ŀ��Ȩֱֵ��ͼqu
hist1=zeros(1,4097);                                % hist1���Ŀ���ֱ��ͼ��Ϣ
                                                    % rgb��ɫ�ռ�����Ϊ16*16*16 bins
q_rgb = fix(double(temp)/16);                       % fixΪ����0ȡ������
q_temp = q_rgb(:,:,1)*256+q_rgb(:,:,2)*16+q_rgb(:,:,3);% �����������ͨ����һ���Ҷ�
                                                    % q_temp�����ͨ����һ���Ҷ�
for i=1:rows_temp
    for j=1:cols_temp         
        hist1(q_temp(i,j)+1)= hist1(q_temp(i,j)+1)+m_wei(i,j);    %����ֱ��ͼͳ����ÿ�����ص�ռ��Ȩ��
    end
end
hist1=hist1*C;
rect(3)=ceil(rect(3));
rect(4)=ceil(rect(4));

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%  ��ȡ����ͼ�񣬸���  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

l = 1;                                  % l��¼���ٵ�֡��������õ�ʱ���ɾ

% �ɴ��ڷ��͡�f4��ָ�������ͼ����
while(~((obj_scom.BytesAvailable) && (fread(obj_scom,1) == hex2dec('f4'))))
    IM = getsnapshot(obj_v);                % IMΪ��ǰ֡
    num=0;                                  % numΪÿһ֡�ĵ�������
    Y=[2,2];                                % Y��ʾƫ����,��Ϊ��ʼ��������ѭ��
        %%% mean shift����
    while((Y(1)^2+Y(2)^2>0.5)&&num<20)      % ��������            
                                            % Y��ʾƫ������ƫ��������һ����ֵʱ�������е��� 
       num=num+1;                           
       temp1=imcrop(IM,round(rect)); 
       % �����ѡ����ֱ��ͼ                                
       hist2=zeros(1,4097); 
       q_rgb = fix(double(temp1)/16);       % fixΪ����0ȡ������
       q_temp1 = q_rgb(:,:,1)*256+q_rgb(:,:,2)*16+q_rgb(:,:,3);% �����������ͨ����һ���Ҷ�
                                            % q_temp�����ͨ����һ���Ҷ�
       for i=1:rows_temp
         for j=1:cols_temp
             hist2(q_temp1(i,j)+1)= hist2(q_temp1(i,j)+1)+m_wei(i,j);
         end
       end
       hist2=hist2*C;

       w=zeros(1,4096);
       for i=1:4096
           if(hist2(i)~=0)
              w(i)=sqrt(hist1( i)/hist2(i));
           else
              w(i)=0;
           end
       end
       
       %%% �����������λ��
       sum_w=0;
       xw=[0,0];
       for i=1:rows_temp;
           for j=1:cols_temp
               sum_w=sum_w+w(uint32(q_temp1(i,j))+1);
               xw=xw+w(uint32(q_temp1(i,j))+1)*[i-center_des(1)-0.5,j-center_des(2)-0.5];
           end
       end
       Y=xw/sum_w;
       rect(1)=rect(1)+Y(2);                    % ���ĵ�λ�ø���
       rect(2)=rect(2)+Y(1);
    end  
%% %%%%%%%%%%%%%%%%%%%%%%%  ��ͼ��ʾ���  %%%%%%%%%%%%%%%%%%%%%%%%%%
    v1=rect(1);
    v2=rect(2);
    v3=rect(3);
    v4=rect(4);
    
    imshow(uint8(IM));
    title(['frame = ',num2str(l)]);
    l = l + 1;
    hold on
    plot([v1,v1+v3],[v2,v2],[v1,v1],[v2,v2+v4],[v1,v1+v3],[v2+v4,v2+v4],[v1+v3,v1+v3],[v2,v2+v4],'LineWidth',2,'Color','r');%��ͼ�ϱ�Ǹ��ٽ��
    drawnow;
    
    cordinate_x = rect(1)*256/im_width;             % cordinate_xΪ���Ա任���Ŀ��λ��
    fwrite(obj_scom,cordinate_x);                   % �����ڷ�������

end

CloseSerial(obj_scom);                              % �رմ���
delete(obj_v);                                      % �ر�����ͷ

%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [main.m] ======  
