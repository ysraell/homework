function [U,L] = subspace_proj_MSD(training_samples,trajectories,N,l,c,mode,zeta)


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% n-mode

        % mean tensor class and the mean tensor general
        Yc = zeros(l,c,N);
        Ym = zeros(l,c);
        for Ni=1:N
            for gmi = training_samples{Ni}
                Yc(:,:,Ni) = Yc(:,:,Ni)+double(tenmat(trajectories{Ni}{gmi},mode));
            end
            Yc(:,:,Ni) = max(size(training_samples{Ni})).\Yc(:,:,Ni);
            Ym(:,:) = Ym(:,:)+Yc(:,:,Ni);
        end
        Ym(:,:) = N.\Ym(:,:);

        % bettween scatter 
        Sb = zeros(l,l);
        for Ni=1:N
            A = Yc(:,:,Ni)-Ym(:,:);
            Sb = Sb+max(size(training_samples{Ni})).*A*A';
        end

        % Wthin scatter
        Sw = zeros(l,l);
        for Ni=1:N
            for gmi = training_samples{Ni}
                A = double(tenmat(trajectories{Ni}{gmi},mode))-Yc(:,:,Ni);
                Sw = Sw+A*A';
            end
        end
        clear A

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
        

        [U,L] = eig(zb.*Sb - zw.*Sw);
        
end