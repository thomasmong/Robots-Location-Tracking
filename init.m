%% Initialisation terrain

terrain.longueur = 1500;
terrain.largeur = 1500;

%% Initialisation mobiles

mob.N = 5;

mob.r = 25;

%tirage random des positions initiales
mob.x = rand(2*mob.N,1);
mob.x(1:mob.N) = mob.x(1:mob.N)*terrain.longueur;
mob.x(mob.N+1:end) = mob.x(mob.N+1:end)*terrain.largeur;

%tirage random des positions cibles
mob.xc = rand(2*mob.N,1);
mob.xc(1:mob.N) = mob.xc(1:mob.N)*terrain.longueur;
mob.xc(mob.N+1:end) = mob.xc(mob.N+1:end)*terrain.largeur;