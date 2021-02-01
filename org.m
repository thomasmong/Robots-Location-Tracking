%% Initialisation
clearvars
init
%init_open
%init_non_convergence

%% Init algo
algo.T = 0.010; % période d'échantillonnage
algo.nbrCycles = 10000;
algo.v = 60; % vitesse des robots
algo.eps = algo.v*algo.T;
algo.lm2 = terrain.longueur^2+terrain.largeur^2;
algo.alpha = log(10^15*algo.lm2)/log((algo.lm2-4*mob.r^2)/algo.eps^2);
algo.K = 10e-9 *(algo.lm2 - 4*mob.r^2)^algo.alpha;

% Sauvegarde
mob.save.X = zeros(algo.nbrCycles,2*mob.N);
mob.save.X(1,:) = mob.x';

%% Algo
algo.compt = 1;
tic
while (algo.compt < algo.nbrCycles) && cond_arret(mob,algo)
    %matrice des longueurs l_ij
    algo.L = calc_L(mob,algo);
    
    %calcul du gradient
    grad = calc_grad(mob,algo);
    
    %calcul de la matrice Hessienne
    H = calc_H(mob,algo);
    %H = eye(2*mob.N);
    
    %direction de descente
    d = linsolve(H,-grad);
    
    %nouvelles positions
    for i = 1:mob.N
        d_i = [d(i),d(mob.N+i)];
        n = norm(d_i); %normalisation de la direction de descente
        mob.x(i) = mob.x(i)+algo.v*algo.T*d_i(1)/n;
        mob.x(mob.N+i) = mob.x(mob.N+i)+algo.eps*d_i(2)/n;
    end
    
    %ajout au tableau de sauvegarde
    mob.save.X(algo.compt+1,:) = mob.x';
    algo.compt = algo.compt + 1;
end

%affichage temps de calcul total
toc

%% Video

v = VideoWriter('organis_newton','MPEG-4');
v.FrameRate = 1/algo.T;
open(v);

fig = figure();

for k = 1:algo.compt
    for i = 1:mob.N
        plt = plot(mob.save.X(k,i),mob.save.X(k,mob.N+i),'o','MarkerSize',mob.r,'LineWidth',2);
        c = plt.Color;
        hold ON
        plot(mob.save.X(1:k,i),mob.save.X(1:k,mob.N+i),':','Color',c,'LineWidth',3);
        plot(mob.xc(i),mob.xc(mob.N+i),'+','MarkerSize',mob.r,'Color',c,'Linewidth',1);
        axis equal
    end
    hold OFF
    xlim([0 terrain.longueur]);ylim([0 terrain.largeur]);grid on;
    
    %video
    frame = getframe();
    writeVideo(v,frame);
    
%     %images
%     if mod(k,10) == 1
%         saveas(gcf,['VideoImages/' num2str(k) '.png']);
%     end
end

%sauvegarde de la configuration
save('config.mat','mob','terrain');

close(v);