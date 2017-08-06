

function [DIST] = DIST_method(A,B,dist_method_type)

    
    switch dist_method_type
        case 'n'
            [l,c,p] = size(A);
            if p>1
                DIST = norm(reshape(A-B,l,c*p),2);
            else
                DIST = norm(A-B,2);
            end
        case 'o'
            [l,c,p] = size(A);
            if p>1
                DIST = normcpp(reshape(A-B,l,c*p));
            else
                DIST = normcpp(A-B);
            end
        case 'f'
            DIST = frob(A-B);
        case 'g'
            DIST = frobcpp(A-B);
        case 's'
            DIST = (1-ssim(A,B))/2;
        case 'r'
            [l,c,p] = size(A);
            if p>1
                DIST = (1-ssimcpp(reshape(A,l,c*p),reshape(B,l,c*p)))/2;
            else
                DIST = (1-ssimcpp(A,B))/2;
            end
        case 'p'
            DIST = 1/psnr(A,B);            
        otherwise
            DIST = -1;
    end
            
            

end

%EOF