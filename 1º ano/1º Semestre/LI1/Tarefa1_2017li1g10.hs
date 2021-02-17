{-|
Module : Tarefa1_2017li1g10
Description : Módulo Haskell contendo a 1ª Tarefa da 1ª Fase do Projeto "Micro Machines" de Laboratórios de Informática 1
Copyright: João Manuel da Costa Ferraz Soares <a77841@alunos.uminho.pt>;
           Filipa Alves dos Santos <a83631@alunos.uminho.pt>
-}

module Tarefa1_2017li1g10 where

import LI11718



{-| A função 'testesT1' dá vários exemplos de caminhos possíveis.

-}

testesT1 :: [Caminho] -- ^ lista de exemplos de caminhos
testesT1 = [[],
            [Avanca,Avanca, Avanca],
            [Avanca,Desce,Desce,Sobe,Sobe,Avanca],
            [Avanca,Avanca,CurvaDir,Avanca,CurvaEsq,CurvaDir,CurvaDir,Avanca,Avanca,CurvaDir,CurvaEsq,CurvaDir,Avanca,CurvaDir],
            [Avanca,Avanca,CurvaDir,Sobe,CurvaDir,Sobe,Avanca,Desce,CurvaDir,Desce,CurvaDir,Avanca],
            [Avanca,CurvaDir,CurvaEsq,CurvaDir,CurvaDir,Avanca,CurvaEsq,CurvaDir,CurvaDir,Avanca,Avanca,CurvaDir],
            [CurvaDir,CurvaEsq,Avanca,CurvaEsq,CurvaDir,CurvaDir,Avanca,Avanca,CurvaDir,CurvaEsq,CurvaDir,Avanca,CurvaDir,CurvaEsq,CurvaDir,Avanca,Avanca,CurvaDir]]



{-| A função 'constroi' cria um mapa correspondente ao caminho dado.

  == Exemplos de utilização:

       >>> constroi [CurvaDir,CurvaEsq,Avanca,CurvaEsq,CurvaDir,CurvaDir,Avanca,Avanca,CurvaDir,CurvaEsq,CurvaDir,Avanca,CurvaDir,CurvaEsq,CurvaDir,Avanca,Avanca,CurvaDir]
       Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0         ,Peca Lava 0         ,Peca Lava 0 ,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0],
                          [Peca Lava 0,Peca (Curva Norte) 0,Peca (Curva Este) 0 ,Peca Lava 0 ,Peca (Curva Norte) 0,Peca (Curva Este) 0,Peca Lava 0],
                          [Peca Lava 0,Peca Recta 0        ,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0  ,Peca Recta 0       ,Peca Lava 0],
                          [Peca Lava 0,Peca Recta 0        ,Peca Lava 0         ,Peca Lava 0 ,Peca Lava 0         ,Peca Recta 0       ,Peca Lava 0],
                          [Peca Lava 0,Peca (Curva Oeste) 0,Peca (Curva Este) 0 ,Peca Lava 0 ,Peca (Curva Norte) 0,Peca (Curva Sul) 0 ,Peca Lava 0],
                          [Peca Lava 0,Peca Lava 0         ,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0  ,Peca Lava 0        ,Peca Lava 0],
                          [Peca Lava 0,Peca Lava 0         ,Peca Lava 0         ,Peca Lava 0 ,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0]]

       >>> constroi [Avanca,CurvaDir,CurvaEsq,CurvaDir,CurvaDir,Avanca,CurvaEsq,CurvaDir,CurvaDir,Avanca,Avanca,CurvaDir]
       Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0         ,Peca Lava 0         ,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0],
                          [Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0        ,Peca (Curva Este) 0 ,Peca Lava 0        ,Peca Lava 0],
                          [Peca Lava 0,Peca Recta 0        ,Peca Lava 0         ,Peca (Curva Oeste) 0,Peca (Curva Este) 0,Peca Lava 0],
                          [Peca Lava 0,Peca Recta 0        ,Peca (Curva Norte) 0,Peca Recta 0        ,Peca (Curva Sul) 0 ,Peca Lava 0],
                          [Peca Lava 0,Peca (Curva Oeste) 0,Peca (Curva Sul) 0  ,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0],
                          [Peca Lava 0,Peca Lava 0         ,Peca Lava 0         ,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0]]
-}

constroi :: Caminho -- ^ caminho dado
         -> Mapa    -- ^ mapa resultante do caminho

constroi c = Mapa ((partida c),Este) ((constroiTab (fillWithLava c) c (0,0) (partida c) Este 0 (dimensao c)))

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

{-| A função 'constroiTab' faz o mesmo que a função constroiTabAux, apenas está escrita de maneira mais simples e com dados mais específicos.

  == Exemplos de utilização:

       >>> constroiTab [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  [Avanca,CurvaDir,Sobe,CurvaDir,Avanca,CurvaDir,Desce,CurvaDir]  (0,0)  (2,1)  Este  0  (5,5)
       [[Peca Lava 0,Peca Lava 0         ,Peca Lava 0 ,Peca Lava 0        ,Peca Lava 0],
        [Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],
        [Peca Lava 0,Peca (Rampa Sul) 0  ,Peca Lava 0 ,Peca (Rampa Sul) 0 ,Peca Lava 0],
        [Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0 ,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0         ,Peca Lava 0 ,Peca Lava 0        ,Peca Lava 0]]

       >>> constroiTab [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  [Avanca,Avanca,Avanca]  (0,0)  (1,1)  Este  0  (6,3)
       [[Peca Lava 0,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0 ,Peca Lava 0,Peca Lava 0]]
-}

constroiTab :: Tabuleiro   -- ^ tabuleiro onde se vai colocar as peças correspondentes ao caminho
            -> Caminho     -- ^ caminho dado
            -> Posicao     -- ^ (0,0)
            -> Posicao     -- ^ posição inicial
            -> Orientacao  -- ^ orientação inicial
            -> Altura      -- ^ altura inicial
            -> Dimensao    -- ^ dimensão do tabuleiro
            -> Tabuleiro   -- ^ tabuleiro resultante de colocar as peças correspondentes ao caminho

constroiTab [] _ _ _ _ _ _        = []

constroiTab tab [] _ _ _ _ _      = tab

constroiTab tab (h:t) p1 p2 o a d = constroiTabAux (tab) (dimensao (h:t)) (h:t) p1 p2 o a d



{-| A função 'constroiTabAux' devolve um tabuleiro correspondente ao caminho dado.

  == Exemplos de utilização:

       >>> constroiTabAux  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  (9,3)  [Avanca,Desce,Desce,Sobe,Sobe,Avanca]  (0,0)  (1,1)  Este  0  (9,3)
       [[Peca Lava 0,Peca Lava 0 ,Peca Lava 0            ,Peca Lava 0            ,Peca Lava 0           ,Peca Lava 0           ,Peca Lava 0 ,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Recta 0,Peca (Rampa Oeste) (-1),Peca (Rampa Oeste) (-2),Peca (Rampa Este) (-2),Peca (Rampa Este) (-1),Peca Recta 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0 ,Peca Lava 0            ,Peca Lava 0            ,Peca Lava 0           ,Peca Lava 0           ,Peca Lava 0 ,Peca Lava 0,Peca Lava 0]]

       >>> constroiTabAux  [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  (7,6) [Avanca,Avanca,CurvaDir,Avanca,CurvaEsq,CurvaDir,CurvaDir,Avanca,Avanca,CurvaDir,CurvaEsq,CurvaDir,Avanca,CurvaDir]  (0,0)  (2,1)  Este  0  (7,6)  
       [[Peca Lava 0,Peca Lava 0         ,Peca Lava 0         ,Peca Lava 0 ,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0],
        [Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0        ,Peca Recta 0,Peca (Curva Este) 0 ,Peca Lava 0        ,Peca Lava 0],
        [Peca Lava 0,Peca Recta 0        ,Peca Lava 0         ,Peca Lava 0 ,Peca Recta 0        ,Peca Lava 0        ,Peca Lava 0],
        [Peca Lava 0,Peca (Curva Oeste) 0,Peca (Curva Este) 0 ,Peca Lava 0 ,Peca (Curva Oeste) 0,Peca (Curva Este) 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0         ,Peca (Curva Oeste) 0,Peca Recta 0,Peca Recta 0        ,Peca (Curva Sul) 0 ,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0         ,Peca Lava 0         ,Peca Lava 0 ,Peca Lava 0         ,Peca Lava 0        ,Peca Lava 0]]  
-}

constroiTabAux :: Tabuleiro   -- ^ tabuleiro onde se vai colocar as peças correspondentes ao caminho
               -> Dimensao    -- ^ dimensao do tabuleiro
               -> Caminho     -- ^ caminho dado
               -> Posicao     -- ^ (0,0)
               -> Posicao     -- ^ posição inicial
               -> Orientacao  -- ^ orientação inicial
               -> Altura      -- ^ altura inicial
               -> Dimensao    -- ^ dimensão do tabuleiro
               -> Tabuleiro   -- ^ tabuleiro resultante de colocar as peças correspondentes ao caminho

constroiTabAux [] _ _ _ _ _ _ _        = []

constroiTabAux tab _ [] _ _ _ _ _      = tab

constroiTabAux tab c (h:t) p1 p2 o a d = constroiTabAux (groupByDimension (setPeca h tab p1 p2 o a d) (c)) c t p1 (nextPosPeca h p2 o) (nextOrient h o) (nextAltura (h:t) a) d



{-| A função 'setPeca' coloca uma peça (com determinada altura e orientação) na sua respetiva posição num tabuleiro.

  == Exemplos de utilização:

       >>> setPeca Avanca [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  (0,0)  (3,2)  Este  0  (7,6)
       [[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0] ,[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],
        [Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0] ,[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],
        [Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Recta 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],
        [Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0] ,[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],
        [Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0] ,[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],
        [Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0] ,[Peca Lava 0],[Peca Lava 0],[Peca Lava 0]]

       >>> setPeca CurvaDir [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]  (0,0)  (2,3)  Oeste  1  (5,5)
       [[Peca Lava 0],[Peca Lava 0],[Peca Lava 0]         ,[Peca Lava 0]        ,[Peca Lava 0],
        [Peca Lava 0],[Peca Lava 0],[Peca Recta 0]        ,[Peca (Curva Este) 0],[Peca Lava 0],
        [Peca Lava 0],[Peca Lava 0],[Peca Lava 0]         ,[Peca (Rampa Sul) 0] ,[Peca Lava 0],
        [Peca Lava 0],[Peca Lava 0],[Peca (Curva Oeste) 1],[Peca (Curva Sul) 1] ,[Peca Lava 0],
        [Peca Lava 0],[Peca Lava 0],[Peca Lava 0]         ,[Peca Lava 0]        ,[Peca Lava 0]]
  
-}

setPeca :: Passo       -- ^ passo cuja peça correspondente é suposto ser colocada no tabuleiro
        -> Tabuleiro   -- ^ tabuleiro inicial
        -> Posicao     -- ^ (0,0)
        -> Posicao     -- ^ posição inicial
        -> Orientacao  -- ^ orientação do caminho no passo dado
        -> Altura      -- ^ altura da peça correspondente ao passo dado
        -> Dimensao    -- ^ dimensão do tabuleiro
        -> Tabuleiro   -- ^ tabuleiro resultante de colocar a peça correspondente ao passo no tabuleiro inicial

setPeca _ [] _ _ _ _ _                      = []

setPeca passo ([]:z) (x,y) (x2,y2) o r d    = setPeca passo (z) (0,y+1) (x2,y2) o r d
 
setPeca passo ((a:b):z) (x,y) (x2,y2) o r d |(x,y) /= (x2,y2) && x <  fst d = [a] : setPeca passo ((b):z) (x+1,y) (x2,y2) o r d
                                            |(x,y) /= (x2,y2) && x >= fst d = [a] : setPeca passo ((b):z) (0,y+1) (x2,y2) o r d
                                            |(x,y) == (x2,y2) && x <  fst d = [(passoToPeca passo o r)] : setPeca passo ((b):z) (x+1,y) (x2,y2) o r d
                                            |(x,y) == (x2,y2) && x >= fst d = [(passoToPeca passo o r)] : setPeca passo (z) (0,y+1) (x2,y2) o r d
                                            


{-| A função 'passToPeca' converte um passo para peça.

   == Exemplos de utilização:

       >>> passoToPeca Avanca Norte 0  
       Peca Recta 0

       >>> passoToPeca CurvaDir Este 1
       Peca (Curva Este) 1

       >>> passoToPeca Sobe Sul 0
       Peca (Rampa Sul) 0
-}

passoToPeca :: Passo       -- ^ passo dado
            -> Orientacao  -- ^ orientação do caminho no passo dado
            -> Altura      -- ^ altura da peça correspondente ao passo dado
            -> Peca        -- ^ peça correspondente ao passo dado
 
passoToPeca p o h | p == Avanca   &&(o == Norte || o == Sul || o == Este || o == Oeste) = Peca Recta h
                  | p == CurvaDir && o == Norte = Peca (Curva Norte) h
                  | p == CurvaDir && o == Sul   = Peca (Curva Sul) h
                  | p == CurvaDir && o == Este  = Peca (Curva Este) h
                  | p == CurvaDir && o == Oeste = Peca (Curva Oeste) h
                  | p == CurvaEsq && o == Norte = Peca (Curva Este) h
                  | p == CurvaEsq && o == Sul   = Peca (Curva Oeste) h
                  | p == CurvaEsq && o == Este  = Peca (Curva Sul) h
                  | p == CurvaEsq && o == Oeste = Peca (Curva Norte) h
                  | p == Sobe     && o == Norte = Peca (Rampa Norte) h
                  | p == Sobe     && o == Sul   = Peca (Rampa Sul) h
                  | p == Sobe     && o == Este  = Peca (Rampa Este) h
                  | p == Sobe     && o == Oeste = Peca (Rampa Oeste) h
                  | p == Desce    && o == Norte = Peca (Rampa Sul) (h-1)
                  | p == Desce    && o == Sul   = Peca (Rampa Norte) (h-1)
                  | p == Desce    && o == Este  = Peca (Rampa Oeste) (h-1)
                  | p == Desce    && o == Oeste = Peca (Rampa Este) (h-1)



{-| A função 'nextAltura' devolve a altura da peça seguinte.

   == Exemplos de utilização:

       >>> nextAltura Avanca 1
       1

       >>> nextAltura Sobe 0 
       1

       >>> nextAltura Desce 1
       0
-}

nextAltura :: Caminho -- ^ caminho dado
           -> Altura  -- ^ altura inicial
           -> Altura  -- ^ altura seguinte  

nextAltura (p:t) h | p == Sobe = h+1
                   | p == Desce = h-1
                   | otherwise = h



{-| A função 'nextPosPeca' retorna a próxima posição.

   == Exemplos de utilização:

       >>> nextPosPeca Avanca (1,1) Sul
       (1,2)

       >>> nextPosPeca Sobe (1,1) Este
       (2,1)

       >>> nextPosPeca CurvaDir (1,1) Oeste
       (1,0)
-}

nextPosPeca :: Passo      -- ^ passo inicial
            -> Posicao    -- ^ posição inicial
            -> Orientacao -- ^ orientação inicial
            -> Posicao    -- ^ posição seguinte

nextPosPeca p (x,y) o | p == Avanca   && o == Norte = (x,y-1)
                      | p == Avanca   && o == Sul   = (x,y+1)
                      | p == Avanca   && o == Este  = (x+1,y)
                      | p == Avanca   && o == Oeste = (x-1,y)
                      | p == CurvaDir && o == Norte = (x+1,y)
                      | p == CurvaDir && o == Sul   = (x-1,y)
                      | p == CurvaDir && o == Este  = (x,y+1)
                      | p == CurvaDir && o == Oeste = (x,y-1)
                      | p == CurvaEsq && o == Norte = (x-1,y)
                      | p == CurvaEsq && o == Sul   = (x+1,y)
                      | p == CurvaEsq && o == Este  = (x,y-1)
                      | p == CurvaEsq && o == Oeste = (x,y+1)
                      | p == Sobe     && o == Norte = (x,y-1)
                      | p == Sobe     && o == Sul   = (x,y+1)
                      | p == Sobe     && o == Este  = (x+1,y)
                      | p == Sobe     && o == Oeste = (x-1,y)
                      | p == Desce    && o == Norte = (x,y-1)
                      | p == Desce    && o == Sul   = (x,y+1)
                      | p == Desce    && o == Este  = (x+1,y)
                      | p == Desce    && o == Oeste = (x-1,y)



{-| A função 'nextOrient' devolve a orientação seguinte do percurso.

   == Exemplos de utilização:

       >>> nextOrient Avanca Norte   
       Norte

       >>> nextOrient CurvaDir Este 
       Sul

       >>> nextOrient CurvaEsq Norte
       Oeste  
-}

nextOrient :: Passo      -- ^ passo inicial    
           -> Orientacao -- ^ orientação inicial
           -> Orientacao -- ^ orientação seguinte

nextOrient p o | p == Avanca   && o == Norte = Norte
               | p == Avanca   && o == Sul   = Sul
               | p == Avanca   && o == Este  = Este
               | p == Avanca   && o == Oeste = Oeste
               | p == CurvaDir && o == Norte = Este
               | p == CurvaDir && o == Sul   = Oeste
               | p == CurvaDir && o == Este  = Sul
               | p == CurvaDir && o == Oeste = Norte
               | p == CurvaEsq && o == Norte = Oeste
               | p == CurvaEsq && o == Sul   = Este
               | p == CurvaEsq && o == Este  = Norte
               | p == CurvaEsq && o == Oeste = Sul
               | p == Sobe     && o == Norte = Norte
               | p == Sobe     && o == Sul   = Sul
               | p == Sobe     && o == Este  = Este
               | p == Sobe     && o == Oeste = Oeste
               | p == Desce    && o == Norte = Norte
               | p == Desce    && o == Sul   = Sul
               | p == Desce    && o == Este  = Este
               | p == Desce    && o == Oeste = Oeste



{-| A função 'fillWithLava' constroi um tabuleiro constituído apenas por apenas peça do tipo lava organizado por filas e colunas e com peças suficientes para depois serem colocadas as 
peças correspondentes ao caminho dado.

  == Exemplos de utilização:

       >>> fillWithLava ​[Avanca,CurvaDir,Sobe,CurvaDir,Avanca,CurvaDir,Desce,CurvaDir]
       [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]

       >>> fillWithLava [Avanca]
       [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
-}

fillWithLava :: Caminho   -- ^ caminho dado
             -> Tabuleiro -- ^ tabuleiro de lava de dimensões adaptadas ao caminho dado

fillWithLava c = groupByDimension (fillWithLavaAux (dimensao c)) (dimensao c)



{-| A função 'fillWithLavaAux' utiliza a 'fillWithLavaAux2' e dá-lhe o número de peças que vão existir no tabuleiro.

  == Exemplos de utilização:

       >>> fillWithLavaAux (2,2)
       [[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0]]

       >>> fillWithLavaAux (3,1)
       [[Peca Lava 0],[Peca Lava 0],[Peca Lava 0]]    
-}

fillWithLavaAux :: Dimensao  -- ^ dimensão de um tabuleiro
                -> Tabuleiro -- ^ tabuleiro de lava com um número de peças necessárias de acordo com a dimensão

fillWithLavaAux (x,y) = fillWithLavaAux2 (x*y)



{-| A função 'fillWithLavaAux2' cria um tabuleiro com um determinado número de peças de tipo lava.

  == Exemplos de utilização:

       >>> fillWithLavaAux2 3 
       [[Peca Lava 0],[Peca Lava 0],[Peca Lava 0]]

       >>> fillWithLavaAux2 0
       []
-}

fillWithLavaAux2 :: Int       -- ^ número de peças de peças do tabuleiro
                 -> Tabuleiro -- ^ tabuleiro de lava com um número de peças dado

fillWithLavaAux2 c = if(c>0) then [Peca (Lava) 0] : fillWithLavaAux2 (c-1)
                             else []



{-| A função 'groupByDimension' organiza um tabuleiro por filas de acordo com a sua dimensão.
 
  == Exemplos de utilização:

       >>> groupByDimension [[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0]] (4,4)
       [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]

       >>> groupByDimension [[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0],[Peca Lava 0]] (2,3)
       [[Peca Lava 0,Peca Lava 0,Peca Lava 0],
        [Peca Lava 0,Peca Lava 0,Peca Lava 0]]       
-}

groupByDimension :: Tabuleiro -- ^ tabuleiro inicial
                 -> Dimensao  -- ^ dimensão do tabuleiro inicial
                 -> Tabuleiro -- ^ tabuleiro organizado por filas de acordo com a dimensão dada

groupByDimension [] _ = []
groupByDimension l (x,y) = (concat(take x l)) : groupByDimension (drop x l) (x,y)

