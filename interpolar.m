function sinal=interpolar(S, nov_tam)
    % calcula fator
    fator=(size(S,2)-1)/nov_tam;
    % tamanho a ser adicionado nas estremidades para minimizar incerteza
    %tam_add=20;

    x= 1:size(S,2); 
    y = S; 
    xi = 1:fator:size(S,2); 
    sinal = interp1(x,y,xi,'linear'); 

    % hold all;
    % plot(S);
    % plot(sinal);

end