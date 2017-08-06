function res=normalizar(sinal)
    
    T = max(sinal(:))-min(sinal(:));

    if abs(T)>eps
        res=(sinal-min(sinal(:)))/T;
    else
        res=(sinal-min(sinal(:)));
    end
    
end