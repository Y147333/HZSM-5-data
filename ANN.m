%setdemorandstream(pi);
%Y=xlsread('total');%读取数据
load Y.mat;
%定义训练样本
p=Y(1:30264,1:2197);
t1=Y(30265,1:2197);
t=(t1-min(t1))/(max(t1)-min(t1));
%创建一个新的BP网络
net=newff(p,t,[200, 200, 200],{'tansig','tansig','tansig'},'traincgb');
% 当前输入层权值和阈值
%inputWeights=net.IW{1,1};
%inputbias=net.b{1};
% 当前网络层权值和阈值
%layerWeights=net.LW{1,1};
%layerbias=net.b{2};
%设置训练参数
net.trainParam.epochs=1000;
net.trainParam.goal=0.000001;
net.trainParam.show=10;
net.trainParam.lr=0.05;
net.trainParam.max_fail=10;
%save('traincgf1');
%rand('state',0);
net=train(net,p,t); % 训练网络
%[net.b,net.iw,net.lw] = separatewb(net,wb);%将保存的wb值输入到net的权值中
%load('traincgf1.mat');
p1=Y(1:30264,2198:2295);
A1=sim(net,p1);   %网络仿真
A=A1*(max(t1)-min(t1))+min(t1);
B1=sim(net,p);
B=B1*(max(t1)-min(t1))+min(t1);
plot(2198:2295,Y(30265,2198:2295),'r',2198:2295,A,'b');%验证仿真函数
legend('VASP Energy','ANN Energy');
A3=A-Y(30265,2198:2295);   %获得绝对误差
%plot(A3)
Z=Y(30265,2198:2295);
%wb = formwb(net,net.b,net.iw,net.lw);
