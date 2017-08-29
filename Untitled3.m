filename= 'COPQuad2.dat'
filename2 = 'COPQuad2COP.xlsx'
filename3 = 'COPQuad2COP.dat'
FP = csvread(filename,5,0);

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

dax = ((7.92063*10^-15)*aym.^4+(-5.821*10^-10)*aym.^2+(-2.77102*10^-6)).*(axm.^3)+((-1.76083*10^-10)*aym.^4+(1.29695*10^-5)*aym.^2- 0.0413979).*axm;
axc = axm-dax;

day = ((8.82869*10^-15)*axm.^4+(-2.48554*10^-10)*axm.^2+(-1.76282*10^-6)).*(aym.^3)+((-4.22186*10^-10)*axm.^4+(1.2091*10^-5)*axm.^2+(5.16279*10^-2)).*aym;
ayc= aym-day;

COP1 = [axc ayc];  %Matrix to transform
m = [0 -1; -1 0];
COP2 = COP1*m;     %Transformed matrix for xy axis consideration
axt = COP2(:,1);    %New x-COP transformed values
ayt = COP2(:,2);    %New y-COP transformed values

COP = [axt ayt Fx Fy Fz];

%xlswrite(filename2,COP);
%fid=fopen('COPQuad1COP.txt','w+')
%fprintf(fid, '%d/n', COP);
csvwrite(filename3, COP);

