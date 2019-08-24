function [J] = JACO( theta )
%JACO ���puma560���ſ˱Ⱦ���
%   �ú���������ָ���������������ġ�
%thetaΪ�ؽڽǶȣ�JΪ�ſ˱Ⱦ���
%% �趨��ز�����ֵ
J=zeros(6,6);
a2=0.4318;
a3=0.0203;
d2=0.15005;
d4=0.4318;
%% ����������������������
%�����ؽ��˶����߾����ĵ�
r=cell(1,6);
r{1}=[0 0 0]';
r{2}=[-d2 0 0]';
r{3}=[-d2 a2 0]';
r{4}=[-d2 a2+d4 a3]';
r{5}=[-d2 a2+d4 a3]';
r{6}=[-d2 a2+d4 a3]';
%�����ؽ��˶����߷���
w=cell(1,6);
w{1}=[0 0 1]';
w{2}=[-1 0 0]';
w{3}=[-1 0 0]';
w{4}=[0 1 0]';
w{5}=[-1 0 0]';
w{6}=[0 0 1]';
%�����ؽڵ��˶�����
tw=cell(1,6);
for i=1:6
    tw{i}=Twist('R',w{i},r{i});
end
%% ����ſ˱Ⱦ���
for j=1:6
    AD=SE3(eye(4));
    for i=1:j
      if i==1
         AD=SE3(eye(4));
      else
         AD=AD*SE3(tw{i-1}.T(theta(i-1)));
      end
    end
    J(:,j)=AD.Ad*(tw{i}.double)';
end
end
