function [CTable] = GetContingencyTable(data,trainingAndTest,minleaf)
%% 
    %% �������ѵ����/���Լ�
    trainNum = 3000;                                                        %ѵ����������
    Train = data(trainingAndTest(1:trainNum),:);                            %ѵ����
    Test = data(trainingAndTest(trainNum + 1:end),:);                       %���Լ�

    %% ѵ������
    P_train = Train(:,2:end);
    T_train = Train(:,1);

    %% ��������
    P_test = Test(:,2:end);
    T_test = Test(:,1);

    %% ����������������
    ctree = ClassificationTree.fit(P_train,T_train,'minleaf',minleaf);
    % view(ctree);
    % view(ctree,'mode','graph');

    %% �������
    T_sim = predict(ctree, P_test);
    
    %%
    hits =                  length(find(T_sim == 1 & table2array(T_test) == 1));
    misses =                length(find(T_sim == 0 & table2array(T_test) == 1));
    observed_yes =          hits + misses;
    false_alarms =          length(find(T_sim == 1 & table2array(T_test) == 0));
    correct_negatives =     length(find(T_sim == 0 & table2array(T_test) == 0));
    observed_no =           false_alarms + correct_negatives;
    
    forecast_yes =          hits + false_alarms;
    forecast_no =           misses + correct_negatives;
    total =                 forecast_yes + forecast_no;
    
    precision_0 = correct_negatives ./ observed_no * 100;
    precision_1 = hits ./ observed_yes * 100;
    
    CTable = [hits misses observed_yes false_alarms correct_negatives observed_no forecast_yes forecast_no total];
    
end

