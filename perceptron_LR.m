%limpiamos la linea de comando y cerramos cualquier ventana generada
%anteriormente
clc;clear all;close all; 

fprintf('FORMATO: .txt\n');
fprintf('\t\t vector target, separado por tabulaciones\n');
dimension=input('\nIngresa la dimension de w\n');
archivo=input('\nIngresa el nombre del archivo entre comillas simples\n');

%colocamos en a los datos
a=load(archivo);

for i=1:dimension
    %asignamos la iésima columna de a, a x
    X(:,i)=a(:,i);
end 

%obtenemos las dimensiones de X
[n m]=size(X);
%añadimos una columna de unos
X=[X ones(n,1)];
%asignamos el target a D
D=a(:,dimension+1);
%l columnas de m+1 filas de zeros
w=zeros(m+1,1);
W=w';
b=0;

%calculamos los pesos
for j=1:40  %número de iteraciones
    for i=1:n   %número de datos de entrada
        %asignamos la fila i de X(entrada i), a x
        x=X(i,:)';
        %obtenemos el target correspondiente
        d=D(i);
        %
        n_n=W*x+b;
        % aplicamos la funcion hardlims
        a=hardlim(n_n);
        fprintf('\nTarget: %d \t a: %d   b: %d\n',d,a,b);
        %se aplica la regla de aprendizaje
        %w_new=w_old+error*(entrada_i)              
        e=(d-a);
        W=W+e*x';
        b=b+e;
        i
        j
        W
        b
        x
    end
end

if n == 2
    %graficamos los resultados
    %obtenemos las x de clase 1
    X1=X(D==1,:);
    %obtenemos las x de clase -1
    X2=X(D==0,:);
    %graficamos la clase 1 de rojo
    scatter(X1(:,1),X1(:,2),'r');
    hold on; grid on;
    %graficamos la clase 2 de azul
    scatter(X2(:,1),X2(:,2),'b');
    title('Perceptrón');
    xlabel('Eje x');
    ylabel('Eje y');
    legend('1-> Clase 1','0 -> Clase 2');
    %dibujamos la frontera de decision 
    p1=-(b/W(1));
    p2=-(b/W(2));
    P_x=[p1 0];
    P_y=[0 p2];
    plot(P_x,P_y);
end    