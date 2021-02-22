% Programa para o Calculo de Integrais N�mericos
clc;
disp ('+----------------------------------------------+')
disp ('|       C�lculo de Integrais N�mericos         |')
disp ('|                                              |')
disp ('|    1. A fun��o do problema � conhecida       |')
disp ('|    2. A fun��o do problema � desconhecida    |')
disp ('|                                              |')
disp ('+----------------------------------------------+')

escolha1 = input(' ');
switch escolha1;
    case 1
        disp('Introduza a fun��o entre ''(expoente(.^),multiplica��o(*):')
        fun = input(' ');
        f = inline (fun);
        disp('Introduza o limite inferior (a)')
        a = input(' ');
        disp('Introduza o limite superior (b)')
        b = input(' ');
        disp ('+----------------------------------------------+')
        disp ('|       Quantas casas d�cimaos pretende        |')
        disp ('|            utilizar para o teste?            |')
        disp ('|                                              |')
        disp ('|    1. 4 casas d�cimais                       |')
        disp ('|    2. 7 casas d�cimais                       |')
        disp ('|                                              |')
        disp ('+----------------------------------------------+')
        pause on
        escolha2 = input(' ');
        switch escolha2;
            case 1
                format short
            case 2
                format long
        end
        pause off
        disp ('+----------------------------------------------+')
        disp ('|       Escola a rega de aproxima��o           |')
        disp ('|                                              |')
        disp ('|    1. A regra do Trap�zio                    |')
        disp ('|    2. A regra de 3/8                         |')
        disp ('|    3. A regra de Simpson                     |')
        disp ('|                                              |')
        disp ('|                                              |')
        disp ('+----------------------------------------------+')
        
        escolha3 =input(' ');
        switch escolha3
            case 1
                escolha2;
                ht = (b-a);
                It= ht/2 * (f(a) + f(b));
                disp('   ');
                disp('Podemos encontrar majorantes para o erro de cada uma das aproxima��es obtidas'); 
                disp('Prima uma tecla para continuar');
                pause;
                
                disp('Para a aproxima��o It determinada pela regra do Trap�zio:');
                disp('     |e(It)|=|I - It| <= ((b-a)^3 /12)* M2, onde M2 = max |f''''(x)|, x in (0,1)');
                % Para determinar M =  max |f''''(x)| em [a, b] podemos usar a fun��o fminbnd(f,a,b) 
                % Como fminbnd calcula o m�nimo de f(x) em [a,b] para poder determinar 
                % o m�ximo devemos multiplicar por -1 o valor absoluto de df2
                
                syms x;
                df2= diff(f(x), 2)
                x_max = fminbnd(['-1 * abs(', char(df2), ')'], a, b); 
                M2 = abs(subs(df2, x_max));
                disp(['O valor maximo, M2 = ', num2str(M2, 8), ' de |f''''(x)| se atinge em x =', num2str(x_max, 8)]);
                
                % Gr�fico de f''(x)
                figure(1);
                clf;
                title(['Gr�fico de f''''(x)']);
                hold on;
                grid on;
                x=linspace(a,b);
                y=subs(df2,x);
                plot(x, y,'b', x_max,0, 'or');
                
                % Gr�fico de |f''(x)|
                figure(2);
                clf;
                title(['Gr�fico de |f''''(x)|']);
                hold on;
                grid on;
                x=linspace(a,b);
                plot(x,abs(y),'b', x_max, M2, 'or');
                
                % f�rmula do majorante
                M_eIt = (b-a)^3/12 * M2

                disp('      ');
                disp('Podemos confirmar os majorantes anteriores porque sabemos calcular');
                disp('o valor do integral da fun��o dada e o erro absoluto de cada aproxima��o');
                
                pause;
                
                syms x;
                I = double(int(f(x), a, b));
                disp(['O valor do integral...................... ....I = ', num2str(I, 15)]);
                disp(['O valor aproximado pela regra do trap�zio....It = ', num2str(It, 15)]);
                
                eIt= abs(I-It);
                disp('O erro absoluto de It:')
                disp(['|e(It)|= |I - Itc|= ', num2str(eIt, 15), '<= ', num2str(M_eIt, 15)]);
                
            case 2
                n = 3
                h3_8 = (b-a)/n
                x = a:h3_8:b
                y = f(x)
                I3_8= 3*h3_8/8 * sum([1 3 3 1].*y)
                % ou alternativamente 
                %I3_8 = 3*h3_8/8 * (y(1) + 3*y(2) + 3*y(3)+ y(4))
                
                % Para determinar M =  max |f''''(x)| em [a, b] podemos usar a fun��o fminbnd(f,a,b) 
                % Como fminbnd calcula o m�nimo de f(x) em [a,b] para poder determinar 
                % o m�ximo devemos multiplicar por -1 o valor absoluto de df2
                
                disp('   ');
                disp('Podemos encontrar majorantes para o erro de cada uma das aproxima��es obtidas');
                pause;
                
                syms x;
                df4= diff(f(x), 4)
                x_max = fminbnd(['-1 * abs(', char(df4), ')'], a, b); 
                M4 = abs(subs(df4, x_max));
                disp(['O valor maximo, M4 = ', num2str(M4, 8), ' de |f^{4}(x)| se atinge em x =', num2str(x_max, 8)]);
                
                % Gr�fico de f4(x)
                figure(3);
                clf;
                title(['Gr�fico de f^{4}(x)']);
                hold on;
                grid on;
                x=linspace(a,b);
                y=subs(df4,x);
                plot(x,y,'b', x_max, 0, 'or');
                
                % Gr�fico de |f4(x)|
                figure(4);
                clf;
                title(['Gr�fico de |f^{4}(x)|']);
                hold on;
                grid on;
                x=linspace(a,b);
                y= abs(y);
                plot(x,y,'b', x_max, M4, 'or');
                
                % f�rmula do majorante
                
                disp('Para a aproxima��o I3/8 determinada pela regra de 3/8:');
                disp('    |e(I3/8)|=|I - Is|= 3/80 h^5 * M4, M4= max |f^{4}(x)|, x in (0, 1)');
                M_eI3_8 = 3/80 * (h3_8)^5 * M4
                
                disp('      ');
                disp('Podemos confirmar os majorantes anteriores porque sabemos calcular');
                disp('o valor do integral da fun��o dada e o erro absoluto de cada aproxima��o');
                pause;
                
                syms x;
                I = double(int(f(x), a, b));
                disp(['O valor do integral...................... ....I = ', num2str(I, 15)]);
                disp(['O valor aproximado pelo regra de 3/8.......I3/8 = ', num2str(I3_8, 15)]);
                eI3_8= abs(I-I3_8);
                disp('O erro absoluto de I3/8:');
                disp(['|e(It3_8)|= |I - I3_8|= ', num2str(eI3_8, 15), ' <= ',num2str(M_eI3_8, 15)]);
               
            case 3
                n = 2
                hs = (b-a)/n
                x = a: hs: b
                y = f(x)
                Is= hs/3 * sum([1 4 1].*y)
                % ou alternativamente 
                %Is = hs/3 * (y(1) + 4*y(2) + y(3))
                
                disp('   ');
                disp('Podemos encontrar majorantes para o erro de cada uma das aproxima��es obtidas'); 
                pause;
         
                % f�rmula do majorante
                disp('Para a aproxima��o Is determinada pela regra de Simpson:');
                disp('    |e(Is)|=|I - Is| <= h^5 /90 * M4, M4= max |f^{4}(x)|, x in (0, 1)');
                
                syms x;
                df4= diff(f(x), 4)
                x_max = fminbnd(['-1 * abs(', char(df4), ')'], a, b); 
                M4 = abs(subs(df4, x_max));
                disp(['O valor maximo, M4 = ', num2str(M4, 8), ' de |f^{4}(x)| se atinge em x =', num2str(x_max, 8)]);
                
                % Gr�fico de f4(x)
                figure(3);
                clf;
                title(['Gr�fico de f^{4}(x)']);
                hold on;
                grid on;
                x=linspace(a,b);
                y=subs(df4,x);
                plot(x,y,'b', x_max, 0, 'or');
                
                % Gr�fico de |f4(x)|
                figure(4);
                clf;
                title(['Gr�fico de |f^{4}(x)|']);
                hold on;
                grid on;
                x=linspace(a,b);
                y= abs(y);
                plot(x,y,'b', x_max, M4, 'or');
                
                M_eIs = hs^5/90 * M4
                
                disp(' ');
                disp('Podemos confirmar os majorantes anteriores porque sabemos calcular');
                disp('o valor do integral da fun��o dada e o erro absoluto de cada aproxima��o');
                pause;
                
                syms x;
                I = double(int(f(x), a, b));
                
                disp(['O valor do integral...................... ....I = ', num2str(I, 15)]);
                disp(['O valor aproximado pelo regra de Simpson.....Is = ', num2str(Is, 15)]);
                
                eIs= abs(I-Is);
                disp('O erro absoluto de Is:');
                disp(['|e(Is)|= |I - Is|= ', num2str(eIs, 15), '<= ',num2str(M_eIs, 15)]);
        end
    case 2
        disp('Introduza os pontos de x: ')
        x = input(' ');
        disp('Introduza os pontos de y=f(x): ')
        y = input(' ');
        reply = input('Pretenda utilizar a regra de Simspon Composta? S/N [S] :', 's'); % introdu��o dos dados de itera��o
        if isempty(reply)
            reply = 'S';
            disp('Introduza limite inferior para qual pretende utilizar a regra de Simpson composta:');
            limSCa = input(' ');
            disp('Introduza limite superior para qual pretende utilizar a regra de Simpson composta:');
            limACb = input (' ');
            hSC = (x(limSCb)-x(limSCa))/((limSCb-limSCa)-1) ;
            ISC = hSC * ( y(limSCa) + 4 * y(2) + 2 * y(3) +4 * y((limSCb-limSCa)-1) + y(limSCb)-1) /3
end


