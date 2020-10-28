{-|              
Module : Tarefa3_2017li1g10
Description : Módulo Haskell contendo a 3ª Tarefa da 1ª Fase do Projeto "Micro Machines" de Laboratórios de Informática 1
Copyright: João Manuel da Costa Ferraz Soares <a77841@alunos.uminho.pt>;
           Filipa Alves dos Santos <a83631@alunos.uminho.pt>
-}

module Tarefa3_2017li1g10 where

import LI11718

import Data.Maybe

type Linha = (Ponto, Ponto)


{-| A função 'testesT3' dá vários exemplos de 'cenários' possíveis.-}

testesT3 :: [(Tabuleiro,Tempo,Carro)] -- ^ lista de exemplos 
testesT3 = [([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], 1 , (Carro (2.3,1.3) 45 (0.1,0.1)))
           ,([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], 1 , (Carro (1.8,1.8) 23 (1,0.1)))   
           ,([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], 2 , (Carro (2.4,1.4) 20 (0.5,0)))      
           ,([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]],1.5, (Carro (1.2,1.3) 15 (1.3,0))) 
           ,([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]],0.7, (Carro (3.1,1.8) 22 (0,1))) 
           ,([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], 2 , (Carro (2.5,1.4) 40 (0,1))) 
           ,([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], 1 , (Carro (2.5,3.5) 40 (0,0)))    
           ,([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], 0 , (Carro (1.5,2.5) 25 (1,1)))       
           ]   


{-| A função 'movimenta' verifica se no caminho de um carro com uma certa velocidade passa por alguma peça inválida.

    == Exemplos de utilização

         >>> movimenta [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  1  (Carro (2.3,1.3) 45 (0.1,0.1))
         Just (Carro {posicao = (2.3999999999999977,1.4000000000000001), direcao = 45.0, velocidade = (0.1,0.1)})
-}

movimenta :: Tabuleiro   -- ^ tabuleiro escolhido
          -> Tempo       -- ^ tempo a decorrer
          -> Carro       -- ^ carro a qual vai ser aplicado o movimento
          -> Maybe Carro -- ^ novo estado do carro ou a sua possivel destruição

movimenta m t c = if (move t c m) == Nothing then Nothing
                                             else (move2 m (fromJust(move t c m)) c (divide c) 0 (t*(fromIntegral 10)))

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

{-| A função 'divide' recebe um Carro e divide a sua velocidade por 10.
    
    == Exemplos de utilização

         >>> divide (Carro (2.3,1.3) 45 (0.1,0.1))
         (0.01,0.01)
-}

divide :: Carro      -- ^ carro a qual vai ser aplicado o movimento
       -> Velocidade -- ^ velocidade do carro dividida por 10

divide (Carro p a (x,y)) =  (x/10, y/10)



{-| A função 'move2' faz pequenas incrementaçoes do caminho que um carro terá e calculo se o caminho no total é viável, ou se o carro é destruído.

     == Exemplos de utilização:

          >>>move2 [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] (2.3,1.3) (Carro (2.2,1.2) 45 (0.1,0.1)) (0.01,0.01) 0 10  
          Just (Carro {posicao = (2.299999999999998,1.3), direcao = 45.0, velocidade = (0.1,0.1)})
-}

move2 :: Tabuleiro   -- ^ tabuleiro escolhido
      -> Ponto       -- ^ posição final que o carro irá ocupar
      -> Carro       -- ^ carro a qual vai ser aplicado o movimento
      -> Velocidade  -- ^ a velocidade dividida em 10
      -> Double      -- ^ inicialmente 0, é incrementado até ultrapassar ou ser igual a p
      -> Double      -- ^ número pela qual a velocidade inicial do carro foi divida
      -> Maybe Carro -- ^ novo estado do carro ou a sua possivel destruição

move2 tab (a,b) (Carro (x,y) dir (v1,v2)) (z1,z2) r p | ((notLava (final1,final2) tab) == False) = Nothing
                                                      | ((notLava (f1, f2) tab ) == False ) = Nothing
                                                      | ((r < p)  && ((notLava (f1, f2) tab ) == True ) && (notLava (final1,final2) tab) == True) = move2 tab (a,b) (Carro ((x+z1),(y+z2)) dir (v1,v2)) (z1,z2) (r+1) p
                                                      | ((r >= p) && ((notLava (f1, f2) tab ) == True ) && (notLava (final1,final2) tab) == True) = Just (Carro (x,y) dir (v1,v2))


                                                                          where f1 = fromIntegral (floor x)
                                                                                f2 = fromIntegral (floor y)
                                                                                final1 = fromIntegral (floor a)
                                                                                final2 = fromIntegral (floor b) 



{-| A função 'move' dá a posição seguinte, seguindo apenas o carro.
     
     == Exemplos de utilização:

          >>>move 1 (Carro (2.3,1.3) 45 (0.1,0.1)) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  
          Just (2.4,1.4)

          >>>move 1 (Carro (2.3,1.3) 45 (2,0)) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  
          Nothing
-}

move :: Tempo       -- ^ tempo a decorrer 
     -> Carro       -- ^ carro a qual vai ser aplicado o movimento
     -> Tabuleiro   -- ^ tableiro escolhido
     -> Maybe Ponto -- ^ novo estado do carro ou a sua possivel destruição

move t (Carro (x,y) dir (v1,v2)) tab = if (pecaPosicao (x+(t*v1),y+(t*v2)) tab) /= (Peca Lava 0) then Just (x+(t*v1),y+(t*v2))
                                                                                                 else Nothing



{-| A função 'notLava' verifica se a posição dada corresponde a uma peça não do tipo Lava.
     
     == Exemplos de utilização:

          >>>notLava (2.1,1.3)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
          True

          >>>notLava (0.2,0.4)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
          False
-}

notLava :: (Double, Double) -- ^ posição escolhida
        -> Tabuleiro        -- ^ tabuleiro escolhido 
        -> Bool             -- ^ True se não for lava, False se fors

notLava (x,y) tab = if (pecaPosicao (x,y) tab) == (Peca Lava 0) then False
                                                                else True 



{-| A função 'pecaPosicao' determina a peça que está numa certa posição do tabuleiro.

  == Exemplos de utilização:

       >>> pecaPosicao (3,1) [[Peca Lava 0,Peca Lava 0 Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 1,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       Peca Recta 1

       >>> pecaPosicao (0,0) [[Peca Lava 0,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0,Peca Lava 0]]
       Peca Lava 0
-}

pecaPosicao :: Ponto     -- ^ ponto dado
            -> Tabuleiro -- ^ tabuleiro dado
            -> Peca      -- ^ peça do tabuleiro dado correspondente à posição dada

pecaPosicao (x,y) t = pecaPosicaoAux1 ((fromIntegral (floor x)),0) (pecaPosicaoAux2 ((fromIntegral (floor x)),(fromIntegral (floor y))) t)



{-| A função 'pecaPosicaoAux1' devolve a lista de peças de um tabuleiro em que um certo ponto está contida.

  == Exemplos de utilização:

       >>> pecaPosicaoAux1 (3,0)  [Peca Lava 0,Peca Lava 0 ,Peca Lava 0 ,Peca Recta 0 ,Peca Lava 0,Peca Lava 0]
       Peca Recta 0

       >>> pecaPosicaoAux1 (0,0)  [Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0]
       Peca Lava 0  
-}

pecaPosicaoAux1 :: Ponto   -- ^ ponto dado
                -> [Peca]  -- ^ lista de peças do tabuleiro dado
                -> Peca    -- ^ peça da lista de peças do tabuleiro dado correspondente à posição dada

pecaPosicaoAux1 (0,y) (h:t) = h
pecaPosicaoAux1 (x,y) (h:t) = pecaPosicaoAux1 (x-1,y) t 



{-| A função 'pecaPosicaoAux2' devolve a lista de peças de um tabuleiro em que um certo ponto está contida.

  == Exemplos de utilização:

       >>> pecaPosicaoAux2 (3,1)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       [Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava]

       >>> pecaPosicaoAux2 (2,2)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0 Peca Lava 0,Peca Lava 0]]
       [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
-}

pecaPosicaoAux2 :: Ponto     -- ^ posição dada
                -> Tabuleiro -- ^ tabuleiro dado
                -> [Peca]    -- ^ lista de peças do tabuleiro dado em que a peça correspondente à posição dada se encontra

pecaPosicaoAux2 (x,0) (h:t) = h
pecaPosicaoAux2 (x,y) (h:t) = pecaPosicaoAux2 (x,y-1) t


