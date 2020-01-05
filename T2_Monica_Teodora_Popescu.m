%Semnal triunghiular

P = 40;   %perioada semnalului
D = 20;   %durata semnalului este egala cu numarul de ordine 
N = 50;   %numarul de coeficienti
t = -P:0.2:P;  
%t este un vector ce contine valori de la -40 la 40 cu pasul 0.2(rezolutia)
%se vor afisa doua perioade
w0 = 2*pi*1/P;   %frecventa unghiulara
d = D/P;  %d este un numar cuprins intre 0 si P si reprezinta valoarea 
%la care se atinge maximul

x = 1+sawtooth(w0*t, d);    %x este semnalului initial
f0 = @(t)1/P*(1+sawtooth(w0*t, d));
%@(t) trebuie pus pentru a fi posibila integrarea lui f0
CC = integral(f0,0,P);   %componenta continua 
%integral(f0,0,P) inseamna integrala din f0 de la 0 la P
Ck = zeros(1,N); 
%Ck este o matrice cu o linie si N coloane, cu toate elementele egale cu 0
Ak = zeros(1,N);
%Ak este o matrice cu o linie si N coloane, cu toate elementele egale cu 0
y = 0;  %y este semnalul reconstruit

for k = 1:1:N   
    
    f1 = @(t)1/P*(1+sawtooth(w0*t, d)).*exp(-(1j)*(k-25)*w0*t);
    %am pus (k-25) pentru a afla componentele de la -25 la 25
    Ck(k) = integral(f1,0,P)  %coeficientii SFC
    Ak(k+1) = 2*abs(Ck(k));   %coeficientii SFA
    y = y + Ck(k)*exp((1j)*(k-25)*w0*t);   %formula semnalului SFC
   
end

figure(1)      %dorim ca reprezentarile grafice sa fie in ferestre separate 
%iar graficul ce urmeaza are numarul 1
Ak(26) = CC;   %componenta k=25 trebuie sa fie egala cu componenta 
%continua
a = -N/2:N/2;  %a este un vector ce ia valori de la -25 la 25, din 1 in 1
%reprezentarea discrecta a elementelor vectorului Ak in functie de vectorul
%a:
stem(a, Ak)  
grid   %se traseaza pe grafic o retea de linii, pentru a citi mai usor graficul
title('Reprezentarea spectrului de amplitudini');

%reprezentarea semnalului initial x in functie de t cu linie punctata si
%reprezentarea semnalului reconstruit y in functie de t cu linie continua 
%de culoare galbena reprezentate pe acelasi grafic
figure(2)
plot( t, y, 'y', t, x, '--')
grid 
title('Reprezentarea semnalului initial si semnalului reconstruit');


%In cazul de fata (D=20), spectrul de aplitudini are componentele pare 
%egale cu 0 deoarece d este 1/2 (adica acestea se anuleaza din 2 in 2). De
%asemenea, se observa ca componentele impare scad brusc.

%Semnalul reconstruit este aproape identic cu semnalul initial, fiind greu
%vizibila o eroare, deoarece numarul de componente(50) este destul de mare.
%Daca acest numar ar fi fost mai mic, eroarea s-ar fi observat mai usor.
%Deci, pentru reconstruirea unui semnal este mai bine sa folosim cat mai
%multi termeni, pentru ca semnalul reconstruit sa fie la fel cu cel initial.
