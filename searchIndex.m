function index = searchIndex(y,X)
% ��һά����X���ҵ�y��λ��
    N = size(X);
    index = -1;
    for i = 1 : N
       if  y == X(i)
           index = i;
           break;
       end
    end
end

