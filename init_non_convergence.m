%% Initialisation terrain

terrain.longueur = 720;
terrain.largeur = 720;

mob.N = 3;

mob.r = 20;

mob.x = zeros(2*mob.N,1);
mob.xc = zeros(2*mob.N,1);

%robot 1
mob.x(1) = 360;
mob.x(4) = 360-100;
mob.xc(1) = 360;
mob.xc(4) = 360-40;


%robot 2
mob.x(2) = 360;
mob.x(5) = 360+100;
mob.xc(2) = 360;
mob.xc(5) = 360+40;


%robot 3
mob.x(3) = 150;
mob.x(6) = 360;
mob.xc(3) = 500;
mob.xc(6) = 360;