function [U,num_max] = redux_dim(V,L,Dim,r)        

    l= max(size(V));
    [L,I] = sort(diag((L)),'descend');
    format long
    %         disp([det(Sb) det(Sw)])
    format short
    V = V(:,I);
    I_min = find(L<inf, 1 );
    %         disp(I_min)
    L = L(I_min:end);
    V = V(:,I_min:end);
    I_max = find(L>-Inf, 1, 'last' );
    L = L(1:I_max);
    V = V(:,1:I_max); 
    %         disp(L)
    if r==0
        ls = max([round(Dim*l) 2]);
        U = V(:,1:ls);
        num_max = [-1 -1];
    else
        num_max = max([find(cumsum(L)/sum(L)<=Dim, 1, 'last' ) 2]).*[1 1/l];
        U = V(:,1:num_max(1));
    end
        
end