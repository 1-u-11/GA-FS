function [fitness1, fitness0, CTable, historyRecord] = GetFitness(population, BaseData, trainingSetAndTestSet, minleaf, historyRecord)
% ��Ⱥ��Ӧ�ȼ���
% ���룺��Ⱥ���������ݡ�ѵ�����Ͳ��Լ��Ļ��֡���������СҶ��������ʷ�����
% ��������¼��ķ��ྫ�ȣ�������Ӧ�ȣ������¼��ķ��ྫ�ȡ��������󡢸��º����ʷ�����
    N = size(population, 1);                                               % ��Ⱥ��ģ
    fitness1 = zeros(N, 1);                                                % �����洢ÿ�����壬���¼��ķ��ྫ�ȣ�������Ӧ�ȣ�
    fitness0 = zeros(N, 1);                                                % �����洢ÿ�����壬���¼��ķ��ྫ��
    CTable = zeros(N,9);                                                   % �����洢ÿ�����壬����Ļ�������
    for  i = 1 : N
        individual = population(i,:);                                      % ȡ����i�Ÿ���
        id = getIndividualId(individual);                                  % �������id,��ͬ������Ψһid��֮��Ӧ
        index = searchIndex(id, historyRecord(:,1));                       % ���Ҹ����Ƿ������ʷ������У�����ֵ>0����ڣ����򲻴���
        
        if index == -1                                                     % ����ø��岻����ʷ������У���ͨ��������������������Ӧ��
            data = BaseData(:,[1,individual]==1);                          % ��ȡ���ݣ���������ת�ɶ�ά��������
            [accuracyRate_1, accuracyRate_0, CT] = GetAccuracyRate(data, trainingSetAndTestSet, minleaf);	% ͨ��������������࣬������Ӧ��
            fitness1(i) = accuracyRate_1;                                  % ���¼��ķ��ྫ�ȣ�������Ӧ�ȣ�
            fitness0(i) = accuracyRate_0;                                  % ���¼��ķ��ྫ��
            CTable(i,:) = CT;                                              % ��������
            
            numOfhistoryRecord = size(historyRecord,1);                    % ��ʷ���и�����Ŀ
            historyRecord(numOfhistoryRecord + 1, 1) = id;                % �����¼�¼
            historyRecord(numOfhistoryRecord + 1, 2) = accuracyRate_1;
            historyRecord(numOfhistoryRecord + 1, 3) = accuracyRate_0;
            historyRecord(numOfhistoryRecord + 1, 4:12) = CT;
        else                                                               % ����ø�������ʷ������У�ֱ��ȡ�����
            fitness1(i) = historyRecord(index, 2);
            fitness0(i) = historyRecord(index, 3);
            CTable(i,:) = historyRecord(index, 4:12);
        end
        fprintf('%d --->>%5.4f\n',i,fitness1(i)); 
    end
end