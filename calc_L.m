function L = calc_L(mob,algo)
%CALC_L Matrice des longueurs l_ij
Px = zeros(mob.N);
Py = zeros(mob.N);

x = mob.x(1:mob.N);
y = mob.x(mob.N+1:end);
for i = 1:mob.N
    Px(i,:) = x;
    Py(i,:) = y;
end
L = (Px-Px').^2 + (Py-Py').^2 - 4*(mob.r+algo.eps)^2*(ones(mob.N));
end