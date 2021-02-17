{-|
Module : Tarefa4_2017li1g10
Description : Módulo Haskell contendo a 4ª Tarefa da 2ª Fase do Projeto "Micro Machines" de Laboratórios de Informática 1
Copyright: João Manuel da Costa Ferraz Soares <a77841@alunos.uminho.pt>;
           Filipa Alves dos Santos <a83631@alunos.uminho.pt>
-}

module Tarefa4_2017li1g10 where

import LI11718

{-| O testes a serem considerados pelo sistema de /feedback/ para a função 'atualiza'. -}

testesT4 :: [(Tempo,Jogo,Acao)]
testesT4 = [(1,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0, k_pneus = 0, k_acel = 0, k_peso = 0, k_nitro = 0, k_roda = 10}, carros = [Carro {posicao = (2.01,1.01), direcao = 45, velocidade = (0.9,0.9)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = False, travar  = False , esquerda = True, direita  = False, nitro  = Nothing })
            -- verifica a atualização da direção do carro

           ,(1,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0, k_acel = 0, k_peso = 0, k_nitro = 0, k_roda = 0}, carros = [Carro {posicao = (2.01,1.01), direcao = 45, velocidade = (0.5,0.5)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = False, travar  = False , esquerda = False, direita  = False, nitro  = Nothing })
            -- verifica a aplicação do atrito na velocidade do carro

           ,(1,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0, k_pneus = 0, k_acel = 0.5, k_peso = 0, k_nitro = 0, k_roda = 0}, carros = [Carro {posicao = (2.01,1.01), direcao = 45, velocidade = (0.5,0.5)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = False, travar  = False , esquerda = False, direita  = False, nitro  = Nothing })
            -- verifica a aplicação da aceleração/travagem na velocidade do carro
             
           ,(1,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0, k_pneus = 0, k_acel = 0, k_peso = 0, k_nitro = 0.2, k_roda = 0}, carros = [Carro {posicao = (2.01,1.01), direcao = 45, velocidade = (0.5,0.5)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = False, travar  = False , esquerda = False, direita  = False, nitro  = Just 0 })
            -- verifica a aplicação do nitro na velocidade do carro e a atualização dos nitros dos carros
           
           ,(1,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0, k_pneus = 0, k_acel = 0, k_peso = 0.2, k_nitro = 0, k_roda = 0}, carros = [Carro {posicao = (3.5,2.01), direcao = -90, velocidade = (0,0.5)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = False, travar  = False , esquerda = False, direita  = False, nitro  = Nothing })
            -- verifica a aplicação do peso (nas rampas)

           ,(1,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0, k_pneus = 0.2, k_acel = 0, k_peso = 0, k_nitro = 0, k_roda = 0}, carros = [Carro {posicao = (1.5,2.5), direcao = 45, velocidade = (0,-0.3)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = False, travar  = False , esquerda = False, direita  = False, nitro  = Nothing })
            -- verifica a aplicação da força dos pneus 

           ,(1,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.1, k_pneus = 0.1, k_acel = 0.1, k_peso = 0.1, k_nitro = 0.1, k_roda = 10}, carros = [Carro {posicao = (2.01,1.01), direcao = 45, velocidade = (0.2,0.2)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = True, travar  = False , esquerda = True, direita  = False, nitro  = (Just 0) })
           ]
           


{-| A função 'atualiza' o estado do jogo dadas as ações de um jogador num determinado período de tempo, ou seja, faz o mesmo que a 'atualizaAux' mas, está escrita de maneira mais legível.

  == Exemplos de utilização:

       >>>  atualiza 1 (Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0, k_acel = 0, k_peso = 0, k_nitro = 0, k_roda = 0}, carros = [Carro {posicao = (2.01,1.01), direcao = 45, velocidade = (-0.5,0.5)}], nitros  = [5] , historico  = [[]] }) 0  (Acao { acelerar = False, travar  = False , esquerda = False, direita  = False, nitro  = Nothing })
       Jogo {mapa = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades {k_atrito = 0.5, k_pneus = 0.0, k_acel = 0.0, k_peso = 0.0, k_nitro = 0.0, k_roda = 0.0}, carros = [Carro {posicao = (2.01,1.01), direcao = 45.0, velocidade = (-0.25,0.25)}], nitros = [5.0], historico = [[(2,1)]]}
-}

atualiza :: Tempo -- ^ a duração da ação
         -> Jogo  -- ^ o estado do jogo
         -> Int   -- ^ o identificador do jogador
         -> Acao  -- ^ a ação tomada pelo jogador
         -> Jogo  -- ^ o estado atualizado do jogo

atualiza t e j a = atualizaAux t e j a 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

{-| A função 'atualizaAux' o estado do jogo dadas as ações de um jogador num determinado período de tempo. 

  == Exemplos de utilização:

       >>> atualizaAux 1 (Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0, k_pneus = 0, k_acel = 0, k_peso = 0, k_nitro = 0, k_roda = 10}, carros = [Carro {posicao = (2.01,1.01), direcao = 45, velocidade = (0.5,0.5)}], nitros  = [5] , historico  = [[]] }) 0  (Acao { acelerar = False, travar  = False , esquerda = True, direita  = False, nitro  = Nothing })
       Jogo {mapa = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades {k_atrito = 0.0, k_pneus = 0.0, k_acel = 0.0, k_peso = 0.0, k_nitro = 0.0, k_roda = 10.0}, carros = [Carro {posicao = (2.01,1.01), direcao = 55.0, velocidade = (0.5,0.5)}], nitros = [5.0], historico = [[(2,1)]]}
-}

atualizaAux :: Tempo -- ^ a duração da ação
            -> Jogo  -- ^ o estado do jogo
            -> Int   -- ^ o identificador do jogador
            -> Acao  -- ^ a ação tomada pelo jogador
            -> Jogo  -- ^ o estado atualizado do jogo

atualizaAux t (Jogo m pi ((Carro pos d v):cs) n h) i (Acao p q r s a) = 
    Jogo m pi (atualizaCarro t (Jogo m pi (atualizaCarroNitro t (Jogo m pi ((Carro pos d v):cs) n h) i (Acao p q r s a)) n h) i (Acao p q r s a)) (atualizaNitro n a i t) (atualizaHistorico h (convertePos pos) i)



{-| A função 'atualizaCarro' atualiza todos os carros do jogo, ou seja, as suas direções e velocidades.

  == Exemplos de utilização:

       >>> atualizaCarro 1 (Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0, k_pneus = 0, k_acel = 0, k_peso = 0, k_nitro = 0, k_roda = 10}, carros = [Carro {posicao = (2.01,1.01), direcao = 45, velocidade = (0.5,0.5)}], nitros  = [5] , historico  = [[]] }) 0  (Acao { acelerar = False, travar  = False , esquerda = True, direita  = False, nitro  = Nothing })
       [Carro {posicao = (2.01,1.01), direcao = 55.0, velocidade = (0.5,0.5)}]
-}

atualizaCarro :: Tempo   -- ^ a duração da ação
              -> Jogo    -- ^ o estado do jogo
              -> Int     -- ^ o identificador do jogador
              -> Acao    -- ^ a ação tomada pelo jogador
              -> [Carro] -- ^ os carros atualizados 

atualizaCarro t (Jogo m (Propriedades atrito pneus acel peso nitro roda) ((Carro pos d v):cs) (n:ns) h) i (Acao p q r s a) 
    | i == 0 = ( Carro pos (atualizaDirecao (Carro pos d v) t roda (Acao p q r s a)) (atualizaVelocidade t m (Propriedades atrito pneus acel peso nitro roda) (Carro pos d v) (Acao p q r s a))):cs 
    | otherwise = (Carro pos d v):(atualizaCarro t (Jogo m (Propriedades atrito pneus acel peso nitro roda) cs (n:ns) h) (i-1) (Acao p q r s a))


                                        
{-| A função 'atualizaCarroNitro' aplica o k_nitro ao carro do jogador em que o nitro é acionado. 

  == Exemplos de utilização:

       >>> atualizaCarroNitro 1 (Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0, k_pneus = 0, k_acel = 0, k_peso = 0, k_nitro = 0, k_roda = 10}, carros = [Carro {posicao = (2.01,1.01), direcao = 45, velocidade = (0.5,0.5)}], nitros  = [5] , historico  = [[]] }) 0  (Acao { acelerar = False, travar  = False , esquerda = True, direita  = False, nitro  = Nothing })
       [Carro {posicao = (2.01,1.01), direcao = 45.0, velocidade = (0.5,0.5)}]
-}

atualizaCarroNitro :: Tempo   -- ^ a duração da ação
                   -> Jogo    -- ^ o estado do jogo
                   -> Int     -- ^ o identificador do jogador
                   -> Acao    -- ^ a ação tomada pelo jogador
                   -> [Carro] -- ^ os carros atualizados 

atualizaCarroNitro t (Jogo m (Propriedades atrito pneus acel peso nitro roda) (c:cs) (n:ns) h) i (Acao p q r s Nothing) = (c:cs)
                                                                                                                   
atualizaCarroNitro t (Jogo m (Propriedades atrito pneus acel peso nitro roda) ((Carro pos d v):cs) (n:ns) h) i (Acao p q r s (Just j)) 
    | j == 0 = ( Carro pos d (aplicaNitro (Carro pos (converteRad d) v) t nitro ) ):cs 
    | otherwise = (Carro pos d v):(atualizaCarroNitro t (Jogo m (Propriedades atrito pneus acel peso nitro roda) ((Carro pos d v):cs) (n:ns) h) i (Acao p q r s (Just (j-1))))



{-| A função 'atualizaVelocidade' atualiza a velocidade do carro do jogador em questão, exeto o fator do nitro.

  == Exemplos de utilização:

       >>> atualizaVelocidade 1 (Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]) (Propriedades { k_atrito  = 0, k_pneus = 0, k_acel = 0, k_peso = 0, k_nitro = 0, k_roda = 10}) (Carro {posicao = (2.01,1.01), direcao = 45, velocidade = (0.5,0.5)}) (Acao { acelerar = False, travar  = False , esquerda = True, direita  = False, nitro  = Nothing })
       (0.5,0.5)
-}

atualizaVelocidade :: Tempo        -- ^ a duração da ação
                   -> Mapa         -- ^ mapa do jogo
                   -> Propriedades -- ^ propriedades (pista) do jogo
                   -> Carro        -- ^ carro correspondente ao jogador em questão
                   -> Acao         -- ^ a ação tomada pelo jogador
                   -> Velocidade   -- ^ velocidade atualizada (sem o nitro aplicado)

atualizaVelocidade t (Mapa (p,o) tab) (Propriedades atrito pneus acel peso nitro roda) (Carro pos d v) acao = 
    aplicaGravidade (aplicaAceleracao (Carro pos (converteRad d) (aplicaAtrito v (aplicaPneus (velocidadePolar v) v t pneus (converteRad (simplificaGrau d))) t atrito)) t acel acao) t peso (pecaPosicao (convertePos pos) tab)



{-| A função 'convertePos' indica a posição correspondente ao ponto dado.

  == Exemplos de utilização:

       >>>  convertePos (2.01,1.01)
       (2,1)
-}

convertePos :: Ponto   -- ^ ponto dado
            -> Posicao -- ^ posição correspondente ao ponto dado

convertePos (a,b) = (floor a, floor b)



{-| A função 'converteGrau' converte radianos para graus. 

  == Exemplos de utilização:

       >>>  converteGrau pi
       180
-}

converteGrau :: Angulo -- ^ ângulo em radianos
             -> Angulo -- ^ ângulo convertido para graus

converteGrau g = (g/pi) * 180



{-| A função 'converteRad' converte graus para radianos.

  == Exemplos de utilização:

       >>>  converteRad 180
       pi
-}

converteRad :: Angulo -- ^ ângulo em graus
            -> Angulo -- ^ ângulo convertido para radianos

converteRad g = (g/180) * pi



{-| A função 'simplificaGrau' simplifica qualquer grau para que fique no intervalo [0,360]

  == Exemplos de utilização:

       >>> simplificaGrau (-90)
       270
-}

simplificaGrau :: Angulo -- ^ ângulo dado (em graus)
               -> Angulo -- ^ ângulo simplificado correspondente ao ângulo dado

simplificaGrau g | g <= -360 = simplificaGrau (g + 360)
                 | g >= 360  = simplificaGrau (g - 360)
                 | (g >= 0) && (g < 360)  = g
                 | (g < 0)  && (g > -360) = g + 360



{-| O data type 'Polar' é uma forma diferente da cartesiana de reprensentar vetores, sendo o primeiro Double a intesidade (módulo) do vetor e o segundo Double o ângulo que o vetor faz com o eixo das abcissas.
-}

data Polar = Polar Double Double
           deriving (Show,Eq)



{-| A função 'velocidadePolar' converte a velocidade cartesiana para polar.

  == Exemplos de utilização:

       >>> velocidadePolar (Carro {posicao = (2,1), direcao = 0, velocidade = (0.1,0.1)})
       Polar 0.14142135623730953 0.7853981633974484
-}

velocidadePolar :: Velocidade -- ^ velocidade do carro dado
                -> Polar      -- ^ velocidade polar do carro dado

velocidadePolar (x,y) = Polar (sqrt(x^2 + y^2)) (acos(x/(sqrt(x^2 + y^2))))  



{-| A função 'velocidadeCartesiana' converte a velocidade polar para cartesiana.

  == Exemplos de utilização:

       >>> velocidadeCartesiana (Polar (sqrt 2) (pi/4))
       (1.00,1.00)
-}

velocidadeCartesiana :: Polar      -- ^ velocidade polar de um carro
                     -> Velocidade -- ^ velocidade cartesiana corespondente à velocidade polar dada

velocidadeCartesiana (Polar i a) = ((i*(cos a)),(i*(sin a)))



{-| A função 'aplicaAtrito' calcula a velocidade resultante depois de aplicado o atrito.

  == Exemplos de utilização:

       >>> aplicaAtito (0.5,0.5) (0.5,0.5) 1 0.2
       (0.4,0.4)
-}

aplicaAtrito :: Velocidade -- ^ velocidade inicial
             -> Velocidade -- ^ velocidade (depois de aplicada a força dos pneus)
             -> Tempo      -- ^ duração da ação 
             -> Double     -- ^ k_atrito
             -> Velocidade -- ^ velocidade polar do carro depois de aplicado o atrito

aplicaAtrito (v,v2) (x,y) t atrito = (x-(atrito*v*t),y-(atrito*v2*t))



{-| A função 'aplicaAceleracao' calcula a velocidade resultante depois de aplicada a aceleração relacionada com os parâmetros da ação "acelerar" e "travar".

  == Exemplos de utilização:

       >>> aplicaAceleracao (Carro (2,1) 45 (0.5,0.5)) 1 0.1 (Acao True False False False Nothing)
       (0.552532198881773,0.41490964754658816)
-}

aplicaAceleracao :: Carro      -- ^ carro dado
                 -> Tempo      -- ^ duração da ação 
                 -> Double     -- ^ k_acel
                 -> Acao       -- ^ ação realizada pelo jogagador em questão
                 -> Velocidade -- ^ velocidade cartesiana do carro dado depois de aplicada a aceleração 

aplicaAceleracao (Carro pos d (vx,vy)) t acel (Acao True False  _ _ _) = ((vx + acel * cos(d) * t),(vy - acel * sin(d) * t))
aplicaAceleracao (Carro pos d (vx,vy)) t acel (Acao False True  _ _ _) = ((vx - acel * cos(d) * t),(vy + acel * sin(d) * t))
aplicaAceleracao (Carro pos d (vx,vy)) t acel (Acao _ _ _ _ _)         = (vx,vy)



{-| A função 'aplicaPneus' calcula a velocidade resultante depois de aplicada a força dos pneus.

  == Exemplos de utilização:

       >>> aplicaPneus (Polar 0.3 (pi/2)) (0,-0.3) 1 0.2 (pi/4)
       (3.0e-2,-0.27)
-}

aplicaPneus :: Polar      -- ^ velocidade polar do carro
            -> Velocidade -- ^ velocidade cartesiana do carro
            -> Tempo      -- ^ duração da ação       
            -> Double     -- ^ k_pneus
            -> Angulo     -- ^ direção do carro
            -> Velocidade -- ^ velocidade cartesiana do carro dado depois de aplicado a força dos pneus
 
aplicaPneus (Polar i a) (x,y) t pneus d 
    | (abs (a - (d + (pi/2)))) >= (abs (a - (d - (pi/2)))) = aplicaPneusAux (x,y) (velocidadeCartesiana (Polar ((sin (a-d))*pneus*t*(sqrt(x^2 + y^2))) (d+(pi/2)))) 
    | otherwise = aplicaPneusAux (x,y) (velocidadeCartesiana (Polar (abs ((sin (a-d))*pneus*t*(sqrt(x^2 + y^2)))) (d-(pi/2))))



{-| A função 'aplicaPneusAux' 

  == Exemplos de utilização:

       >>> aplicaPneusAux (0,-0.3) (0.1,0.1)
       (0.1,-0.4)
-}

aplicaPneusAux :: Velocidade -- ^ velocidade cartesiana do carro 
               -> Velocidade -- ^ vetor da força dos pneus
               -> Velocidade -- ^ velocidade resultante

aplicaPneusAux (x,y) (x1,y1) = (x+x1,y-y1)



{-| A função 'aplicaGravidade' calcula a velocidade resultante depois de aplicado o peso, caso o carro se encontrar numa rampa.

  == Exemplos de utilização:

       >>> aplicaGravidade (0.1,0.1) 2 0.3 (Peca (Rampa Norte) 0)
       (0.1,0.7)
-}

aplicaGravidade :: Velocidade -- ^ velocidade do carro
                -> Tempo      -- ^ duração da ação       
                -> Double     -- ^ k_peso
                -> Peca       -- ^ peça em que o carro se encontra
                -> Velocidade -- ^ velocidade cartesiana do carro dado depois de aplicado o peso
 
aplicaGravidade (vx,vy) t peso (Peca tp a) | tp == (Rampa Norte) = (vx,vy + t*peso)
                                           | tp == (Rampa Sul)   = (vx,vy - t*peso)
                                           | tp == (Rampa Este)  = (vx - t*peso,vy)
                                           | tp == (Rampa Oeste) = (vx + t*peso,vy)
                                           | otherwise = (vx,vy)



{-| A função 'aplicaNitro' calcula a velocidade resultante depois de aplicado o nitro.

  == Exemplos de utilização:

       >>> aplicaNitro (Carro (2.01,1.01) 45 (0.2,0.2)) 1 0.2 
       (0.305064397763546,2.9819295093176323e-2)

-}

aplicaNitro :: Carro      -- ^ carro dado
            -> Tempo      -- ^ duração da ação 
            -> Double     -- ^ k_nitro
            -> Velocidade -- ^ velocidade cartesiana do carro dado depois de aplicada o atrito

aplicaNitro (Carro pos d (vx,vy)) t nitro = ((vx + nitro * cos(d) * t),(vy - nitro * sin(d) * t))



{-| A função 'atualizaDirecao' atualiza a direção de um carro, dependendo dos parâmetros da ação "esquerda" e "direita"

  == Exemplos de utilização:

       >>> atualizaDirecao (Carro (2.01,1.01) 45 (0.2,0.2)) 1 45 (Acao False False False True Nothing)
       0.0
-}

atualizaDirecao :: Carro  -- ^ carro dado
                -> Tempo  -- ^ duração da ação
                -> Double -- ^ k_roda
                -> Acao   -- ^ ação realizada pelo jogagador em questão
                -> Angulo -- ^ direção do carro atualizada

atualizaDirecao (Carro pos d (vx,vy)) t roda (Acao _ _ True False _) = d + roda * t 
atualizaDirecao (Carro pos d (vx,vy)) t roda (Acao _ _ False True _) = d - roda * t 
atualizaDirecao (Carro pos d (vx,vy)) t roda (Acao _ _ _ _ _) = d 



{-| A função 'atualizaNitro' utiliza a 'atualizaNitroAux' para atualizar os nitros mas verifica primeiro se de facto se realizou alguma mudança dos nitros ou não.

  == Exemplos de utilização:

       >>> atualizaNitro [1,2,4,3,5] (Nothing) 3 1
       [1.0,2.0,4.0,3.0,5.0]
-}

atualizaNitro :: [Tempo]   -- ^ nitros dados pelo estado do jogo dado 
              -> Maybe Int -- ^ parâmetro da ação relacionado com o nitro
              -> Int       -- ^ identificador do jogador
              -> Tempo     -- ^ duração da ação
              -> [Tempo]   -- ^ nitros atualizados

atualizaNitro t a i d | a == Nothing = t
                      | otherwise = atualizaNitroAux t a i d



{-| A função 'atualizaNitroAux' atualiza os nitros do jogo. 

  == Exemplos de utilização:

       >>> atualizaNitroAux [1,2,4,3,5] (Just 3) 4 2
       [1.0,2.0,4.0,1.0,5.0]
-}

atualizaNitroAux :: [Tempo]   -- ^ nitros dados pelo estado do jogo dado 
                 -> Maybe Int -- ^ parâmetro da ação relacionado com o nitro
                 -> Int       -- ^ identificador do jogador
                 -> Tempo     -- ^ duração da ação
                 -> [Tempo]   -- ^ nitros atualizados
 
atualizaNitroAux (t:ts) (Just n) i d | i == 0 = ((t-d):ts)
                                     | otherwise = t:(atualizaNitroAux ts (Just n) (i-1) d)



{-| A função 'atualizaHistorico' atualiza o histórico das posições percorridas pelos jogadores.

  == Exemplos de utilização:

       >>> atualizaHistorico [[],[],[(2,1)],[(2,2)]] (2,1) 1
       [[],[(2,1)],[(2,1)],[(2,2)]]
-}

atualizaHistorico :: [[Posicao]] -- ^ lista de históricos 
                  -> Posicao     -- ^ posição atual
                  -> Int         -- ^ identificador do jogador
                  -> [[Posicao]] -- ^ lista de históricos atualizada 
 
atualizaHistorico (x:xs) p i | i == 0 = (atualizaHistoricoAux x p):xs
                             | otherwise = x:(atualizaHistorico xs p (i-1))



{-| A função 'atualizaHistoricoAux' atualiza o histórico das posições percorridas pelos jogador que realiza a ação.

  == Exemplos de utilização:

       >>> atualizaHistoricoAux [(2,1)] (2,1)
       [(2,1)]
-}

atualizaHistoricoAux :: [Posicao] -- ^ histórico das posições do jogador que realiza a ação
                     -> Posicao   -- ^ posição atual
                     -> [Posicao] -- ^ histórico atualizado
 
atualizaHistoricoAux [] p = [p]
atualizaHistoricoAux [x] p | x == p = [x]
                           | otherwise = [p] ++ [x]  
atualizaHistoricoAux (x:xs) p | x == p = (x:xs)
                              | otherwise = [p] ++ (x:xs)


         
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

