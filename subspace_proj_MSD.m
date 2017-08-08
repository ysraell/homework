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
                zb = max(eig(Sb/(Sw+eye(l))));
                zw=1;
            case 2
                zb = max(eig(Sb));
                zw=1;
            case 3
                zb = max(eig(Sw));
                zw=1;
            case 4
                zb = max(eig(Sw));
                zw=1;
                Sw = Sw./frob(Sw);
                Sb = Sw./frob(Sb);
            case 5
                zb = 10;
                zw = 1;
                Sw = Sw./frob(Sw);
                Sb = Sw./frob(Sb);
            case 6
                zb = 10;
                zw = 0;
                Sb = Sw./frob(Sb);
            otherwise
                zb = frob(Sw);
                zw = 1;
        end
        

        [U,L] = eig(zb.*Sb - zw.*Sw);
        
end