% MAIN ... 

%% AUTHOR    : Ben 
%% $DATE     : 25-May-2015 11:09:49 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : main.m 

clc;
close all;
clear all;
%% %%%%%%%%%%%%%%%% 根据一幅目标全可见的图像圈定跟踪目标 %%%%%%%%%%%%%%%%%%%%%%%

obj_v = videoinput('winvideo',1,'MJPG_320x240');    % 打开摄像头,可调
obj_scom = OpenSerial('com5');                      % 打开串口，可调

% % 由串口发送‘f5’指令才开始读图跟踪
% while(1)
%     if ((obj_scom.BytesAvailable) && (fread(obj_scom,1) == hex2dec('f5')))
%         break;
%     end
% end

%     % 根据设定的rect自动选取目标
% I = getsnapshot(obj_v);                             % 抓取一幅摄像头图像
% figure(1);
% imshow(I);
% rect = [95.5100   75.5100  129.9800  104.9800];     % rect为自设的目标区域
% rect = [132.5100   65.5100   43.9800  108.9800];
% temp = imcrop(I,round(rect));                        % 在图像中选目标模板 
% [a,b,c]=size(temp);                                  

    % 手动选取目标
I = getsnapshot(obj_v);                              % 抓取一幅摄像头图像
im_width = size(I,2);                                % im_width图像宽度
figure(1);
imshow(I);
[temp,rect]=imcrop(I);                               % 在图像中选目标模板 
[rows_temp,cols_temp,c]=size(temp);                  % 双击选中的目标模板 开始执行后续程序

%% %%%%%%%%%%%%%%%%%%%%%%%%%%% 计算目标图像的权值矩阵 %%%%%%%%%%%%%%%%%%%%%

center_des(1)=rows_temp/2;                          % center_des存放目标矩形中心
center_des(2)=cols_temp/2;
m_wei=zeros(rows_temp,cols_temp);                   % m_wei权值矩阵
h=sqrt(center_des(1)^2+center_des(2)^2) ;           % h带宽
for i=1:rows_temp
    for j=1:cols_temp
        dist=sqrt((i-center_des(1))^2+(j-center_des(2))^2);           % 计算每一点到中心的距离
        m_wei(i,j)=1-dist/h;                        % epanechnikov profile    核函数     根据距离分配权重，距离越近值越大
    end
end
C=1/sum(sum(m_wei));                                % C为归一化系数

%计算目标权值直方图qu
hist1=zeros(1,4097);                                % hist1存放目标的直方图信息
                                                    % rgb颜色空间量化为16*16*16 bins
q_rgb = fix(double(temp)/16);                       % fix为趋近0取整函数
q_temp = q_rgb(:,:,1)*256+q_rgb(:,:,2)*16+q_rgb(:,:,3);% 计算红绿蓝三通道归一化灰度
                                                    % q_temp存放三通道归一化灰度
for i=1:rows_temp
    for j=1:cols_temp         
        hist1(q_temp(i,j)+1)= hist1(q_temp(i,j)+1)+m_wei(i,j);    %计算直方图统计中每个像素点占的权重
    end
end
hist1=hist1*C;
rect(3)=ceil(rect(3));
rect(4)=ceil(rect(4));

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%  读取序列图像，跟踪  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

l = 1;                                  % l记录跟踪的帧数，最后用的时候可删

% 由串口发送‘f4’指令结束读图跟踪
while(~((obj_scom.BytesAvailable) && (fread(obj_scom,1) == hex2dec('f4'))))
    IM = getsnapshot(obj_v);                % IM为当前帧
    num=0;                                  % num为每一帧的迭代次数
    Y=[2,2];                                % Y表示偏移量,此为初始化，进入循环
        %%% mean shift迭代
    while((Y(1)^2+Y(2)^2>0.5)&&num<20)      % 迭代条件            
                                            % Y表示偏移量，偏移量大于一定阈值时继续进行迭代 
       num=num+1;                           
       temp1=imcrop(IM,round(rect)); 
       % 计算侯选区域直方图                                
       hist2=zeros(1,4097); 
       q_rgb = fix(double(temp1)/16);       % fix为趋近0取整函数
       q_temp1 = q_rgb(:,:,1)*256+q_rgb(:,:,2)*16+q_rgb(:,:,3);% 计算红绿蓝三通道归一化灰度
                                            % q_temp存放三通道归一化灰度
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
       
       %%% 计算新坐标的位置
       sum_w=0;
       xw=[0,0];
       for i=1:rows_temp;
           for j=1:cols_temp
               sum_w=sum_w+w(uint32(q_temp1(i,j))+1);
               xw=xw+w(uint32(q_temp1(i,j))+1)*[i-center_des(1)-0.5,j-center_des(2)-0.5];
           end
       end
       Y=xw/sum_w;
       rect(1)=rect(1)+Y(2);                    % 中心点位置更新
       rect(2)=rect(2)+Y(1);
    end  
%% %%%%%%%%%%%%%%%%%%%%%%%  作图显示结果  %%%%%%%%%%%%%%%%%%%%%%%%%%
    v1=rect(1);
    v2=rect(2);
    v3=rect(3);
    v4=rect(4);
    
    imshow(uint8(IM));
    title(['frame = ',num2str(l)]);
    l = l + 1;
    hold on
    plot([v1,v1+v3],[v2,v2],[v1,v1],[v2,v2+v4],[v1,v1+v3],[v2+v4,v2+v4],[v1+v3,v1+v3],[v2,v2+v4],'LineWidth',2,'Color','r');%在图上标记跟踪结果
    drawnow;
    
    cordinate_x = rect(1)*256/im_width;             % cordinate_x为线性变换后的目标位置
    fwrite(obj_scom,cordinate_x);                   % 给串口发送坐标

end

CloseSerial(obj_scom);                              % 关闭串口
delete(obj_v);                                      % 关闭摄像头

%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [main.m] ======  
