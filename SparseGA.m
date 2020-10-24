clear;                                                                     % ��չ�����
clc;                                                                       % ��������д���

load('BaseData.mat');                                                      % ���������
% BaseData���ݽ��ܣ�3838*55��3838����¼��54����������һ�б�ʾ����0/1�����������⣬�������������⣬3253:585
testNumber = 50;                                                           % ÿ��������Դ���
% ע����Ϊ����׼ȷ�ʶ�ѵ�����Ͳ��Լ����У��ʶԸ������׼ȷ�ʣ���Ӧ�ȣ�ʱ����50��ѵ����/���Լ���ƽ��ֵ��
trainingSetAndTestSet = getTrainingSetAndTestSet(testNumber, BaseData);    % ����ѵ�����Ͳ��Լ�
save('trainingSetAndTestSet.mat', 'trainingSetAndTestSet');                % ������Լ���ѵ����

%% ��������
populationSize = 100;                                                       % ��Ⱥ��ģ
numOfDecVariables = 54;                                                    % ���߱���ά��
maxGeneration = 400;                                                       % ����������
crossoverRate = 0.6;                                                       % ������ʣ�SparseGA����Ҫ
mutationRate = 0.02;                                                       % ������ʣ�SparseGA����Ҫ

bestIndividualSet = zeros(maxGeneration, numOfDecVariables);               % ÿ�����Ÿ��弯��
bestFitnessSet = zeros(maxGeneration, 1);                                  % ÿ�������Ӧ�ȼ���
avgFitnessSet = zeros(maxGeneration, 1);                                   % ÿ��ƽ����Ӧ�ȼ���
historyIndividualRecord = zeros(1, 12);                                    % ��ʷ����⣬��1��Ϊ����ID��2��3��Ϊ�����¼�Ԥ���׼ȷ�ʣ�4-12��Ϊ��������ĸ���ֵ
% ע��������Ӧ�ȼ�����۴�Ϊ��ֹ�ظ����㣬ÿ�����������Ӧ��ǰ�ȵ���ʷ���ң��ҵ��Ļ�ֱ��ȡ��������򣬼�����Ӧ�ȣ�

%% ��ʼ��
featureMat = eye(numOfDecVariables);                                       % ��λ����
[featureScore,~,~,historyIndividualRecord] = GetFitness(featureMat, BaseData, trainingSetAndTestSet, 1, historyIndividualRecord);
% featureScoreΪÿ����������


population = sparseInitialPopulation(populationSize, numOfDecVariables, featureScore);    % ��ʼ����Ⱥ
% ������Ⱥ������Ӧ��
[popFitness,~,~,historyIndividualRecord] = GetFitness(population, BaseData, trainingSetAndTestSet, 1, historyIndividualRecord);
ratioOfSelectedFeatures = sum(population') / numOfDecVariables;



% % ��ͳ�Ŵ��㷨��ʼ����Ⱥ
% population1 = initialPopulation(populationSize, numOfDecVariables);
% [popFitness1,~,~,historyIndividualRecord] = GetFitness(population1, BaseData, trainingSetAndTestSet, 1, historyIndividualRecord);
% ratioOfSelectedFeatures1 = sum(population1') / numOfDecVariables;
% 
% % ��ͼ����ʼ��Ⱥ�Ա�
% plot(ratioOfSelectedFeatures,popFitness,'o',ratioOfSelectedFeatures1,popFitness1,'o');
% legend({'SparseGA' '��ͳ�Ŵ��㷨'});
% xlabel('����ѡ���');
% ylabel('��Ӧ��');
% % ��ͼ
% boxplot([popFitness popFitness1], {'SparseGA' '��ͳ�Ŵ��㷨'});
% ylabel('��Ӧ��');

%% ����
for i = 1 : maxGeneration
    
    pop1 = selectionOperation(population, popFitness);                     % ѡ�����
    pop2 = selectionOperation(population, popFitness);
    P = [pop1; pop2];                                                      % ��ģΪ2N����Ⱥ
    newPopulation = variation(P, featureScore);                            % �����������������Ӵ���Ⱥ
    
    % �����Ӵ���Ⱥ������Ӧ��
	[newPopFitness,~,~,historyIndividualRecord] = GetFitness(newPopulation, BaseData, trainingSetAndTestSet, 1, historyIndividualRecord);
    [population, popFitness] = eliteStrategy(newPopulation, newPopFitness, population, popFitness);         %��Ӣ����
    
    bestFitness = max(popFitness);                                         % ��ȡ��Ⱥ�������Ӧ��
    avgFitness = mean(popFitness);                                         % ������Ⱥƽ����Ӧ��
    index = find(popFitness == bestFitness);                               % ��ȡ�����Ӧ�ȸ����±�
    bestIndividual = population(index(1),:);                               % ��ȡ���Ÿ���
    
    bestFitnessSet(i) = bestFitness;                                       % д��ÿ�������Ӧ�ȼ���
    avgFitnessSet(i) = avgFitness;                                         % д��ÿ��ƽ����Ӧ�ȼ���
    bestIndividualSet(i,:) = bestIndividual;                               % д��ÿ�����Ÿ��弯��
    save('bestFitness.mat', 'bestFitness');                                % ��������
    save('avgFitness.mat', 'avgFitness');
    save('bestIndividual.mat', 'bestIndividual');
    
    fprintf("��%3d�������Ӧ��Ϊ%.4f\n",i,bestFitness);
    
    % ÿ��5������ͼ
    if mod(i,5) == 0
        plotEvolutionCurve(i, bestFitnessSet, avgFitnessSet);
    end   
end


%% 

[bestIndividualFitness1,bestIndividualFitness0,~,historyIndividualRecord] = GetFitness(bestIndividualSet, BaseData, trainingSetAndTestSet, 1, historyIndividualRecord);
plot([1:100],bestIndividualFitness1(1:100,:));
plot([1:100],bestIndividualFitness0(1:100,:));






















