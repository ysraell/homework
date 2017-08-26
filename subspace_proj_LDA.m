function [V,L] = subspace_proj_LDA(training_samples,trajectories,msd,zeta)

       N = max(size(trajectories));
       [l,c] = size(trajectories{1}{1});
       
        Yc = zeros(l*c,N);
        Ym = zeros(l*c,1);
        for Ni=1:N
            for gmi = training_samples{Ni}
                Yc(:,Ni) = Yc(:,Ni)+reshape(trajectories{Ni}{gmi},l*c,1);
            end
            Yc(:,Ni) = max(size(training_samples{Ni})).\Yc(:,Ni);
            Ym = Ym+Yc(:,Ni);
        end
        Ym = N.\Ym;
       
        % bettween scatter 
        Sb = zeros(l*c);
        for Ni=1:N
            A = Yc(:,Ni)-Ym;
            Sb = Sb+max(size(training_samples{Ni})).*A*A';
        end

        % Wthin scatter
        Sw = zeros(l*c);
        for Ni=1:N
            for gmi = training_samples{Ni}
                A = reshape(trajectories{Ni}{gmi},l*c,1)-Yc(:,Ni);
                Sw = Sw+A*A';
            end
        end
        clear A
     
        if msd == 1
            switch zeta
                case 1
                    zb = max(eig(Sw));
                    zw = 1;
                case 2
                    Sw = Sw./frob(Sw);
                    Sb = Sb./frob(Sb);
                    zw = 1;
                    zb = 10;
                case 3
                    Sw = Sw./frob(Sw);
                    Sb = Sb./frob(Sb);
                    zw = 1;
                    zb = 100;
                case 4
                    Sw = Sw./frob(Sw);
                    Sb = Sb./frob(Sb);
                    zw = 1;
                    zb = 1000;
                case 5
                    zw = 1;
                    zb = 10;
                case 6
                    zw = 1;
                    zb = 100;
                otherwise
                    zw = 1;
                    zb = 1000;
            end
            [V,L] = eig(zb.*Sb - zw.*Sw);
        else
            switch zeta
                case 1
                    Sw = Sw+eye(l*c);
                    z=1;
                case 2
                    Sw = Sw./frob(Sw);
                    Sb = Sb./frob(Sb);
                    z=1;
                case 3
                    Sw = Sw./frob(Sw)+eye(l*c);
                    Sb = Sb./frob(Sb);
                    z=1;
                case 4
                    Sw = Sw./frob(Sw);
                    Sb = Sb./frob(Sb);
                    z=10;
                case 5
                    Sw = Sw./frob(Sw)+eye(l*c);
                    Sb = Sb./frob(Sb);
                    z=10;
                case 6
                    Sw = Sw./frob(Sw)+eye(l*c);
                    Sb = Sb./frob(Sb);
                    z=100;
                otherwise
                    z=1;
            end
            Temp = z.*Sb/Sw;
            Temp(~isfinite(Temp)) = 0;
            [V,L] = eig(Temp);
        end
        
end