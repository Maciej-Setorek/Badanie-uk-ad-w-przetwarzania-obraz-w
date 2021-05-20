P=imread('lazy.jpg'); %wczytanie obrazu wejściowego
     f = [1 6 14 14 0 -14 -14 -6 -1; %tworzenie macierzy filtra Sobela
          8 48 112 112 0 -112 -112 -48 -8;
          28 168 392 392 0 -392 -392 -168 -28;
          56 336 784 784 0 -784 -784 -336 -56;
          70 420 980 980 0 -980 -980 -420 -70;
          56 336 784 784 0 -784 -784 -336 -56;
          28 168 392 392 0 -392 -392 -168 -28;
          8 48 112 112 0 -112 -112 -48 -8;
          1 6 14 14 0 -14 -14 -6 -1];

xp=size(P,1); %wielkości xp,yp obr_wej
yp=size(P,2);
N=sum(sum(f)); %określenie sumy elementów filtra
h=zeros(xp,yp,3) %wypełnienie tablicy wynikowej
P=double(P); %zapis obrazu do zmiennej typu double
offset = (size(f,1)-1)/2; %ogranicznik wielkości 
for ch=1:3
 for n=(1+offset):(xp-offset) %przejscie po x
 for k=(1+offset):(yp-offset) %przejscie po y
 for m=(-offset):1:offset %przejscie zależne od wymiarów filtra
 for l=(-offset):1:offset
 h(n,k,ch)=h(n,k,ch)+P(n-m,k-1,ch)*f(m+offset+1,l+offset+1); %splot funkcji
 end
 end
 end
 end
end
%warunki zapobiegające prześwietleniu obrazu
if N>0;
 h=h/N;
else
 h=h;
end
%Wyświetlenie obrazu wyjściowego i jego histogramu
subplot(1,2,1)
imshow(uint8(h));
title('Obraz po filtracji')
subplot(1,2,2)
histogram(h,[1:1:255])
title('Histogram obrazu po filtracji')
xlabel('Kontrast')
ylabel('Liczba pikseli')
disp(N)
%Wskaźnik jakości
c=size(P,3); %liczba kanału
j=0; %wskaźnik jakości
h=double(h);
for ch=1:c
 for x=1:xp
 for y=1:yp
 j=j+P(x,y,c)-h(x,y,c) ;%pętla obliczająca sumę różnic między wartościami współrzędnych x,y,ch obrazu wejściowego i obrazu po filtracji
 end
 end
end
j=j/c/xp/yp %podzielenie wartości przez zajmowaną powierzchnię obrazu
