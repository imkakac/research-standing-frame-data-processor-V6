%This program reads HELIOS forceplate(8 channels) text files, calculates the
%Center of Pressure (COP) and then saves the file to be ran in Data
%Processor under the forceplate channel(.dat).  

function COP = COPcal_V2 (FP)
%Load force plate data
Fx1 = FP(:,1); Fx2 = FP(:,2); Fy1 = FP(:,3); Fy2 = FP(:,4);
Fz1 = FP(:,5); Fz2 = FP(:,6); Fz3 = FP(:,7); Fz4 = FP(:,8);  
%calculating COP  
 Fx=Fx1+Fx2;
 Fy=Fy1+Fy2;
 Fz=Fz1+Fz2+Fz3+Fz4;
      
beta=200;		% position from sensor to center of FP in Y-direction
alpha=120;		% position from sensor to center of FP in X-direction
gamma=-54;		% position from sensor to center of FP in Z-direction

b_prod=beta*(Fz1+Fz2-Fz3-Fz4);
g_prod=-gamma*(Fy1+Fy2);
deno=(Fz1+Fz2+Fz3+Fz4);

y=(b_prod+g_prod)./deno;

a_prod=alpha*(Fz1-Fz2-Fz3+Fz4);
g_prod2=-gamma*(Fx1+Fx2);

x=(a_prod+g_prod2)./deno;


a_prod2=alpha*(Fy1-Fy2);
b_prod2=beta*(Fx1-Fx2);
x_prod=x.*(Fy1+Fy2);
y_prod=y.*(Fx1+Fx2);

Tz=a_prod2-b_prod2-x_prod+y_prod;
   s=length(y);
   t=zeros(s,1);
P=[x y t]';
F=[Fx Fy Fz]';
Rot=[t t Tz]';

M=(cross(P,F))+Rot;
% Mx=M(1)/1000;
% My=M(2)/1000;
% Mz=M(3)/1000;
%modified 06/23/2017
Mx=M(1);
My=M(2);
Mz=M(3);



Mx=Mx';
My=My';
Mz=Mz';

%added on 02/22/2017 replace Fz = 0 to 0.01
%Fz(find(~Fz)) = 0.01;
%added on 03/31/2017 replace Fz = 0 to 0.01
Fz(~Fz) = 0.01;
%
R_sq=((Fx.^2)+(Fy.^2)+(Fz.^2));
xcop=(((gamma*Fx.*R_sq)-(My.*(R_sq-Fy.^2))+(Mx.*Fx.*Fy)+(Mz.*Fy.*Fz))./(Fz.*R_sq));
ycop=(((gamma*Fy.*R_sq)+(Mx.*(R_sq-Fx.^2))-(My.*Fx.*Fy)-(Mz.*Fx.*Fz))./(Fz.*R_sq));
COP=[xcop ycop Fx Fy Fz];