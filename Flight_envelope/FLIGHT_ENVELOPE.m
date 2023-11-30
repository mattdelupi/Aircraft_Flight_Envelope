clear; close all; clc;

%% KNOWN DATA %%
VD  =   160;    %   Dive speed in KCAS
VC  =   126;    %   Cruising speed in KCAS
VA  =   102;    %   Maneuvering speed in KCAS
np  =   3.8;    %   Maximum positive load factor
nn  =   -1.52;  %   Maximum negative load factor
S   =   174;    %   Wing area in square feet
W   =   2550;   %   Weight in lbs
G   =   [20 15.25 7.5]; %   Gust speeds in m/s
h   =   80;             %   Height in FL
CLa =   .077;           %   CL alpha in 1/deg
cr  =   5+4/12;         %   Wing root chord in feet
tap =   .695;           %   Wing taper ratio

%% PLOT %%
[Vm, nm] = maneuvering(VA, VC, VD, np, nn, S, W);
hold on
[Vg, ng] = gust(VA, VC, VD, G, h, CLa, S, W, cr, tap);
title('Flight Envelope')
axis([0 1.15*max([Vm Vg]) 1.15*min([nm ng]) 1.15*max([nm ng])])
xlabel('Equivalent Air Speed (m/s)')
ylabel('Load factor')
grid on
Vt = 0:5:1.15*max([Vm Vg]);
nt = floor(1.15*min([nm ng])):.5:ceil(1.15*max([nm ng]));
xticks(Vt)
yticks(nt)
legend('Maneuvering Envelope', 'Gust Envelope')