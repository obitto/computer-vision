length = 600;
wholeframe = video(:,:,:,1:length);
output = zeros(m,n,3,length);
r= 0;
for t = 200:200
    display(t);
    testframe = wholeframe(:,:,:,t);
    figure,imshow(testframe);
    result = zeros(m,n,3);
    figure,imshow(result);
    B = background(weight,covariance);
    for i = 1:m
        for j = 1:n
            sign = 0;
            for k = 1:K
                %display(sqrt(euclid(testframe(i,j,:),center(i,j,k,:),covariance(i,j,k)*eye(3))));
                if sqrt(euclid(testframe(i,j,:),center(i,j,k,:),covariance(i,j,k)*eye(3))) < L * sqrt(covariance(i,j,k))
                %x = reshape(testframe(i,j,:),[],3);
                %c = reshape(center(i,j,k,:),[],3);
                %display(size(x));
                %if sqrt((x-c)/(covariance(i,j,k)*eye(3))*(x-c)') < L * sqrt(covariance(i,j,k));
                    sign = k;
                %label as foreground here
                    if find(ind(i,j,:) == sign) > B(i,j)
                        result(i,j,:) = [1 1 1];
                    end
                    
                    break;
                end
            end
            if sign == 0
                result(i,j,:) = [1 1 1];
            end
            %display(sign);
            if sign
                if find(ind(i,j,:) == sign) <= B(i,j)
                    framedata = reshape(testframe(i,j,:),[],3);
                    mu = reshape(center(i,j,sign,:),[],3);
                    r = a * mvnpdf(framedata,mu,covariance(i,j,sign)*eye(3));
                    %display(r);
                    %display(testframe(i,j,:));
                    %display(reshape(testframe(i,j,:),[1,1,1,3]));
                    %display(center(i,j,sign,:));
                    %display(sign);
                    center(i,j,sign,:) = (1-a) * center(i,j,sign,:)+ a * reshape(testframe(i,j,:),[1,1,1,3]);
                    mu = reshape(center(i,j,sign,:),[],3);
                    covariance(i,j,sign) = (1-a) * covariance(i,j,sign) + a * sum((framedata - mu) .^2);
                    weight(i,j,sign) = (1-a)*weight(i,j,sign)+a; 
                    for p = 1:K
                        if p ~= sign
                            weight(i,j,p) = (1-a)*weight(i,j,p); 
                        end
                    end
                end
            end
            
        end
    end
   output(:,:,:,t) = result; 
end
figure,imshow(result);