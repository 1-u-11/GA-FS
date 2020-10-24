function plotEvolutionCurve(i, bestFitnessSet, avgFitnessSet)
%PLOTEVOLUTIONCURVE �˴���ʾ�йش˺�����ժҪ
	X = (1:i);
    Y1 = bestFitnessSet(1:i);
    Y2 = avgFitnessSet(1:i);
    plot(X,Y1,X,Y2);
    legend({'��Ⱥ�����Ӧ��' '��Ⱥƽ����Ӧ��'});
    xlabel('��������');
    ylabel('��Ӧ��');
    pngName = [num2str(i) '.png'];
    if i < 10
        pngName = ['00' pngName];
    elseif i < 100
        pngName = ['0' pngName];
    end
    saveas(gcf,pngName)
end

