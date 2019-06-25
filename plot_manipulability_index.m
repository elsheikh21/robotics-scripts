% input data (link lengths)
l1=1;
l2=0.5;
l3=0.25;

% discretization of joint angles (in rads)
delta = 0.02;
q2 = [-pi:delta:pi];
q3=[-pi:delta:pi];

% evaluation of manipulability index H
for J = 1:length(q2), for K = 1:length(q3),
H(J,K)=sqrt((l1*(l2*sin(q2(J))+l3*sin(q2(J)+q3(K))))^2 ...
+(l3*(l1*sin(q2(J)+q3(K))+l2*sin(q3(K))))^2 ...
+(l2*l3*sin(q3(K)))^2 );
end; end;
% mesh plot

% note the reverse order of arguments!
[X,Y] = meshgrid(q2, q3); mesh(Y, X, H);
title('Manipulability index H of planar 3R robot');
xlabel('q2');
ylabel('q3');
zlabel('sqrt (det J*JT)');

% contour plot
contour(Y, X, H, 30); % with 30 level curves (note the reverse order of arguments!)
title('Manipulability index of planar 3R robot');
xlabel('q2');
ylabel('q3');

% find global maximum value of H and associated configuration (q2,q3)
maxH=0;indexJ=0; indexK=0;
for J = 1:length(q2),
[maxHJ, Kmax]=max(H(J,:)');
if maxHJ > maxH, maxH=maxHJ; indexJ=J; indexK=Kmax; end;
end;

% in radians
globalmaxH = maxH

q2maxH = q2(indexJ)
q3maxH = q3(indexK)