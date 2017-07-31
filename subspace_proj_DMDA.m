function [U,num_max] = subspace_proj_DMDA(training_samples,trajectories,N,l,c,mode,Dim,r,adjust)

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


        if adjust
            Sb = Sb./frob(Sb)+eye(l*c);
            Sw = Sw./frob(Sw)+eye(l*c);
        else
            Sb = Sb./frob(Sb);
            Sw = Sw./frob(Sw);
        end
        [L,V] = eig(Sb/Sw);
%         [L,V] = eig(Sb*pinv(Sw));
        [L,I] = sort(diag((L)),'descend');
        V = V(:,I);
        I_min = find(L<inf, 1 );
        L = L(I_min:end);
        V = V(:,I_min:end);
        I_max = find(L>-Inf, 1, 'last' );
        L = L(1:I_max);
        V = V(:,1:I_max); 
        if r==0
            ls = max([round(Dim*l) 2]);
            U = V(:,1:ls);
            num_max = [-1 -1];
        else
            num_max = max([find(cumsum(L)/sum(L)<=Dim, 1, 'last' ) 2]).*[1 1/l];
            U = V(:,1:num_max(1));
        end
end