function [V,L] = subspace_proj_LDA(training_samples,trajectories,msd,zeta,adjust)

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
            if (zeta==-1) 
                zeta = max(eig(Sb/Sw));
            end
            if (zeta==-2) 
                zeta = max(eig(Sb));
            end
            if (zeta==-3) 
                zeta = max(eig(Sw));
            end  
            Sb = Sb./frob(Sb);
            Sw = Sw./frob(Sw);
            [V,L] = eig(zeta.*Sb - Sw);
        else
            
            if adjust
                Sb = Sb./frob(Sb)+eye(l*c);
                Sw = Sw./frob(Sw)+eye(l*c);
            else
                Sb = Sb./frob(Sb);
                Sw = Sw./frob(Sw);
            end
            [V,L] = eig(Sb/Sw);
        end
        
end