% a,b,c sao tres pontos [x,y,z] para o calculo do angulo
% entre os vetores ab e ac. O angulo eh da articulacao 'a'

%  Centido anti-horário 
% a -> articulação central
% b -> articulação inicial
% c -> articulação final


function graus=angulo(a,b,c)
    ab=a-b;
    ac=a-c;

%% 180

    resp=sum(ab.*ac)/(sqrt(sum(ab.*ab))*sqrt(sum(ac.*ac)));
    resp=acosd(resp);%/0.0175; % transforma para graus
    graus=round(resp);


%% 360

% a = atan2(ac(2), ac(1)) - atan2(ab(2), ab(1));
% graus=round(radtodeg(a));
% if (a < 0) 
%     a = a + 2*pi;
%     graus=round(radtodeg(a));
% end  

end
