% figure;
% c005 = transientSolver2(0.05);
% c01 = transientSolver2(0.1);
% c03 = transientSolver2(0.3);
% c1 = transientSolver2(1);
% x = [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
% plot(x,c005,'k');
% hold on
% plot(x,c01,'red');
% plot(x,c03,'blue');
% plot(x,c1,'green');
% hold off
% 
% legend('t = 0.05','t = 0.1','t = 0.3','t = 1')
% title('Transient Solution At different time values')
% xlabel('Node Position')
% ylabel('Nodal Value')

figure;
c005 = transientSolverPart2(0.05);
c01 = transientSolverPart2(0.1);
c05 = transientSolverPart2(0.5);
c1 = transientSolverPart2(1);
c5 = transientSolverPart2(5);
c10 = transientSolverPart2(10);
c25 = transientSolverPart2(25);
c50 = transientSolverPart2(50);
x = linspace(0,0.01,61);
plot(x,c005,'k');
hold on
plot(x,c01,'red');
plot(x,c05,'blue');
plot(x,c1,'green');
plot(x,c5,'c');
plot(x,c10,'m');
plot(x,c25,'y');
plot(x,c50,'#FFA500');
hold off

legend('t = 0.05','t = 0.1','t = 0.5','t = 1','t = 5','t = 10', 't = 25', 't = 50')
title('Transient Solution for heat flow through skin at different time values')
xlabel('Node Position')
ylabel('Nodal Value')