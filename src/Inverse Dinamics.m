%% Dinamica inversa
%% Omar Baruch Moron Lopez
%% 09/11/2019
l=1;
m=1;
g=9.81;
I=(m*l^2)/(12) ; %los elsavones son iguales tienen, la misma inercia pero cual es??


T=10;
th1_0=0;
th1_T=pi;

th2_0=0;
th2_T=pi/2;

for i=1:51
    ti(i)=(i-1)*(T/50);
    
    %Trayectoria th1
    th1(i)=(th1_0)+(((th1_T-th1_0)/T)*(ti(i)-((T/2*pi)*sin((2*pi/T)*ti(i)))));
    thd1(i)=((th1_T-th1_0)/T)*(1-(cos((2*pi/T)*ti(i))));
    thdd1(i)=((th1_T-th1_0)/T)*(sin((2*pi/T)*ti(i))*((2*pi)/T));
    
    %Trayectoria th2
    th2(i)=(th2_0)+(((th2_T-th2_0)/T)*(ti(i)-((T/2*pi)*sin((2*pi/T)*ti(i)))));
    thd2(i)=((th2_T-th2_0)/T)*(1-(cos((2*pi/T)*ti(i))));
    thdd2(i)=((th2_T-th2_0)/T)*(sin((2*pi/T)*ti(i))*((2*pi)/T));
        
    %Valores para el torque.
    d_11=I+I+m*l^2+(m*(l^2+l^2+(2*l)*l*cos(th2(i))));
    d_12=I+(l^2+(l^2*cos(th2(i))));
    d_21=I+(m*((l^2)+(l*l*cos(th2(i)))));
    d_22=I+(m*(l^2));

    c_121=-m*l*l*sin(th2(i));
    c_211=-m*l*l*sin(th2(i));
    c_221=-m*l*l*sin(th2(i));
    c_112=m*l*l*sin(th2(i));

    g_1=m*l + m*l*g*cos(th1(i)) +  m*l*g*cos(th1(i)+ th2(i)) ;
    g_2=m*l*g*cos(th1(i)+ th2(i));

    
    %Torques
    tau1(i)= ((d_11)*(thdd1(i))   +   (d_12)*(thdd2(i))  +  c_121*thd1(i)*thd2(i)  +   c_211*thd2(i)*thd1(i)  +  c_221*thd2(i) + g_1); 
    tau2(i)= d_21*(thdd1(i)) + d_22*(thdd2(i)) + c_112*(thd1(i))^2 + g_2
    
    
end
figure;
plot(ti,th1,'-',ti,thd1,'.',ti,thdd1,'*');
title('Primer eslabon Posicion, velocidad, aceleracion');


figure;
plot(ti,th2,'-',ti,thd2,'.',ti,thdd2,'*');
title('Segundo eslabon Posicion, velocidad, aceleracion');


figure;
plot(ti,tau1);
title('Torques Primer eslabon');


figure;
plot(ti,tau2);
title('Torques Segundo eslabon');
   
