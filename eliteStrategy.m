function [P,F] = eliteStrategy(newpop,newfitvalue,pop, fitvalue)
% ��Ӣ���ԣ�����ģΪN����Ⱥ�ϲ���ɸѡ����ģΪN��Ӣ��Ⱥ
    N = size(pop,1);
    total_pop = [ newpop; pop];
    
    total_fitvalue = [ newfitvalue; fitvalue];
    
    
    X = total_fitvalue;
    X = sort(X);
    threshold = X(N);
    
    P = total_pop(total_fitvalue>=threshold,:);
    F = total_fitvalue(total_fitvalue>=threshold);
    P = P(1:N,:);
    F = F(1:N,:);

%     P = newpop;
%     F = newfitvalue;
    
    max = X(2*N);
    p = total_pop(total_fitvalue==max,:);
    P(1,:)=p(1,:);
    F(1) = max;

end