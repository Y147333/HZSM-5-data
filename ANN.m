%setdemorandstream(pi);
%Y=xlsread('total');%��ȡ����
load Y.mat;
%����ѵ������
p=Y(1:30264,1:2197);
t1=Y(30265,1:2197);
t=(t1-min(t1))/(max(t1)-min(t1));
%����һ���µ�BP����
net=newff(p,t,[200, 200, 200],{'tansig','tansig','tansig'},'traincgb');
% ��ǰ�����Ȩֵ����ֵ
%inputWeights=net.IW{1,1};
%inputbias=net.b{1};
% ��ǰ�����Ȩֵ����ֵ
%layerWeights=net.LW{1,1};
%layerbias=net.b{2};
%����ѵ������
net.trainParam.epochs=1000;
net.trainParam.goal=0.000001;
net.trainParam.show=10;
net.trainParam.lr=0.05;
net.trainParam.max_fail=10;
%save('traincgf1');
%rand('state',0);
net=train(net,p,t); % ѵ������
%[net.b,net.iw,net.lw] = separatewb(net,wb);%�������wbֵ���뵽net��Ȩֵ��
%load('traincgf1.mat');
p1=Y(1:30264,2198:2295);
A1=sim(net,p1);   %�������
A=A1*(max(t1)-min(t1))+min(t1);
B1=sim(net,p);
B=B1*(max(t1)-min(t1))+min(t1);
plot(2198:2295,Y(30265,2198:2295),'r',2198:2295,A,'b');%��֤���溯��
legend('VASP Energy','ANN Energy');
A3=A-Y(30265,2198:2295);   %��þ������
%plot(A3)
Z=Y(30265,2198:2295);
%wb = formwb(net,net.b,net.iw,net.lw);
