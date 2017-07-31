function [U,num_max] = subspace_proj_DMSD(training_samples,trajectories,N,l,c,mode,Dim,r,zeta)

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
    
        if (zeta==-1) 
            zeta = max(eig(Sb/Sw));
        end
        
        if (zeta==-2) 
            zeta = max(eig(Sb));
        end
        
        if (zeta==-3) 
            zeta = max(eig(Sw));
        end        
        

        [V,L] = eig(zeta.*Sb - Sw);
        [L,I] = sort(diag((L)),'descend');
        V = V(:,I);
        
        if r==0
            ls = max([round(Dim*l) 2]);
            U = V(:,1:ls);
            num_max = [-1 -1];
        else
            num_max = max([find(cumsum(L)/sum(L)<=Dim, 1, 'last' ) 2]).*[1 1/l];
            U = V(:,1:num_max(1));
        end
end