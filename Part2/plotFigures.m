figure;
c005 = transientSolver2(0.05);
c01 = transientSolver2(0.1);
c03 = transientSolver2(0.3);
c1 = transientSolver2(1);
x = [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
plot(x,c005,'k');
hold on
plot(x,c01,'red');
plot(x,c03,'blue');
plot(x,c1,'green');
hold off

legend('t = 0.05','t = 0.1','t = 0.3','t = 1')
title('Transient Solution At different time values')
xlabel('Node Position')
ylabel('Nodal Value')