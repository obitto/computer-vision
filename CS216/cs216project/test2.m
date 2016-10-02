B= zeros(m,n);
temp = weight;
ratio = weight ./ sqrt(covariance);
[~,ind] = sort(ratio,3,'descend');
for i = 1:m
    for j = 1:n
        tempB = 0;
        for k = 1:K
            tempB = tempB + weight(i,j,ind(i,j,k));
            if tempB >= T
                B(i,j) = k;
                break;
            end
        end
    end
end