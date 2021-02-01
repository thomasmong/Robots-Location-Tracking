function test = cond_arret(mob,algo)
%COND_ARRET condition d'arrêt de la descente

%initialisation de la liste des normes
NORMES = zeros(mob.N,1);
for k = 1:mob.N
    %ajout de la norme
    NORMES(k) = sqrt((mob.x(k)-mob.xc(k))^2+(mob.x(mob.N+k)-mob.xc(mob.N+k))^2);
end
M = max(NORMES);
test = M > 5*algo.eps;
end