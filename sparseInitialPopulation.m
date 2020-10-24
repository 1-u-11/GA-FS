function [population] = sparseInitialPopulation(populationSize, numOfDecVariables, featureScore)
% SparseGA����ʼ����Ⱥ��
% ����populationSize�����壬ÿ��������numOfDecVariables��0/1��ɣ�ÿ��Ϊһ������
    population = zeros(populationSize, numOfDecVariables);
    
    for i = 1 : populationSize
        for j = 1 : numOfDecVariables * rand
            [m, n] = getTwoRandValue(numOfDecVariables);                   % ���ѡȡ��������ͬ������
            if featureScore(m) < featureScore(n)
                population(i, m) = 1;
            else
                population(i, n) = 1;
            end
        end
    end

% 	total = sum(population') / numOfDecVariables;
% 	avgTotal = sum(total) / size(total,2);
% 	% ���߱���Ϊ1����ѧ����Ϊ0.33
end

