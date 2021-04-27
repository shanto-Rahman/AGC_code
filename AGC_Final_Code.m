close all;% lear ax; 
clear all; 
I=imread('E:\Image processing\Org.TIF');
figure(1);hold on; imshow(I);title('Main');  
aa=size(I);
aaa=size(aa);
if aaa(2)>2
hsi=rgb2hsv(I);
V=hsi(:,:,3);
else 
    V=I;
end 
V=im2double(V);
m1=mean2(V); 
%m1d= median(median(double(V)));
s1=std2(V);    
figure(2);hold on; imhist(V);title('Main');   
Range=1-0;

Larea= m1-(2*s1);
Uarea=(m1+(2*s1)); 
imRange=abs(Larea-Uarea);
imRange=str2num(sprintf('%0.1f',imRange));
 if(imRange<(Range/3)) 
      powerValue=(-(log2(s1)));
      k= (V.^(powerValue)+(1-V.^powerValue).*(m1).^(powerValue));
      k=1+heaviside(0.5-m1)*(k-1);
 else
%           powerValue = exp(1-(m1+2*s1));
        powerValue = exp((1-(m1+s1))/2);
        k= V.^(powerValue)+(1-V.^powerValue).*(m1).^(powerValue);
        k=1+heaviside(0.5-m1)*(k-1);
 end 
    Iout=(V.^(powerValue))./(k);
 figure(10);hold on; imshow(Iout);title('Now');
if aaa(2)>2
    hsi(:,:,3) = Iout;
    I4=hsv2rgb(hsi);
else
    I4=Iout;
end
figure(10);hold on; imshow(I4);title('Now');
stdS=std2(I4);   
disp(sprintf('Original rms= +%5.2f dB',stdS));
     
 E = entropy(I4);
 disp(sprintf('My Discrete Entropy = +%5.2f dB',E));
 
