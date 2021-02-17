{-|
Module : Tarefa6_2017li1g10
Description : Módulo Haskell contendo a 6ª Tarefa da 2ª Fase do Projeto "Micro Machines" de Laboratórios de Informática 1
Copyright: João Manuel da Costa Ferraz Soares <a77841@alunos.uminho.pt>;
           Filipa Alves dos Santos <a83631@alunos.uminho.pt>
-}

module Tarefa6_2017li1g10 where

import LI11718

{-| A função 'bot' é usada para simular um /bot/ no jogo /Micro Machines/.Em cada instante, dado o tempo decorrido, o estado do jogo e o identificador do jogador, toma uma ação. 

 == Exemplos de utilização:

       >>> bot 1 (Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0, k_pneus = 0, k_acel = 0.5, k_peso = 0, k_nitro = 0, k_roda = 10}, carros = [Carro {posicao = (3.5,1.5), direcao = 0, velocidade = (0.5,0.5)}], nitros  = [5] , historico  = [[(2,1)]] }) 0
       Acao {acelerar = True, travar = False, esquerda = False, direita = False, nitro = Nothing}    
-}

bot :: Tempo  -- ^ tempo decorrido desde a última decisão
    -> Jogo   -- ^ estado atual do jogo
    -> Int    -- ^ identificador do jogador dentro do estado
    -> Acao   -- ^ a decisão tomada pelo /bot/
    
bot tick (Jogo (Mapa p tab) pi ((Carro pos d v):cs) n h) j = botAux (convertePos pos) (pecaPosicao (convertePos pos) tab) (escolheCarro ((Carro pos d v):cs) j) (escolheHistorico h j)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

 {-| A função 'botAux' verifica se a peça da posição atual do carro do jogador em questão é uma curva ou se é outro tipo qualquer de peça, dependendo assim a ação tomada pelo bot.

  == Exemplos de utilização:

       >>> botAux (2,1) (Peca (Curva Este) 0) (Carro {posicao = (2.1,1.1), direcao = 0, velocidade = (0.5,0)}) [(1,1),(2,1)]
       Acao {acelerar = True, travar = False, esquerda = False, direita = False, nitro = Nothing}
-}

botAux :: Posicao   -- ^ posição atual do carro
       -> Peca      -- ^ peça atual do carro
       -> Carro     -- ^ carro do jogador em questão
       -> [Posicao] -- ^ histórico das posições do jogador em questão
       -> Acao      -- ^ a decisão tomada pelo /bot/

botAux p (Peca (Rampa o) a) c h = mudarRampa (verificaPosAnt p h) p (Peca (Rampa o) a) c
botAux p _ _ _ =  (Acao True False False False Nothing) 



 {-| A função 'mudarRampa' determina para que lado rodar, dependendo da orientação do caminho (dada peça posição anterior) e do tipo de rampa.

  == Exemplos de utilização:

       >>> mudarRampa (1,1) (2,1) (Peca (Curva Este) 0) (Carro {posicao = (2.1,1.1), direcao = 0, velocidade = (0.5,0)})
       Acao {acelerar = False, travar = False, esquerda = False, direita = True, nitro = Nothing}
-}

mudarRampa :: Posicao -- ^ posição anterior do percurso
           -> Posicao -- ^ posição atual do carro
           -> Peca    -- ^ peça atual do carro
           -> Carro   -- ^ carro do jogador em questão
           -> Acao    -- ^ a decisão tomada pelo /bot/

mudarRampa (x1,y1) (x,y) (Peca (Curva Este) a) (Carro pos d v) | ((x-1,y) == (x1,y1)) && (d > 270) && (d <= 360) = (Acao False False False True Nothing) 
                                                               | ((x-1,y) == (x1,y1)) && (d == 270)              = (Acao True False False False Nothing) 
                                                               | ((x,y+1) == (x1,y1)) && (d >= 90) && (d < 180)  = (Acao False False True False Nothing) 
                                                               | ((x,y+1) == (x1,y1)) && (d == 180)              = (Acao True False False False Nothing) 

mudarRampa (x1,y1) (x,y) (Peca (Curva Oeste) a) (Carro pos d v) | ((x+1,y) == (x1,y1)) && (d > 90) && (d <= 180)  = (Acao False False False True Nothing) 
                                                                | ((x-1,y) == (x1,y1)) && (d == 90)               = (Acao True False False False Nothing) 
                                                                | ((x,y-1) == (x1,y1)) && (d >= 270) && (d < 360) = (Acao False False True False Nothing) 
                                                                | ((x,y-1) == (x1,y1)) && (d == 360)              = (Acao True False False False Nothing) 

mudarRampa (x1,y1) (x,y) (Peca (Curva Norte) a) (Carro pos d v) | ((x,y+1) == (x1,y1)) && (d <= 90) && (d > 0)    = (Acao False False False True Nothing) 
                                                                | ((x,y+1) == (x1,y1)) && (d == 360)              = (Acao True False False False Nothing) 
                                                                | ((x+1,y) == (x1,y1)) && (d >= 180) && (d < 270) = (Acao False False True False Nothing) 
                                                                | ((x+1,y) == (x1,y1)) && (d == 270)              = (Acao True False False False Nothing) 

mudarRampa (x1,y1) (x,y) (Peca (Curva Sul) a) (Carro pos d v)  | ((x,y-1) == (x1,y1)) && (d <= 270) && (d > 180)                 = (Acao False False False True Nothing) 
                                                               | ((x,y-1) == (x1,y1)) && (d == 180)                              = (Acao True False False False Nothing) 
                                                               | ((x-1,y) == (x1,y1)) && ((d == 360) || ((d > 0) && (d < 90)))   = (Acao False False True False Nothing) 
                                                               | ((x-1,y) == (x1,y1)) && (d == 90)                               = (Acao True False False False Nothing) 



{-| A função 'simplificaGrau' simplifica qualquer grau para que fique no intervalo [0,360].

  == Exemplos de utilização:

       >>> simplificaGrau (-90)
       270
-}

simplificaGrau :: Angulo -- ^ ângulo dado (em graus)
               -> Angulo -- ^ ângulo simplificado correspondente ao ângulo dado

simplificaGrau g | g <= -360 = simplificaGrau (g + 360)
                 | g >= 360  = simplificaGrau (g - 360)
                 | (g > 0) && (g < 360)  = g
                 | (g <= 0)  && (g > -360) = g + 360


                                                
 {-| A função 'verificaPosAnt' dá a posição anterior à posição correspondente à rampa em questão.


  == Exemplos de utilização:

       >>> verificaPosAnt (1,1) [(1,1),(1,0)]
      (1,0)
-}

verificaPosAnt :: Posicao   -- ^ posição atual
               -> [Posicao] -- ^ histórico das posições
               -> Posicao   -- ^ posição anterior à atual

verificaPosAnt p (h:t) | p == h = (head t)
                       | otherwise = p 

  

{-| A função 'escolheCarro' escolhe o carro correspondente ao jogador que realiza a ação.

  == Exemplos de utilização:

       >>> escolheCarro [(Carro (1,1) 45 (1,1))] 0
       Carro {posicao = (1.0,1.0), direcao = 45.0, velocidade = (1.0,1.0)} 
-}

escolheCarro :: [Carro] -- ^ lista de carros do jogo
             -> Int     -- ^ identificador do jogador
             -> Carro   -- ^ carro corresppondente ao jogador em questão

escolheCarro (c:cs) j | j == 0 = c
                      | otherwise = escolheCarro cs (j-1)



{-| A função 'escolheHistorico' escolhe o carro correspondente ao jogador que realiza a ação.

  == Exemplos de utilização:

       >>> escolheHistorico [[],[(1,2)]] 0
       []
-}

escolheHistorico :: [[Posicao]] -- ^ lista dos históricos das posições do jogo
                 -> Int         -- ^ identificador do jogo
                 -> [Posicao]   -- ^ histórico do jogador em questão

escolheHistorico (h:t) j | j == 0 = h
                         | otherwise = escolheHistorico t (j-1)



{-| A função 'convertePos' indica a posição correspondente ao ponto dado.

  == Exemplos de utilização:

       >>>  convertePos (2.01,1.01)
       (2,1)
-}

convertePos :: Ponto   -- ^ ponto dado
            -> Posicao -- ^ posição correspondente ao ponto dado

convertePos (a,b) = (floor a, floor b)



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
-}

pecaPosicaoAux2 :: Posicao   -- ^ posição dada
                -> Tabuleiro -- ^ tabuleiro dado
                -> [Peca]    -- ^ lista de peças do tabuleiro dado em que a peça correspondente à posição dada se encontra

pecaPosicaoAux2 (x,0) (h:t) = h
pecaPosicaoAux2 (x,y) (h:t) = pecaPosicaoAux2 (x,y-1) t




