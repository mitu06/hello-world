syms t;
P=40; %Perioada semnalului
N=50; %Numarul de coeficienti
D=10; %Durata semnalului 
t1=0:0.2:80; %Rezolutia temporala=200ms-0.2
w0=(2*pi)/P; %Pulsatia semnalului
x1=t/30; %Dreapta crescatoare
x2=1-(t-30)/10; %Dreapta descrescatoare
xi=0.5*sawtooth(t1*2*pi*1/P,0.75); %Semnalul triunghiular initial
X0=1/P*int(x1,t,0,P-D)+1/P*int(x2,t,P-D,P); %componenta continua a semnalului
disp('X0=');
disp(X0);
a=zeros(1,N);
frec=zeros(1,N);
y=0;
for k=1:N
    f1=x1*exp(-1j*w0*k*t);
    f2=x2*exp(-1j*w0*k*t);
    Xk=1/P*int(f1,t,0,P-D)+1/P*int(f2,t,P-D,P); %Calculul coeficientilor
    a(k)=sqrt((imag(Xk))^2+(real(Xk))^2); %Calculul amplitudinii
    frec(k)=k/P;
    S=['X',num2str(k),'='];
    disp(S);
    disp(Xk);
    y=y+2*(Xk*exp(1j*k*w0*t1)); %Reconstruirea semnalului initial
end
y1=y+X0; %Adun componenta continua la semnlului reconstruit initial;
figure(1)
stem(0,X0,'-b') %Reprezentarea amplitudinii componentei continue
hold on 
stem(frec,a,'-b') %Reprezentarea spectrului de ampl la frecv pozitive
hold on
stem(-frec,a,'-b')
title('Reprezentarea spectrului de amplitudini')
xlim([-N/P N/P])
figure(2)
plot(t1,xi+0.5,'-b') %Reprezentarea semnalului initial
hold on
plot(t1,y1,'--r') %Reprezentarea semnalului reconstruit
title('Reprezentarea semnalului intial si a celui reconstruit')
legend('Semnal initial','Semnal reconstruit')
axis([0 80 -2 4])