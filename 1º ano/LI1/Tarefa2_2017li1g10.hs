{-|              
Module : Tarefa2_2017li1g10
Description : Módulo Haskell contendo a 2ª Tarefa da 1ª Fase do Projeto "Micro Machines" de Laboratórios de Informática 1
Copyright: João Manuel da Costa Ferraz Soares <a77841@alunos.uminho.pt>;
           Filipa Alves dos Santos <a83631@alunos.uminho.pt>
-}

module Tarefa2_2017li1g10 where

import LI11718



{-| A função 'testesT2' dá vários exemplos de tabuleiros possíveis.

-}

testesT2 :: [Tabuleiro] -- ^ lista de exemplos de tabuleiros
testesT2 = [[],
            
            [[Peca Lava 0,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0,Peca Lava 0],
             [Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0,Peca Lava 0],
             [Peca Lava 0,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0]
            ], -- o percurso não é retangular

            [[Peca Lava 0,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0,Peca Lava 0],
             [Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0,Peca Lava 0],
             [Peca Lava 0,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0,Peca Lava 0]
            ], -- o percurso não é cíclico

            [[Peca Lava 0,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0 ,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0],
             [Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0       ,Peca Recta 0,Peca Recta 0        ,Peca (Curva Este) 0,Peca Lava 0],
             [Peca Lava 0,Peca (Rampa Sul) 0  ,Peca Lava 0        ,Peca Lava 0 ,Peca Lava 0         ,Peca (Rampa Sul) 0 ,Peca Lava 0],
             [Peca Lava 0,Peca (Curva Oeste) 1,Peca (Rampa Este) 1,Peca Recta 2,Peca (Rampa Oeste) 1,Peca (Curva Sul) 1 ,Peca Lava 0]
            ], -- percurso não é todo rodeado por peças do tipo lava

            [[Peca Lava 0,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0 ,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0],
             [Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0       ,Peca Recta 0,Peca Recta 0        ,Peca (Curva Este) 0,Peca Lava 0],
             [Peca Lava 0,Peca (Rampa Sul) 0  ,Peca Lava 0        ,Peca Lava 0 ,Peca Lava 0         ,Peca (Rampa Sul) 0 ,Peca Lava 0],
             [Peca Lava 0,Peca (Curva Oeste) 4,Peca (Rampa Este) 1,Peca Recta 2,Peca (Rampa Oeste) 1,Peca (Curva Sul) 1 ,Peca Lava 0],
             [Peca Lava 0,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0 ,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0]
            ], -- percurso  com alturas incompatíveis

            [[Peca Lava 0,Peca Lava 0         ,Peca Lava 1        ,Peca Lava 0 ,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0],
             [Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0       ,Peca Recta 0,Peca Recta 0        ,Peca (Curva Este) 0,Peca Lava 0],
             [Peca Lava 0,Peca (Rampa Sul) 0  ,Peca Lava 0        ,Peca Lava 0 ,Peca Lava 0         ,Peca (Rampa Sul) 0 ,Peca Lava 0],
             [Peca Lava 0,Peca (Curva Oeste) 1,Peca (Rampa Este) 1,Peca Recta 2,Peca (Rampa Oeste) 1,Peca (Curva Sul) 1 ,Peca Lava 0],
             [Peca Lava 0,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0 ,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0]
            ], -- percurso com peças do tipo lava de altura diferente de 0
           
            [[Peca Lava 0,Peca Lava 0         ,Peca Lava 0 ,Peca Lava 0        ,Peca Lava 0,Peca Lava 0 ,Peca Lava 0],
             [Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0,Peca Lava 0 ,Peca Lava 0],
             [Peca Lava 0,Peca Recta 0        ,Peca Lava 0 ,Peca Recta 0       ,Peca Lava 0,Peca Recta 0,Peca Lava 0],
             [Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0 ,Peca Lava 0,Peca Recta 0,Peca Lava 0],
             [Peca Lava 0,Peca Lava 0         ,Peca Lava 0 ,Peca Lava 0        ,Peca Lava 0,Peca Lava 0 ,Peca Lava 0]
            ], -- nem todas as peças fora do percurso são do tipo Lava
           
            [[Peca Lava 0,Peca Lava 0         ,Peca Lava 0 ,Peca Lava 0        ,Peca Lava 0],
             [Peca Lava 0,Peca (Curva Este) 0 ,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],
             [Peca Lava 0,Peca Recta 0        ,Peca Lava 0 ,Peca Recta 0       ,Peca Lava 0],
             [Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0 ,Peca Lava 0],
             [Peca Lava 0,Peca Lava 0         ,Peca Lava 0 ,Peca Lava 0        ,Peca Lava 0]
            ], -- não se volta a chegar à peça inicial com a trajetória inicial
           
            [[Peca Lava 0,Peca Lava 0         ,Peca Lava 0 ,Peca Lava 0        ,Peca Lava 0],
             [Peca Lava 0,Peca (Curva Este) 0 ,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],
             [Peca Lava 0,Peca (Rampa Sul) 0  ,Peca Lava 0 ,Peca (Rampa Sul) 0 ,Peca Lava 0],
             [Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1 ,Peca Lava 0],
             [Peca Lava 0,Peca Lava 0         ,Peca Lava 0 ,Peca Lava 0        ,Peca Lava 0]
            ]
           ]



{-| A função 'valida' verifica se um mapa é válido ou não. 

  == Exemplos de utilização:

       >>> valida ( Mapa ((2,1),Este)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca (Curva Oeste) 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca (Curva Sul) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] )
       True

       >>> valida ( Mapa ((1,1),Este)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] )
       False
-}

valida :: Mapa -- ^ mapa dado
       -> Bool -- ^ valor lógico ( True -> mapa válido )

valida (Mapa (p,o) tab) = (mapaRectangular tab) && (posicaoInTabuleiro p tab) && (posicaoInLava p tab) && (rodeadoPorLava tab) && (alturaLava tab) && (ciclica o p tab) && (percursoUnico o p tab) && (alturaMaster o p tab) 

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

{-| A função 'mapaRectangular' veirifca se o mapa é rectangular

  == Exemplos de utilização:

       >>> mapaRectangular [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       True

       >>> mapaRectangular [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       False      
-}

mapaRectangular :: Tabuleiro -- ^ tabuleiro dado
                -> Bool      -- ^ valor lógico ( True -> o mapa é rectangular)
mapaRectangular (h:[]) = True
mapaRectangular (h:t) | length h == length (head t) = True
                      | otherwise = False 



{-| A função 'posicaoInTabuleiro' verifica se a posição existe, ou seja, se as coordenadas da posição são possíveis tendo em conta as dimensões do tabuleiro.

  == Exemplos de utilização:

       >>> posicaoInTabuleiro (0,1)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       True

       >>> posicaoInTabuleiro (4,5)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0 ,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       False      
-}

posicaoInTabuleiro :: Posicao   -- ^ posição inicial dada
                   -> Tabuleiro -- ^ tabuleiro dado
                   -> Bool      -- ^ valor lógico ( True -> posição pertence ao tabuleiro )

posicaoInTabuleiro (x,y) [] = False
posicaoInTabuleiro (x,y) tab | (x >= 0) && (x <= (fst(dimensaoTab (0,0) tab)) - 1) && (y >= 0) && (y <= (snd(dimensaoTab (0,0) tab)) - 1) = True
                             | otherwise = False



{-| A função 'posicaoInLava' verifica se a peça correspondente à posição inicial não é uma peça do tipo lava.

  == Exemplos de utilização:

       >>> posicaoInLava (1,1)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0 ,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       True

       >>> posicaoInLava (0,0)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       False 
-}

posicaoInLava :: Posicao   -- ^ posição inicial dada
              -> Tabuleiro -- ^ tabuleiro dado
              -> Bool      -- ^ valor lógico ( True -> posição corresponde a uma peça não do tipo lava )

posicaoInLava (x,y) [] = False
posicaoInLava (x,y) tab | pecaPosicao (x,y) tab == Peca Lava 0 = False
                        | otherwise = True



{-| A função 'rodeadoPorLava' verifica se um percurso está rodeado por lava, ou seja, se primeira e a última linha e a primeira e última coluna são constítuidas apenas 
por peças do tipo lava.

  == Exemplos de utilização:

       >>> rodeadoPorLava  [[Peca Lava 0,Peca Lava 0,Peca Lava 0 ,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0 ,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       True

       >>> rodeadoPorLava  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0,Peca Lava 0]]
       False
-}

rodeadoPorLava :: Tabuleiro -- ^ tabuleiro dado
               -> Bool      -- ^ valor lógico ( True -> a parte exterior do percurso está toda rodeada por lava )

rodeadoPorLava (h:t) = (rodeadoPorLavaAux1 h) && (rodeadoPorLavaAux1 (last t) ) && (rodeadoPorLavaAux2 (init(tail t)) )



{-| A função 'rodeadoPorLavaAux1' verifica se uma lista de peças é constituído apenas por peças do tipo lava.

  == Exemplos de utilização:

       >>> rodeadoPorLavaAux1 [Peca Lava 0,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0,Peca Lava 0]
       True

       >>> rodeadoPorLavaAux1 [Peca (Rampa Sul) 0,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0,Peca Lava 0]
       False
-}

rodeadoPorLavaAux1 :: [Peca] -- ^ lista de peças dada
                   -> Bool   -- ^ valor lógico ( True -> posição corresponde a uma peça não do tipo lava )

rodeadoPorLavaAux1 [] = True
rodeadoPorLavaAux1 (h:t) | h == Peca Lava 0 = rodeadoPorLavaAux1 t 
                         | otherwise = False



{-| A função 'rodeadoPorLavaAux2' verifica se a primeira e a última coluna de um tabuleiro são constituídas apenas por peças do tipo lava.

  == Exemplos de utilização:

       >>> rodeadoPorLavaAux2 [[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0]]
       True

       >>> rodeadoPorLavaAux2 [[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0]]
       False
-}

rodeadoPorLavaAux2 :: Tabuleiro -- ^ tabuleiro dado 
                   -> Bool      -- ^ valor lógico ( True -> a primeira e a última peça de todas as linhas dos tabuleiro são do tipo lava )

rodeadoPorLavaAux2 [] = True
rodeadoPorLavaAux2 (h:t) | (head h == Peca Lava 0) && (last h == Peca Lava 0) = rodeadoPorLavaAux2 t
                         | otherwise = False



{-| A função 'alturaLava' verifica se a altura de todas as peças do tipo lava de um tabuleiro é igual a 0.

  == Exemplos de utilização:

       >>> alturaLava [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       True

       >>> alturaLava [[Peca Lava 0,Peca Lava 2,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 1,Peca Lava 0,Peca Lava 0]]
       False
-}

alturaLava :: Tabuleiro -- ^ tabuleiro dado
           -> Bool      -- ^ valor lógico ( True -> todas as peças do tipo lava têm altura 0 )

alturaLava [] = True
alturaLava (h:t) | alturaLavaAux1 h = alturaLava t
                 | otherwise = False



{-| A função 'alturaLavaAux1' verifica se a altura de todas as peças do tipo lava de uma lista de peças é igual a 0.

  == Exemplos de utilização:

       >>> alturaLavaAux1 [Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0]
       True

       >>> alturaLavaAux1 [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 1]
       False

-}

alturaLavaAux1 :: [Peca] -- ^ lista de peças do tabuleiro
               -> Bool   -- ^ valor lógico ( True -> todas as peças do tipo lava têm altura 0 )

alturaLavaAux1 [] = True
alturaLavaAux1 ((Peca Lava a):t) | a == 0 = alturaLavaAux1 t
                                 | otherwise = False
alturaLavaAux1 (h:t) = alturaLavaAux1 t



{-| A função 'pecaPosicao' determina a peça que está numa certa posição do tabuleiro.

  == Exemplos de utilização:

       >>> pecaPosicao (3,1) [[Peca Lava 0,Peca Lava 0 Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 1,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       Peca Recta 1

       >>> pecaPosicao (0,0) [[Peca Lava 0,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0,Peca Lava 0]]
       Peca Lava 0
-}

pecaPosicao :: Posicao   -- ^ posição dada
            -> Tabuleiro -- ^ tabuleiro dado
            -> Peca      -- ^ peça do tabuleiro dado correspondente à posição dada

pecaPosicao (x,y) t = pecaPosicaoAux1 (x,y) (pecaPosicaoAux2 (x,y) t)



{-| A função 'pecaPosicaoAux1' devolve a lista de peças de um tabuleiro em que um certa posição está contida.

  == Exemplos de utilização:

       >>> pecaPosicaoAux1 (3,0)  [Peca Lava 0,Peca Lava 0 ,Peca Lava 0 ,Peca Recta 0 ,Peca Lava 0,Peca Lava 0]
       Peca Recta 0

       >>> pecaPosicaoAux1 (0,0)  [Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0]
       Peca Lava 0  
-}

pecaPosicaoAux1 :: Posicao -- ^ posição dada 
                -> [Peca]  -- ^ lista de peças do tabuleiro dado
                -> Peca    -- ^ peça da lista de peças do tabuleiro dado correspondente à posição dada

pecaPosicaoAux1 (0,y) (h:t) = h
pecaPosicaoAux1 (x,y) (h:t) = pecaPosicaoAux1 (x-1,y) t 



{-| A função 'pecaPosicaoAux2' devolve a lista de peças de um tabuleiro em que um certa posição está contida.

  == Exemplos de utilização:

       >>> pecaPosicaoAux2 (3,1)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       [Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava]

       >>> pecaPosicaoAux2 (2,2)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0 Peca Lava 0,Peca Lava 0]]
       [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
-}

pecaPosicaoAux2 :: Posicao   -- ^ posição dada
                -> Tabuleiro -- ^ tabuleiro dado
                -> [Peca]    -- ^ lista de peças do tabuleiro dado em que a peça correspondente à posição dada se encontra

pecaPosicaoAux2 (x,0) (h:t) = h
pecaPosicaoAux2 (x,y) (h:t) = pecaPosicaoAux2 (x,y-1) t



{-| A função 'percursoUnico verifica se um tabuleiro tem um único percurso, ou seja, verifica se após as peças do percurso serem substituídas por uma peça do tipo lava,
ainda existe alguma peça que seja de um tipo sem ser lava.

  == Exemplos de utilização:

       >>> percursoUnico Este  (2,1)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       True

       >>> percursoUnico Este  (2,2)  [[Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       False
-}

percursoUnico :: Orientacao -- ^ orientação inicial
              -> Posicao    -- ^ posição inicial
              -> Tabuleiro  -- ^ tabuleiro dado
              -> Bool       -- ^ valor lógico ( True -> fora do percurso não há mais peças sem ser lava, ou seja, só há 1 percurso )

percursoUnico o p tab = umPercurso(seguePercurso (nextOrientInicial o (pecaPosicao p tab))  ( nextPosInicial o p (pecaPosicao p tab) ) ( nextPosInicial o p (pecaPosicao p tab) ) tab tab ( nextPecaInicial  o p tab (pecaPosicao p tab) ) )



{-| A função 'umPercurso' verifica se todas as peças de um tabuleiro são do tipo lava.

  == Exemplos de utilização:

       >>> umPercurso [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       True

       >>> umPercurso [[Peca Lava 0,Peca Lava 0 ,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0 ,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       False
-}

umPercurso :: Tabuleiro -- ^ tabuleiro dado
           -> Bool      -- ^ valor lógico ( True -> tabuleiro dado é constituído só de peças do tipo lava  )

umPercurso [] = True
umPercurso (h:t) | umPercursoAux1 h = umPercurso t
                 | otherwise = False



{-| A função 'umPercursoAux1' verifica se todas as peças de uma lista de peças são do tipo lava.

  == Exemplos de utilização:

       >>> umPercursoAux1 [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
       True

       >>> umPercursoAux1 [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Lava 0]
       False       
-}

umPercursoAux1 :: [Peca] -- ^ lista de peças dada 
               -> Bool   -- ^ valor lógico ( True -> lista de peças dada é constituída só de peças do tipo lava )

umPercursoAux1 [] = True
umPercursoAux1 (h:t) | h == Peca Lava 0 = umPercursoAux1 t
                     | otherwise = False



{-| A função 'seguePercurso' devolve um tabuleiro em que todas as peças do percurso são substítuidas por peças do tipo lava.

  == Exemplos de utilização:
 
       >>> seguePercurso Este (2,1) (2,1)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0 ,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca (Rampa Este) 1,Peca Recta 2,Peca (Rampa Oeste) 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]   [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca (Rampa Este) 1,Peca Recta 2,Peca (Rampa Oeste) 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  (Peca Reta 0)
       [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]

       >>> seguePercurso Este (2,2) (2,2)  [[Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0 ,Peca Lava 0,Peca Lava 0]]   [[Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  (Peca Recta 0)   
       [[Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0 ,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0 ,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0 ,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0 ,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0 ,Peca Lava 0,Peca Lava 0]]
 
-}

seguePercurso :: Orientacao -- ^ orientação inicial
              -> Posicao    -- ^ posição inicial que vai sendo modificada
              -> Posicao    -- ^ posição inicial
              -> Tabuleiro  -- ^ tabuleiro do mapa
              -> Tabuleiro  -- ^ tabuleiro do mapa que vai sendo modificado
              -> Peca       -- ^ peça correspondente à posição inicial
              -> Tabuleiro  -- ^ tabuleiro resultante de substituir as peças do percurso por peças do tipo lava 

seguePercurso o p p2 tab tab2 h | ((nextPeca o p tab h) == (Peca Lava 0) && (nextPos o p h) /= p2) = undefined
                                | ((nextPeca o p tab h) /= (Peca Lava 0) && (nextPos o p h) /= p2) = seguePercurso (nextOrient o h) (nextPos o p h) p2 tab (tiraPecaTab tab2 (0,0) p) (nextPeca o p tab h) 
                                | ((nextPeca o p tab h) /= (Peca Lava 0) && (nextPos o p h) == p2) = tiraPecaTab tab2 (0,0) p 



{-| A função 'tiraPecaTab', dada uma certa posição, substitui a peça nessa respetiva posição por uma peça do tipo lava.

  == Exemplos de utilização:

       >>> tiraPecaTab [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  (0,0) (2,1) 
       [[Peca Lava 0,Peca Lava 0         ,Peca Lava 0 ,Peca Lava 0        ,Peca Lava 0],
        [Peca Lava 0,Peca (Curva Norte) 0,Peca Lava 0 ,Peca (Curva Este) 0,Peca Lava 0],
        [Peca Lava 0,Peca Recta 0        ,Peca Lava 0 ,Peca Recta 0       ,Peca Lava 0],
        [Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0 ,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0         ,Peca Lava 0 ,Peca Lava 0        ,Peca Lava 0]]

       >>> tiraPecaTab [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca (Rampa Este) 1,Peca Recta 2,Peca (Rampa Oeste) 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  (0,0) (3,3) 
       [[Peca Lava 0,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0 ,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0],    
        [Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0       ,Peca Recta 0,Peca Recta 0        ,Peca (Curva Este) 0,Peca Lava 0],     
        [Peca Lava 0,Peca (Rampa Sul) 0  ,Peca Lava 0        ,Peca Lava 0 ,Peca Lava 0         ,Peca (Rampa Sul) 0 ,Peca Lava 0],    
        [Peca Lava 0,Peca (Curva Oeste) 1,Peca (Rampa Este) 1,Peca Lava 0 ,Peca (Rampa Oeste) 1,Peca (Curva Sul) 1 ,Peca Lava 0],    
        [Peca Lava 0,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0 ,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0]]
-}

tiraPecaTab :: Tabuleiro -- ^ tabuleiro dado
            -> Posicao   -- ^ (0,0)
            -> Posicao   -- ^ posição do percurso 
            -> Tabuleiro -- ^ tabuleiro cuja peça correspondente à posição dada foi substiuída por uma peça do tipo lava

tiraPecaTab [] _ _  = []
tiraPecaTab (h:t) (x,y) (x2,y2) | y == y2 = (tiraPecaTabAux h (x,y) (x2,y2)):t
                                | otherwise = h:tiraPecaTab t (x,y+1) (x2,y2) 



{-| A função 'tiraPecaTabAux', dada uma certa posição, devolve a lista de peças em que a peça correspondente à posição foi substituída por uma peça do tipo lava.

  == Exemplos de utilização: 

       >>> tiraPecaTabAux [Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0] (0,0) (1,3)
       [Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0]

       >>> tiraPecaTabAux [Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Lava 0] (0,0) (2,4)
       [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]

-}

tiraPecaTabAux :: [Peca]  -- ^ lista de peças em que a peça correspondente à posição está inserida
               -> Posicao -- ^ (0,0)
               -> Posicao -- ^ posição do percurso
               -> [Peca]  -- ^ lista de peças em que a peça correspondente à posição foi substituída por uma peça do tipo lava

tiraPecaTabAux (h:t) (x,y) (x2,y2) | x == x2 = (Peca Lava 0):t 
                                   | otherwise = h:(tiraPecaTabAux t (x+1,y) (x2,y2))



{-| A função 'dimensaoTab' dá-nos a dimensão de um determinado tabuleiro.

  == Exemplos de utilização:

       >>> dimensaoTab (0,0) [[Peca Lava 0,Peca Lava 0,Peca Lava 0 ,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       (5,5)

       >>> dimensaoTab (0,0) [[Peca Lava 0,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0]]
       (5,3)
-}

dimensaoTab :: Dimensao  -- ^ (0,0)
            -> Tabuleiro -- ^ tabuleiro dado
            -> Dimensao  -- ^ dimensão do tabuleiro dado

dimensaoTab (x,y) [] = (x,y)
dimensaoTab (x,y) ([]:z) = dimensaoTab (x,y+1) z
dimensaoTab (x,y) ((a:b):z) = dimensaoTab (x+1,y) ((b):z)



{-| A função 'ciclica' tem a mesma função 'percorre', apenas escrita de forma mais simples e legível.

  == Exemplos de utilização:

       >>> ciclica Este (2,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       True

       >>> ciclica Este (1,1) [[Peca Lava 0,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0]]
       False
-}

ciclica :: Orientacao -- ^ orientação inicial
        -> Posicao    -- ^ posição inicial
        -> Tabuleiro  -- ^ tabuleiro do mapa
        -> Bool       -- ^ valor lógico ( True -> percurso é cíclico )

ciclica o p tab =  ((nextPecaInicial  o p tab (pecaPosicao p tab)) /= Peca Lava 0)  && (percorre  (nextOrientInicial o (pecaPosicao p tab))  ( nextPosInicial o p (pecaPosicao p tab) ) ( nextPosInicial o p (pecaPosicao p tab) ) tab ( nextPecaInicial  o p tab (pecaPosicao p tab) ) )



{-| A função 'percorre' verifica se a função é cíclica tal que começando na peça de partida com​ ​a ​orientação​ ​inicial​ volta-se​ ​a ​chegar​ ​à ​peça​ ​de​ ​partida​ ​com​ ​a ​orientação​ ​ inicial.

  == Exemplos de utilização:

       >>> percorre Este (2,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca (Rampa Este) 1,Peca Recta 2,Peca (Rampa Oeste) 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] 
       True

       >>> percorre Este (2,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0 ,Peca Lava 0]]
       False
-}

percorre :: Orientacao -- ^ orientação seguinte da inicial
         -> Posicao    -- ^ posição seguinte da inicial que vai sendo modificada
         -> Posicao    -- ^ posição seguinte da inicial
         -> Tabuleiro  -- ^ tabuleiro do mapa
         -> Peca       -- ^ peça seguinte da inicial
         -> Bool       -- ^ valor lógico ( True -> percurso cíclico )

percorre o p p2 tab h | ((nextPeca o p tab h) == (Peca Lava 0)) = False
                      | ((nextPeca o p tab h) /= (Peca Lava 0) && (nextPos o p h) /= p2) = percorre (nextOrient o h) (nextPos o p h) p2 tab (nextPeca o p tab h) 
                      | ((nextPeca o p tab h) /= (Peca Lava 0) && (nextPos o p h) == p2) = True



{-| A função 'nextPecaInicial' devolve a peça seguinte do caminho da peça inicial.

  == Exemplos de utilização:

       >>> nextPecaInicial  Este (1,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  (Peca (Curva Norte) 0)
       Peca (Curva Este) 0

       >>> nextPecaInicial Oeste (3,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       Peca Recta 0
-}

nextPecaInicial :: Orientacao -- ^ orientação inicial
                -> Posicao    -- ^ posição inicial
                -> Tabuleiro  -- ^ tabuleiro do mapa
                -> Peca       -- ^ peça inicial
                -> Peca       -- ^ peça seguinte da inicial

nextPecaInicial o (x,y) tab (Peca Recta a)         |o == Este  = pecaPosicao (x+1,y) tab
                                                   |o == Norte = pecaPosicao (x,y-1) tab
                                                   |o == Sul   = pecaPosicao (x,y+1) tab
                                                   |o == Oeste = pecaPosicao (x-1,y) tab

nextPecaInicial o (x,y) tab (Peca (Curva Norte) a) |o == Este = pecaPosicao (x+1,y) tab
                                                   |o == Sul  = pecaPosicao (x,y+1) tab
                                                   |(o == Norte) || (o == Oeste) = (Peca Lava 0)


nextPecaInicial o (x,y) tab (Peca (Curva Sul) a)   |o == Oeste = pecaPosicao (x-1,y) tab
                                                   |o == Norte = pecaPosicao (x,y-1) tab
                                                   |(o == Este) || (o == Sul) = (Peca Lava 0)

nextPecaInicial o (x,y) tab (Peca (Curva Este) a)  |o == Oeste = pecaPosicao (x-1,y) tab
                                                   |o == Sul   = pecaPosicao (x,y+1) tab
                                                   |(o == Este) || (o == Norte) = (Peca Lava 0)
                                
nextPecaInicial o (x,y) tab (Peca (Curva Oeste) a) |o == Este  = pecaPosicao (x+1,y) tab
                                                   |o == Norte = pecaPosicao (x,y-1) tab
                                                   |(o == Oeste) || (o == Sul) = (Peca Lava 0)

nextPecaInicial o (x,y) tab (Peca (Rampa o2) a)    |o == Este  = pecaPosicao (x+1,y) tab
                                                   |o == Norte = pecaPosicao (x,y-1) tab
                                                   |o == Sul   = pecaPosicao (x,y+1) tab
                                                   |o == Oeste = pecaPosicao (x-1,y) tab



{-| A função 'nextOrientInicial' devolve a orientação a seguir da inicial.

  == Exemplos de utilização:

       >>> nextOrientInicial Este (Peca Recta 0)
       Este

       >>> nextOrientInicial Norte (Peca (Curva Sul) 0)
       Norte
-}

nextOrientInicial :: Orientacao -- ^ orientação inicial
                  -> Peca       -- ^ peça inicial
                  -> Orientacao -- ^ orientação seguinte da inicial

nextOrientInicial o (Peca Recta a) = o

nextOrientInicial o (Peca (Curva Norte) a) | o == Este = Este
                                           | o == Sul  = Sul
                                           |(o == Norte) || (o == Oeste) = Sul

nextOrientInicial o (Peca (Curva Sul) a)   | o == Oeste = Oeste
                                           | o == Norte = Norte  
                                           |(o == Este) || (o == Sul) = Sul

nextOrientInicial o (Peca (Curva Este) a)  | o == Sul   = Sul
                                           | o == Oeste = Oeste
                                           |(o == Este) || (o == Norte) =  Sul

nextOrientInicial o (Peca (Curva Oeste) a) | o == Norte = Norte
                                           | o == Este   = Este  
                                           |(o == Oeste) || (o == Sul) =  Sul                                 

nextOrientInicial o (Peca (Rampa o2) a) = o



{-| A função 'nextPosInicial' determina a posição seguinte da posição inicial.

  == Exemplos de utilização:

       >>> nextPosInicial  Norte (1,1) (Peca (Rampa Norte) 0)
       (1,0) 

       >>> nextPosInicial  Este (1,1) (Peca (Curva Norte) 0)
       (2,1)
-}

nextPosInicial :: Orientacao -- ^ orientação inicial
               -> Posicao    -- ^ posição inicial
               -> Peca       -- ^ peça inicial
               -> Posicao    -- ^ posição seguinte da inicial

nextPosInicial o (x,y) (Peca Recta a)  |o == Este  = (x+1,y) 
                                       |o == Norte = (x,y-1)
                                       |o == Sul   = (x,y+1) 
                                       |o == Oeste = (x-1,y) 

nextPosInicial o (x,y) (Peca (Curva Norte) a) |o == Este = (x+1,y) 
                                              |o == Sul  = (x,y+1)
                                              |(o == Este) || (o == Sul) = (x,y)

nextPosInicial o (x,y) (Peca (Curva Sul) a)   |o == Oeste = (x-1,y) 
                                              |o == Norte = (x,y-1) 
                                              |(o == Este) || (o == Sul) = (x,y)

nextPosInicial o (x,y) (Peca (Curva Este) a)  |o == Oeste = (x-1,y)
                                              |o == Sul   = (x,y+1) 
                                              |(o == Este) || (o == Norte) = (x,y)
                                
nextPosInicial o (x,y) (Peca (Curva Oeste) a) |o == Este   = (x+1,y)
                                              |o == Norte = (x,y-1)
                                              |(o == Oeste) || (o == Sul) = (x,y)

nextPosInicial o (x,y) (Peca (Rampa o2) a)    |o == Este  = (x+1,y) 
                                              |o == Norte = (x,y-1)
                                              |o == Sul   = (x,y+1) 
                                              |o == Oeste = (x-1,y)



{-| A função 'nextPeca' devolve a peça seguinte do caminho de uma certa peça.

  == Exemplos de utilização:

       >>> nextPeca Este (2,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  Peca Recta 0 
       Peca (Curva Este) 0

       >>> nextPeca Sul (3,3)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  Peca (Curva Sul)
       Peca Reta 0
-}

nextPeca :: Orientacao -- ^ orientação dada
         -> Posicao    -- ^ posição dada
         -> Tabuleiro  -- ^ tabuleiro dada
         -> Peca       -- ^ peça correspondente à posição dada
         -> Peca       -- ^ peça seguinte à dada

nextPeca o (x,y) tab (Peca Recta a)         |o == Este  = pecaPosicao (x+1,y) tab
                                            |o == Norte = pecaPosicao (x,y-1) tab
                                            |o == Sul   = pecaPosicao (x,y+1) tab
                                            |o == Oeste = pecaPosicao (x-1,y) tab

nextPeca o (x,y) tab (Peca (Curva Norte) a) |o == Norte = pecaPosicao (x+1,y) tab
                                            |o == Oeste = pecaPosicao (x,y+1) tab
                                            |(o == Este) || (o == Sul) = (Peca Lava 0)


nextPeca o (x,y) tab (Peca (Curva Sul) a)   |o == Sul  = pecaPosicao (x-1,y) tab
                                            |o == Este = pecaPosicao (x,y-1) tab
                                            |(o == Oeste) || (o == Norte) = (Peca Lava 0)

nextPeca o (x,y) tab (Peca (Curva Este) a)  |o == Norte = pecaPosicao (x-1,y) tab
                                            |o == Este  = pecaPosicao (x,y+1) tab
                                            |(o == Oeste) || (o == Sul) = (Peca Lava 0)
                                
nextPeca o (x,y) tab (Peca (Curva Oeste) a) |o == Sul   = pecaPosicao (x+1,y) tab
                                            |o == Oeste = pecaPosicao (x,y-1) tab
                                            |(o == Este) || (o == Norte) = (Peca Lava 0)

nextPeca o (x,y) tab (Peca (Rampa o2) a)    |o == Este  = pecaPosicao (x+1,y) tab
                                            |o == Norte = pecaPosicao (x,y-1) tab
                                            |o == Sul   = pecaPosicao (x,y+1) tab
                                            |o == Oeste = pecaPosicao (x-1,y) tab



{-| A função 'nextOrient' devolve a orientação seguinte do percurso.

  == Exemplos de utilização:

       >>> nextOrient Este (Peca Recta 0)
       Este

       >>> nextOrient Norte (Peca (Curva Sul) 1)
       Oeste
-}

nextOrient :: Orientacao -- ^ orientação dada
           -> Peca       -- ^ peça dada
           -> Orientacao -- ^ orientação seguinte à dada

nextOrient o (Peca Recta a) = o

nextOrient o (Peca (Curva Norte) a) | o == Norte = Este
                                    | o == Oeste = Sul
                                    |(o == Este) || (o == Sul) = Sul

nextOrient o (Peca (Curva Sul) a)   | o == Sul  = Oeste
                                    | o == Este = Norte  
                                    |(o == Oeste) || (o == Norte) = Sul

nextOrient o (Peca (Curva Este) a)  | o == Este  = Sul
                                    | o == Norte = Oeste
                                    |(o == Oeste) || (o == Sul) =  Sul

nextOrient o (Peca (Curva Oeste) a) | o == Oeste = Norte
                                    | o == Sul   = Este  
                                    |(o == Este) || (o == Norte) =  Sul                                 

nextOrient o (Peca (Rampa o2) a) = o



{-| A função 'nextPos' determina a posição seguinte de uma certa posição.

  == Exemplos de utilização:

       >>> nextPos Norte (1,1) (Peca (Rampa Norte) 0)
       (1,0)

       >>> nextPos Sul (2,1) (Peca Recta 0)
       (2,2)
-}

nextPos :: Orientacao -- ^ orientação dada
        -> Posicao    -- ^ posição dada
        -> Peca       -- ^ peça correspondente à posição dada
        -> Posicao    -- ^ posição seguinte à dada

nextPos o (x,y) (Peca Recta a)         |o == Este  = (x+1,y) 
                                       |o == Norte = (x,y-1)
                                       |o == Sul   = (x,y+1) 
                                       |o == Oeste = (x-1,y) 

nextPos o (x,y) (Peca (Curva Norte) a) |o == Norte = (x+1,y) 
                                       |o == Oeste = (x,y+1)
                                       |(o == Este) || (o == Sul)    = (x,y)

nextPos o (x,y) (Peca (Curva Sul) a)   |o == Sul  = (x-1,y) 
                                       |o == Este = (x,y-1) 
                                       |(o == Oeste) || (o == Norte) = (x,y)

nextPos o (x,y) (Peca (Curva Este) a)  |o == Norte = (x-1,y)
                                       |o == Este  = (x,y+1) 
                                       |(o == Oeste) || (o == Sul)   = (x,y)
                                
nextPos o (x,y) (Peca (Curva Oeste) a) |o == Sul   = (x+1,y)
                                       |o == Oeste = (x,y-1)
                                       |(o == Este) || (o == Norte)  = (x,y)

nextPos o (x,y) (Peca (Rampa o2) a)    |o == Este  = (x+1,y) 
                                       |o == Norte = (x,y-1)
                                       |o == Sul   = (x,y+1) 
                                       |o == Oeste = (x-1,y)



{-| A função 'alturaMaster' verifica se as alturas das peças do tabuleiro são compatíveis.

  == Exemplos de utilização:

       >>> alturaMaster Este  (1,1)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca (Rampa Este) 1,Peca Recta 2,Peca (Rampa Oeste) 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       True

       >>> alturaMaster Oeste (2,1)  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca (Rampa Este) 1,Peca Recta 2,Peca (Rampa Oeste) 1,Peca (Curva Sul) 2,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
       False
-}

alturaMaster :: Orientacao -- ^ orientação inicial
             -> Posicao    -- ^ posição inicial
             -> Tabuleiro  -- ^ tabuleiro do mapa
             -> Bool       -- ^ valor lógico ( True -> as alturas das peças do tabuleiro do mapa são compatíveis )

alturaMaster o p tab = ( verificaAltura ( (alturaCompativel (nextOrientInicial o (pecaPosicao p tab)) (nextPosInicial o p (pecaPosicao p tab)) (nextPosInicial o p (pecaPosicao p tab)) tab (nextPecaInicial  o p tab (pecaPosicao p tab)) )) ) && ( verificaAltura2 (head(alturaCompativel o p p tab (pecaPosicao p tab ))) (last(alturaCompativel o p p tab (pecaPosicao p tab))) )



{-| A função 'alturaCompativel' cria uma lista de peças do percuso e a respetiva indicação (se sobem, descem ou mantêm a altura)

  == Exemplos de utilização:

       >>> alturaCompativel  Oeste (2,1) (2,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] (Peca Recta 0)
       [(Peca Recta 0,"Neutro"),(Peca (Curva Norte) 0,"Neutro"),(Peca (Rampa Sul) 0,"Sobe"),(Peca (Curva Oeste) 1,"Neutro"),(Peca Recta 1,"Neutro"),(Peca (Curva Sul) 1,"Neutro"),(Peca (Rampa Sul) 0,"Desce"),(Peca (Curva Este) 0,"Neutro")]


       >>> alturaCompativel  Este  (2,1) (2,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 4,Peca (Rampa Este) 1,Peca Recta 2,Peca (Rampa Oeste) 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] (Peca Recta 0)
       [(Peca Recta 0,"Neutro"),(Peca Recta 0,"Neutro"),(Peca Recta 0,"Neutro"),(Peca (Curva Este) 0,"Neutro"),(Peca (Rampa Sul) 0,"Sobe"),(Peca (Curva Sul) 1,"Neutro"),(Peca (Rampa Oeste) 1,"Sobe"),(Peca Recta 2,"Neutro"),(Peca (Rampa Este) 1,"Desce"),(Peca (Curva Oeste) 4,"Neutro"),(Peca (Rampa Sul) 0,"Desce"),(Peca (Curva Norte) 0,"Neutro")]
-} 
 
alturaCompativel :: Orientacao      -- ^ orientação seguite à inicial
                 -> Posicao         -- ^ posição seguinte à inicial que vai sendo modificada
                 -> Posicao         -- ^ posição seguinte à inicial
                 -> Tabuleiro       -- ^ tabuleiro dado
                 -> Peca            -- ^ peça seguinte à inicial
                 -> [(Peca,String)] -- ^ peças do percuso e a respetiva indicação (se sobem, descem ou mantêm a altura)

alturaCompativel o p p2 tab (Peca (Rampa Norte) b) | (o == Norte ) && ((nextPos o p (Peca (Rampa Norte) b)) /= p2) = ((Peca (Rampa Norte) b),"Sobe")  :(alturaCompativel (nextOrient o (Peca (Rampa Norte) b)) (nextPos o p (Peca (Rampa Norte) b)) p2 tab (nextPeca o p tab (Peca (Rampa Norte) b)))
                                                   | (o == Sul   ) && ((nextPos o p (Peca (Rampa Norte) b)) /= p2) = ((Peca (Rampa Norte) b),"Desce") :(alturaCompativel (nextOrient o (Peca (Rampa Norte) b)) (nextPos o p (Peca (Rampa Norte) b)) p2 tab (nextPeca o p tab (Peca (Rampa Norte) b))) 
                                                   | (o == Norte ) && ((nextPos o p (Peca (Rampa Norte) b)) == p2) = [((Peca (Rampa Norte) b),"Sobe")]
                                                   | (o == Sul   ) && ((nextPos o p (Peca (Rampa Norte) b)) == p2) = [((Peca (Rampa Norte) b),"Desce")]

alturaCompativel o p p2 tab (Peca (Rampa Sul) b)   | (o == Sul   ) && ((nextPos o p (Peca (Rampa Sul) b)) /= p2)   = ((Peca (Rampa Sul) b),"Sobe")    :(alturaCompativel (nextOrient o (Peca (Rampa Sul) b))   (nextPos o p (Peca (Rampa Sul) b))   p2 tab (nextPeca o p tab (Peca (Rampa Sul) b)))                              
                                                   | (o == Norte ) && ((nextPos o p (Peca (Rampa Sul) b)) /= p2)   = ((Peca (Rampa Sul) b),"Desce")   :(alturaCompativel (nextOrient o (Peca (Rampa Sul) b))   (nextPos o p (Peca (Rampa Sul) b))   p2 tab (nextPeca o p tab (Peca (Rampa Sul) b)))                                 
                                                   | (o == Sul   ) && ((nextPos o p (Peca (Rampa Sul) b)) == p2)   = [((Peca (Rampa Sul) b),"Sobe")]                               
                                                   | (o == Norte ) && ((nextPos o p (Peca (Rampa Sul) b)) == p2)   = [((Peca (Rampa Sul) b),"Desce")]

alturaCompativel o p p2 tab (Peca (Rampa Este) b)  | (o == Este  ) && ((nextPos o p (Peca (Rampa Este) b)) /= p2)  = ((Peca (Rampa Este) b),"Sobe")   :(alturaCompativel (nextOrient o (Peca (Rampa Este) b))  (nextPos o p (Peca (Rampa Este) b))   p2 tab (nextPeca o p tab (Peca (Rampa Este) b)))                              
                                                   | (o == Oeste ) && ((nextPos o p (Peca (Rampa Este) b)) /= p2)  = ((Peca (Rampa Este) b),"Desce")  :(alturaCompativel (nextOrient o (Peca (Rampa Este) b))  (nextPos o p (Peca (Rampa Este) b))   p2 tab (nextPeca o p tab (Peca (Rampa Este) b)))                                 
                                                   | (o == Este  ) && ((nextPos o p (Peca (Rampa Este) b)) == p2)  = [((Peca (Rampa Este) b),"Sobe")]                               
                                                   | (o == Oeste ) && ((nextPos o p (Peca (Rampa Este) b)) == p2)  = [((Peca (Rampa Este) b),"Desce")]

alturaCompativel o p p2 tab (Peca (Rampa Oeste) b) | (o == Oeste ) && ((nextPos o p (Peca (Rampa Oeste) b)) /= p2) = ((Peca (Rampa Oeste) b),"Sobe")  :(alturaCompativel (nextOrient o (Peca (Rampa Oeste) b)) (nextPos o p (Peca (Rampa Oeste) b))  p2 tab (nextPeca o p tab (Peca (Rampa Oeste) b)))                              
                                                   | (o == Este  ) && ((nextPos o p (Peca (Rampa Oeste) b)) /= p2) = ((Peca (Rampa Oeste) b),"Desce") :(alturaCompativel (nextOrient o (Peca (Rampa Oeste) b)) (nextPos o p (Peca (Rampa Oeste) b))  p2 tab (nextPeca o p tab (Peca (Rampa Oeste) b)))                                 
                                                   | (o == Oeste ) && ((nextPos o p (Peca (Rampa Oeste) b)) == p2) = [((Peca (Rampa Oeste) b),"Sobe")]                               
                                                   | (o == Este  ) && ((nextPos o p (Peca (Rampa Oeste) b)) == p2) = [((Peca (Rampa Oeste) b),"Desce")]

alturaCompativel o p p2 tab (Peca tipo b)          |((nextPos o p (Peca tipo b)) /= p2)                            = ((Peca  tipo b),"Neutro")        :(alturaCompativel (nextOrient o (Peca  tipo b))         (nextPos o p (Peca  tipo b))          p2 tab (nextPeca o p tab (Peca  tipo b)))                                 
                                                   |((nextPos o p (Peca tipo b)) == p2)                            = [((Peca tipo b),"Neutro")]



{-| A função 'verificaAltura' percorre a lista peças do percuso e as respetivas indicaçẽs (se sobem, descem ou mantêm a altura) e verifica se são compatíveis

  == Exemplos de utilização:

       >>> verificaAltura [(Peca Recta 0,"Neutro"),(Peca (Curva Norte) 0,"Neutro"),(Peca (Rampa Sul) 0,"Sobe"),(Peca (Curva Oeste) 1,"Neutro"),(Peca Recta 1,"Neutro"),(Peca (Curva Sul) 1,"Neutro"),(Peca (Rampa Sul) 0,"Desce"),(Peca (Curva Este) 0,"Neutro")]
       True

       >>> verificaAltura [(Peca Recta 0,"Neutro"),(Peca Recta 0,"Neutro"),(Peca Recta 0,"Neutro"),(Peca (Curva Este) 0,"Neutro"),(Peca (Rampa Sul) 0,"Sobe"),(Peca (Curva Sul) 1,"Neutro"),(Peca (Rampa Oeste) 1,"Sobe"),(Peca Recta 2,"Neutro"),(Peca (Rampa Este) 1,"Desce"),(Peca (Curva Oeste) 4,"Neutro"),(Peca (Rampa Sul) 0,"Desce"),(Peca (Curva Norte) 0,"Neutro")]
       False
-}

verificaAltura :: [(Peca,String)] -- ^ peças do percuso e a respetiva indicação (sobem, descem ou mantêm a altura)
               -> Bool            -- ^ valor lógico ( True -> as peças têm alturas compatíveis )

verificaAltura (((Peca tipo a),s):[]) = True
verificaAltura (((Peca tipo1 a),s1):((Peca tipo2 b),s2):t) | (tipo1 == Rampa Norte) && (s1 == "Sobe")  && (s2 == "Neutro") && (a == b-1) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Sul)   && (s1 == "Sobe")  && (s2 == "Neutro") && (a == b-1) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Norte) && (s1 == "Desce") && (s2 == "Neutro") && (a == b)   = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Sul)   && (s1 == "Desce") && (s2 == "Neutro") && (a == b)   = verificaAltura (((Peca tipo2 b),s2):t)

                                                           | (tipo1 == Rampa Norte) && (s1 == "Sobe")  && (tipo2 == Rampa Norte) && (s2 == "Sobe")  && (a == b-1) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Sul)   && (s1 == "Sobe")  && (tipo2 == Rampa Sul)   && (s2 == "Sobe")  && (a == b-1) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Norte) && (s1 == "Desce") && (tipo2 == Rampa Norte) && (s2 == "Desce") && (a == b+1) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Sul)   && (s1 == "Desce") && (tipo2 == Rampa Sul)   && (s2 == "Desce") && (a == b+1) = verificaAltura (((Peca tipo2 b),s2):t)

                                                           | (tipo1 == Rampa Norte) && (s1 == "Sobe")  && (tipo2 == Rampa Sul)   && (s2 == "Desce") && (a == b) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Sul)   && (s1 == "Sobe")  && (tipo2 == Rampa Norte) && (s2 == "Desce") && (a == b) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Norte) && (s1 == "Desce") && (tipo2 == Rampa Sul)   && (s2 == "Sobe")  && (a == b) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Sul)   && (s1 == "Desce") && (tipo2 == Rampa Norte) && (s2 == "Sobe")  && (a == b) = verificaAltura (((Peca tipo2 b),s2):t) 

                                                           | (tipo2 == Rampa Norte) && (s2 == "Sobe")  && (s1 == "Neutro") && (a == b)   = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo2 == Rampa Sul)   && (s2 == "Sobe")  && (s1 == "Neutro") && (a == b)   = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo2 == Rampa Norte) && (s2 == "Desce") && (s1 == "Neutro") && (a == b+1) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo2 == Rampa Sul)   && (s2 == "Desce") && (s1 == "Neutro") && (a == b+1) = verificaAltura (((Peca tipo2 b),s2):t)

                                                           | (tipo1 == Rampa Oeste) && (s1 == "Sobe")  && (s2 == "Neutro") && (a == b-1) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Este)  && (s1 == "Sobe")  && (s2 == "Neutro") && (a == b-1) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Oeste) && (s1 == "Desce") && (s2 == "Neutro") && (a == b)   = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Este)  && (s1 == "Desce") && (s2 == "Neutro") && (a == b)   = verificaAltura (((Peca tipo2 b),s2):t)

                                                           | (tipo1 == Rampa Oeste) && (s1 == "Sobe")  && (tipo2 == Rampa Oeste) && (s2 == "Sobe")  && (a == b-1) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Este)  && (s1 == "Sobe")  && (tipo2 == Rampa Este)  && (s2 == "Sobe")  && (a == b-1) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Oeste) && (s1 == "Desce") && (tipo2 == Rampa Oeste) && (s2 == "Desce") && (a == b+1) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Este)  && (s1 == "Desce") && (tipo2 == Rampa Este)  && (s2 == "Desce") && (a == b+1) = verificaAltura (((Peca tipo2 b),s2):t)

                                                           | (tipo1 == Rampa Oeste) && (s1 == "Sobe")  && (tipo2 == Rampa Oeste) && (s2 == "Desce") && (a == b) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Este)  && (s1 == "Sobe")  && (tipo2 == Rampa Este)  && (s2 == "Desce") && (a == b) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Oeste) && (s1 == "Desce") && (tipo2 == Rampa Oeste) && (s2 == "Sobe")  && (a == b) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo1 == Rampa Este)  && (s1 == "Desce") && (tipo2 == Rampa Este)  && (s2 == "Sobe")  && (a == b) = verificaAltura (((Peca tipo2 b),s2):t)

                                                           | (tipo2 == Rampa Oeste) && (s2 == "Sobe")  && (s1 == "Neutro") && (a == b)   = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo2 == Rampa Este)  && (s2 == "Sobe")  && (s1 == "Neutro") && (a == b)   = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo2 == Rampa Oeste) && (s2 == "Desce") && (s1 == "Neutro") && (a == b+1) = verificaAltura (((Peca tipo2 b),s2):t)
                                                           | (tipo2 == Rampa Este)  && (s2 == "Desce") && (s1 == "Neutro") && (a == b+1) = verificaAltura (((Peca tipo2 b),s2):t) 

                                                           | (s2 == "Neutro")  && (s1 == "Neutro") && (a == b) = verificaAltura (((Peca tipo2 b),s2):t)
                                                            
                                                           | otherwise = False



{-| A função 'verificaAltura2' verifica se as alturas da primeira e última peças são compatíveis.

  == Exemplos de utilização:

       >>> verificaAltura2 ((Peca (Rampa Norte) 0),"Sobe") ((Peca Recta 1),"Neutro")
       True

       >>> verificaAltura2 ((Peca (Curva Sul) 0),"Neutro") ((Peca Recta 2),"Neutro") 
      False
-}

verificaAltura2 :: (Peca,String) -- ^ última peça do percuso e a respetiva indicação se sobe, desce ou mantém a altura
                -> (Peca,String) -- ^ primeira peça do percuso e a respetiva indicação e sobe, desce ou mantém a altura
                -> Bool          -- ^ valor lógico ( True -> a primeira e última peça têm alturas compatíveis )

verificaAltura2 (Peca tipoL a,sL) (Peca tipo1 b,s1)   | (tipoL == Rampa Norte) && (sL == "Sobe")  && (s1 == "Neutro") && (a == b-1) = True
                                                      | (tipoL == Rampa Sul)   && (sL == "Sobe")  && (s1 == "Neutro") && (a == b-1) = True
                                                      | (tipoL == Rampa Norte) && (sL == "Desce") && (s1 == "Neutro") && (a == b)   = True
                                                      | (tipoL == Rampa Sul)   && (sL == "Desce") && (s1 == "Neutro") && (a == b)   = True

                                                      | (tipoL == Rampa Norte) && (sL == "Sobe")  && (tipo1 == Rampa Norte) && (s1 == "Sobe")  && (a == b-1) = True
                                                      | (tipoL == Rampa Sul)   && (sL == "Sobe")  && (tipo1 == Rampa Sul)   && (s1 == "Sobe")  && (a == b-1) = True
                                                      | (tipoL == Rampa Norte) && (sL == "Desce") && (tipo1 == Rampa Norte) && (s1 == "Desce") && (a == b+1) = True
                                                      | (tipoL == Rampa Sul)   && (sL == "Desce") && (tipo1 == Rampa Sul)   && (s1 == "Desce") && (a == b+1) = True

                                                      | (tipoL == Rampa Norte) && (sL == "Sobe")  && (tipo1 == Rampa Sul)   && (s1 == "Desce") && (a == b) = True
                                                      | (tipoL == Rampa Sul)   && (sL == "Sobe")  && (tipo1 == Rampa Norte) && (s1 == "Desce") && (a == b) = True
                                                      | (tipoL == Rampa Norte) && (sL == "Desce") && (tipo1 == Rampa Sul)   && (s1 == "Sobe")  && (a == b) = True
                                                      | (tipoL == Rampa Sul)   && (sL == "Desce") && (tipo1 == Rampa Norte) && (s1 == "Sobe")  && (a == b) = True

                                                      | (tipo1 == Rampa Norte) && (s1 == "Sobe")  && (sL == "Neutro") && (a == b)   = True
                                                      | (tipo1 == Rampa Sul)   && (s1 == "Sobe")  && (sL == "Neutro") && (a == b)   = True
                                                      | (tipo1 == Rampa Norte) && (s1 == "Desce") && (sL == "Neutro") && (a == b+1) = True
                                                      | (tipo1 == Rampa Sul)   && (s1 == "Desce") && (sL == "Neutro") && (a == b+1) = True

                                                      | (tipoL == Rampa Oeste) && (sL == "Sobe")  && (s1 == "Neutro") && (a == b-1) = True
                                                      | (tipoL == Rampa Este)  && (sL == "Sobe")  && (s1 == "Neutro") && (a == b-1) = True
                                                      | (tipoL == Rampa Oeste) && (sL == "Desce") && (s1 == "Neutro") && (a == b)   = True
                                                      | (tipoL == Rampa Este)  && (sL == "Desce") && (s1 == "Neutro") && (a == b)   = True

                                                      | (tipoL == Rampa Oeste) && (sL == "Sobe")  && (tipo1 == Rampa Oeste) && (s1 == "Sobe")  && (a == b-1) = True
                                                      | (tipoL == Rampa Este)  && (sL == "Sobe")  && (tipo1 == Rampa Este)  && (s1 == "Sobe")  && (a == b-1) = True
                                                      | (tipoL == Rampa Oeste) && (sL == "Desce") && (tipo1 == Rampa Oeste) && (s1 == "Desce") && (a == b+1) = True
                                                      | (tipoL == Rampa Este)  && (sL == "Desce") && (tipo1 == Rampa Este)  && (s1 == "Desce") && (a == b+1) = True

                                                      | (tipoL == Rampa Oeste) && (sL == "Sobe")  && (tipo1 == Rampa Oeste) && (s1 == "Desce") && (a == b) = True
                                                      | (tipoL == Rampa Este)  && (sL == "Sobe")  && (tipo1 == Rampa Este)  && (s1 == "Desce") && (a == b) = True
                                                      | (tipoL == Rampa Oeste) && (sL == "Desce") && (tipo1 == Rampa Oeste) && (s1 == "Sobe")  && (a == b) = True
                                                      | (tipoL == Rampa Este)  && (sL == "Desce") && (tipo1 == Rampa Este)  && (s1 == "Sobe")  && (a == b) = True

                                                      | (tipo1 == Rampa Oeste) && (s1 == "Sobe")  && (sL == "Neutro") && (a == b)   = True
                                                      | (tipo1 == Rampa Este)  && (s1 == "Sobe")  && (sL == "Neutro") && (a == b)   = True
                                                      | (tipo1 == Rampa Oeste) && (s1 == "Desce") && (sL == "Neutro") && (a == b+1) = True
                                                      | (tipo1 == Rampa Este)  && (s1 == "Desce") && (sL == "Neutro") && (a == b+1) = True

                                                      | (sL == "Neutro")  && (s1 == "Neutro") && (a == b) = True
                                                            
                                                      | otherwise = False
                                                                                         

