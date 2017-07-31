%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% to use with the oder parts, not to run alone.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



N = max(size(trajectories));
T_Methods = max(size(Methods));
T_bal = max(size(bal));
T_dist = max(size(dist_method_type));
MC = zeros(N,N,T_dist,T_Methods,T_rounds,T_bal);
R = zeros(T_dist,T_Methods,T_rounds,T_bal);
num_max = zeros(dim_opt_proj,2,T_Methods,T_rounds,T_bal);
E = zeros(T_max,T_Methods,T_rounds,T_bal);

for b=1:T_bal
    for r=1:T_rounds
        for m=1:T_Methods
            texto = ['Method ' Methods{m} ' (',num2str(m),'/',num2str(T_Methods),'), round:' num2str(r),'/',num2str(T_rounds),', bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
            disp(texto)
            [test_samples,training_samples] = gen_round_rand_balance(trajectories,bal(b));
            [R(:,m,r,b),MC(:,:,:,m,r,b),num_max(:,:,m,r,b),E(:,m,r,b)] = METHODS_actions(Methods{m},trajectories,test_samples,...
                training_samples,dist_method_type,dim_opt_proj,Dim,r,T_max,tolerancia,zeta);
        end
    end
end