function [x, y] = getTwoRandValue(Upper)
% ��1-Upper�����ѡȡ��������ͬ������
    R = randperm(Upper);
    x = R(1);
    y = R(2);
end

