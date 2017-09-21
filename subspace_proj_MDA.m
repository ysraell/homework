function [U,L] = subspace_proj_MDA(training_samples,trajectories,N,l,c,mode,zeta)


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
                Sw = Sw+eye(l);
                z=1;
            case 2
                Sw = Sw./frob(Sw);
                Sb = Sb./frob(Sb);
                z=1;
            case 3
                Sw = Sw./frob(Sw)+eye(l);
                Sb = Sb./frob(Sb);
                z=1;
            case 4
                Sw = Sw./frob(Sw);
                Sb = Sb./frob(Sb);
                z=10;
            case 5
                Sw = Sw./frob(Sw)+eye(l);
                Sb = Sb./frob(Sb);
                z=10;
            case 6
                Sw = Sw./frob(Sw)+eye(l);
                Sb = Sb./frob(Sb);
                z=100;
            otherwise
                z=1;
        end
        
            Temp = z.*Sb/Sw;
            Temp(~isfinite(Temp)) = 0;
            [U,L] = eig(Temp);
        
end


% function [U,L] = subspace_proj_MDA(training_samples,trajectories,N,l,c,mode,adjust)
% 
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% n-mode
% 
%         % mean tensor class and the mean tensor general
%         Yc = zeros(l,c,N);
%         Ym = zeros(l,c);
%         for Ni=1:N
%             for gmi = training_samples{Ni}
%                 Yc(:,:,Ni) = Yc(:,:,Ni)+double(tenmat(trajectories{Ni}{gmi},mode));
%             end
%             Yc(:,:,Ni) = max(size(training_samples{Ni})).\Yc(:,:,Ni);
%             Ym(:,:) = Ym(:,:)+Yc(:,:,Ni);
%         end
%         Ym(:,:) = N.\Ym(:,:);
% 
%         % bettween scatter 
%         Sb = zeros(l,l);
%         for Ni=1:N
%             A = Yc(:,:,Ni)-Ym(:,:);
%             Sb = Sb+max(size(training_samples{Ni})).*A*A';
%         end
% 
%         % Wthin scatter
%         Sw = zeros(l,l);
%         for Ni=1:N
%             for gmi = training_samples{Ni}
%                 A = double(tenmat(trajectories{Ni}{gmi},mode))-Yc(:,:,Ni);
%                 Sw = Sw+A*A';
%             end
%         end
%         clear A
% 
%         if adjust
%             Sb = Sb./frob(Sb)+eye(l*c);
%             Sw = Sw./frob(Sw)+eye(l*c);
%         else
%             Sb = Sb./frob(Sb);
%             Sw = Sw./frob(Sw);
%         end
%         [U,L] = eig(Sb/Sw);
% %         [U,L] = eig(Sb*pinv(Sw));
%         
% end