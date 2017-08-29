%This program reads Research Standing Frame forceplate(8 channels) text files, calculates the
%Center of Pressure (COP) and then saves the file to be ran in Data
%Processor under the forceplate channel(.dat).  
%Ran Cheng 07/14/2017
function COP = COPcal_V2(FP)
%Load force plate data
Fx1 = FP(:,1); Fx2 = FP(:,2); Fy1 = FP(:,3); Fy2 = FP(:,4);
Fz1 = FP(:,5); Fz2 = FP(:,6); Fz3 = FP(:,7); Fz4 = FP(:,8);  
%calculating COP  
 Fx=Fx1+Fx2;
 Fy=Fy1+Fy2;
 Fz=Fz1+Fz2+Fz3+Fz4;
      
beta=200;		% position from sensor to center of FP in Y-direction
alpha=120;		% position from sensor to center of FP in X-direction
gamma=-48-2.3;		% position from sensor to center of FP in Z-direction

Mx = beta*(Fz1+Fz2-Fz3-Fz4);
My = alpha*(-Fz1+Fz2+Fz3-Fz4);
Mz = beta*(-Fx1+Fx2) + alpha*(Fy1-Fy2);
Mx1 = Mx+Fy*gamma;
My1 = My-Fx*gamma;
%added on 03/31/2017 replace Fz = 0 to 0.01
%Fz(~Fz) = 0.01;
%added on 07/13/2017 replace Fz <= 1 to 1
% Fz(Fz<1) = 1;
%measured x and y
xcop = -My1./(Fz+eps);
ycop = Mx1./(Fz+eps);

% COP=[xcop ycop Fx Fy Fz];

%% corrected x and y of cop
% dax = ((1.604*10^-14)*ycop.^4+(-8.39091*10^-10)*ycop.^2+(-1.44293*10^-6)).*(xcop.^3)...
%     +((-2.85927*10^-10)*ycop.^4+(2.05575*10^-5)*ycop.^2- 0.113525).*xcop;
% axc = xcop-dax;
% day = ((1.27251*10^-14)*xcop.^4+(-3.13238*10^-10)*xcop.^2+(-3.33888*10^-6)).*(ycop.^3)...
%     +((-6.49641*10^-10)*xcop.^4+(1.53937*10^-5)*xcop.^2+(1.12624*10^-1)).*ycop;
dax = (7.92063e-15*ycop.^4-5.821e-10*ycop.^2-2.77102e-6).*(xcop.^3)...
    +(-1.76083e-10*ycop.^4+1.29695e-5*ycop.^2- 0.0413979).*xcop;

day = (8.82869e-15*xcop.^4-2.48554e-10*xcop.^2-1.76282e-6).*(ycop.^3)...
    +(-4.22186e-10*xcop.^4+1.2091e-5*xcop.^2+5.16279e-2).*ycop;
%corrected x and y
axc = xcop-dax;
ayc= ycop-day;

%added on 07/13/2017 replace cop outlier with (300mm and -300mm)
axc(axc < -300) = -300; axc(axc > 300) = 300;
ayc(ayc < -300) = -300; ayc(ayc > 300) = 300;

COP=[axc ayc Fx Fy Fz];

%% transfer matrix
% m = [0 -1; -1 0];
% COP(:,1:2) =  COP(:,1:2)*m;

%% nicole's code
% Mx = beta * (Fz1 + Fz2 - Fz3 - Fz4);
% My = alpha * (-Fz1 + Fz2 + Fz3 - Fz4);
% 
% axm = ((Fx*az)-My)./(Fz+eps);
% aym = ((Fy*az)+Mx)./(Fz+eps);
% 
% dax = ((1.604*10^-14)*aym.^4+(-8.39091*10^-10)*aym.^2+(-1.44293*10^-6)).*(axm.^3)+((-2.85927*10^-10)*aym.^4+(2.05575*10^-5)*aym.^2- 0.113525).*axm;
% %paym2 = (-8.39091*10^-10)*aym.^2;
% %paym4 = (-2.85927*10^-10)*aym.^4;
% %paym5 = (2.05575*10^-5)*aym.^2;
% %dax01 = paym1 + paym2 + (-1.44293*10^-6);
% %dax1 = (axm.^3)*(dax01');
% %dax02 = paym4 + paym5 - 0.113525; 
% %dax2 = axm*(dax02');
% %dax = dax1 + dax2;                                                                                                                                                                                                                                                                                                                                  
% axc = axm-dax;
% 
% day = ((1.27251*10^-14)*axm.^4+(-3.13238*10^-10)*axm.^2+(-3.33888*10^-6)).*(aym.^3)+((-6.49641*10^-10)*axm.^4+(1.53937*10^-5)*axm.^2+(1.12624*10^-1)).*aym;
% ayc= aym-day;

