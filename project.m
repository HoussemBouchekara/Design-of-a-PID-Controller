clear all
clc
close all
% -------------------------------------------------------------------------
% Author: Houssem Bouchekara
% Date:   09/07/2020
% -------------------------------------------------------------------------
RES=[];
G=tf(4,[1 6 8 4]);
for K=2:0.1:10
    for a=0.1:0.1:4
        PID=tf([K 2*a*K K*a^2],[1 0]);       
        sys=feedback(series(PID,G),1);
        sysinfo=stepinfo(sys,'SettlingTimeThreshold',0.02);
        Ts=sysinfo.SettlingTime;
        M=sysinfo.Overshoot;
        if (M<15)&&(M>10)&&(Ts<3)
            RES=[RES; K a M Ts];
        end
    end    
end
% display all results
RES
% plot and display one result
Index=1; % Index of solution
K=RES(Index,1);
a=RES(Index,2);
PID=tf([K 2*a*K K*a^2],[1 0]);
sys=feedback(series(PID,G),1);
step(sys)
sysinfo=stepinfo(sys,'SettlingTimeThreshold',0.02)