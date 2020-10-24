function [trainingSetAndTestSet] = getTrainingSetAndTestSet(testNumber, BaseData)
% ���ֲ��Լ���ѵ��������ԭ��¼���˳��������ң�ǰ���ּ�¼��ѵ������ǰ���ּ�¼�����Լ�
    [N, ~] = size(BaseData);
    trainingSetAndTestSet = zeros(testNumber,N);
    for i = 1 : testNumber
        X = randperm(N);                                                   % ����
        trainingSetAndTestSet(i,:) = X;
    end
end


