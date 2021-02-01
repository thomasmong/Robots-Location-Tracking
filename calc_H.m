function H = calc_H(mob,algo)
%CALC_H Renvoie la matrice Hessienne
x = mob.x(1:mob.N);
y = mob.x(mob.N+1:end);

Dx = zeros(mob.N);
Dy = zeros(mob.N);

for k = 1:mob.N
    Dx(:,k) = x;
    Dy(:,k) = y;
end

%première matrice
Px = algo.L.^(-2-algo.alpha).*(Dx-Dx').^2;
qx = (algo.L.^(-1-algo.alpha)-2*(algo.alpha+1)*Px)*ones(mob.N,1);
Qx = diag(qx);

A1 = 2*eye(mob.N)-4*algo.K*algo.alpha*(Qx-(algo.L.^(-algo.alpha-1)...
    -2*(algo.alpha+1)*Px));

%troisième matrice
Py = algo.L.^(-2-algo.alpha).*(Dy-Dy').^2;
qy = (algo.L.^(-1-algo.alpha)-2*(algo.alpha+1)*Py)*ones(mob.N,1);
Qy = diag(qy);

A3 = 2*eye(mob.N)-4*algo.K*algo.alpha*(Qy-(algo.L.^(-algo.alpha-1)...
    -2*(algo.alpha+1)*Py));

%deuxième matrice
B = (Dx-Dx').*(Dy-Dy').*algo.L.^(-2-algo.alpha);
qxy = B*ones(mob.N);
Qxy = diag(qxy);

A2 = 8*algo.K*algo.alpha*(algo.alpha+1)*(Qxy-B);

%matrice Hessienne
H = zeros(2*mob.N);
H(1:mob.N,1:mob.N) = A1;
H(mob.N+1:end,1:mob.N) = A2;
H(1:mob.N,mob.N+1:end) = A2';
H(mob.N+1:end,mob.N+1:end) = A3;
end