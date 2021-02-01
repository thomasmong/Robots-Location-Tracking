function grad = calc_grad(mob,algo)
%CALC_GRAD Calcul du gradient
grad = zeros(2*mob.N,1);
x = mob.x(1:mob.N);
y = mob.x(mob.N+1:end);

for i = 1:mob.N
    x_i = [mob.x(i);mob.x(mob.N+i)];
    xc_i = [mob.xc(i);mob.xc(mob.N+i)];
    
    %matrice D
    A = zeros(2,mob.N);
    for k = 1:mob.N
        A(:,k) = x_i;
    end
    B = zeros(2,mob.N);
    B(1,:) = x;
    B(2,:) = y;
    
    D = A-B;
    
    der = (x_i-xc_i)/norm((x_i-xc_i))-4*algo.K*algo.alpha*D*(algo.L(:,i).^(-algo.alpha-1));
    grad(i) = der(1);
    grad(mob.N+i) = der(2);
end
end

