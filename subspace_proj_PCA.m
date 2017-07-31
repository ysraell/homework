function [V,L] = subspace_proj_PCA(training_samples,trajectories)

       N = max(size(trajectories));
       [l,c] = size(trajectories{1}{1});
       
        Ym = zeros(l*c,1);
        A = zeros(l*c,1);
        for Ni=1:N
            for gmi = training_samples{Ni}
                A = A+reshape(trajectories{Ni}{gmi},l*c,1);
            end
            B = max(size(training_samples{Ni})).\A;
            Ym = Ym+B;
        end
        clear A B
        Ym = N.\Ym;
        
        % Wthin scatter
        S = zeros(l*c);
        for Ni=1:N
            for gmi = training_samples{Ni}
                A = reshape(trajectories{Ni}{gmi},l*c,1)-Ym;
                S = S+A*A';
            end
        end
        clear A

        [V,L] = eig(S);
        
end