filename= 'COPQuad4.dat'
filename2 = 'COPQuad4COP.xlsx'
FP = csvread(filename,6000,0);

Fx1 = FP(:,15);
Fx2 = FP(:,16);
Fy1 = FP(:,17);
Fy2 = FP(:,18);
Fz1 = FP(:,19);
Fz2 = FP(:,20);
Fz3 = FP(:,21);
Fz4 = FP(:,22);

Fx = Fx1 + Fx2;
Fy = Fy1 + Fy2;
Fz = Fz1 + Fz2 + Fz3 + Fz4;

alpha = 120;
beta = 200;
az = -48;

Mx = beta * (Fz1 + Fz2 - Fz3 - Fz4);
My = alpha * (-Fz1 + Fz2 + Fz3 - Fz4);

axm = ((Fx*az)-My)./(Fz+eps);
aym = ((Fy*az)+Mx)./(Fz+eps);

dax = ((1.604*10^-14)*aym.^4+(-8.39091*10^-10)*aym.^2+(-1.44293*10^-6)).*(axm.^3)+((-2.85927*10^-10)*aym.^4+(2.05575*10^-5)*aym.^2- 0.113525).*axm;
%paym2 = (-8.39091*10^-10)*aym.^2;
%paym4 = (-2.85927*10^-10)*aym.^4;
%paym5 = (2.05575*10^-5)*aym.^2;
%dax01 = paym1 + paym2 + (-1.44293*10^-6);
%dax1 = (axm.^3)*(dax01');
%dax02 = paym4 + paym5 - 0.113525; 
%dax2 = axm*(dax02');
%dax = dax1 + dax2;                                                                                                                                                                                                                                                                                                                                  
axc = axm-dax;

day = ((1.27251*10^-14)*axm.^4+(-3.13238*10^-10)*axm.^2+(-3.33888*10^-6)).*(aym.^3)+((-6.49641*10^-10)*axm.^4+(1.53937*10^-5)*axm.^2+(1.12624*10^-1)).*aym;
%paxm2 = (-3.13238*10^-10)*axm.^2;
%paxm4 = (-6.49641*10^-10)*axm.^4;
%paxm5 = (1.53937*10^-5)*axm.^2;
%day01 = (paxm1 + paxm2 + (-3.33888*10^-6));
%day1 = aym.^3*(day01');
%day02 = (paxm4 + paxm5 + (1.12624*10^-1));
%day2 = aym*(day02');
%day = day1 + day2;
ayc= aym-day;

COP = [axc ayc Fx Fy Fz];

xlswrite(filename2,COP);
%fid=fopen('COPQuad1COP.txt','w+')
%fprintf(fid, '%d/n', COP);


