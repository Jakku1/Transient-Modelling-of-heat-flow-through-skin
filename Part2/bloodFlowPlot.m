
% c005 = transientSolverFull(0.05);
% c01 = transientSolverFull(0.1);
% c05 = transientSolverFull(0.5);
c1 = transientSolverFull(1);
c5 = transientSolverFull(5);
c10 = transientSolverFull(10);
c25 = transientSolverFull(25);
c50 = transientSolverFull(50);
c2 = transientSolverFull(2);
%x = linspace(0,0.01,61);
x = linspace(0,1,18);
%plot(x,c005,'r');
hold on
% plot(x,c01,'r');
% plot(x,c05,'r');
plot(x,c1,'r');
plot(x,c2,'r');
plot(x,c5,'r');
plot(x,c10,'r');
plot(x,c25,'r');
plot(x,c50,'r');
% hold off
%'t = 0.05','t = 0.1','t = 0.5',
%legend('t = 1','t = 2','t = 5','t = 10', 't = 25', 't = 50')
title('Transient Solution for heat flow at different time values with blood flow')
xlabel('Node Position')
ylabel('Nodal Value')