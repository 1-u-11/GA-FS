function [population] = initialPopulation(populationSize, numOfDecVariables)
% ��ͳ�Ŵ��㷨����ʼ����Ⱥ��
% ����populationSize�����壬ÿ��������numOfDecVariables��0/1��ɣ�ÿ��Ϊһ������
	population = round(rand(populationSize, numOfDecVariables));
    
%     total = sum(population') / numOfDecVariables;
%     avgTotal = sum(total) / size(total,2);                                 % ���߱���Ϊ1����ѧ����Ϊ0.5
end
