function id = getIndividualId(individual)
% Ϊÿ���������Ψһid
% ��������"1011"��idΪ13
    N = size(individual, 2);
    id = 0;
    for  i = 1 : N
        id = id + individual(i) * 2^(i-1);
    end
end
