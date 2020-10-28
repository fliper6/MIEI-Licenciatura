{-|
Module : Tarefa5_2017li1g10
Description : Módulo Haskell contendo a 5ª Tarefa da 2ª Fase do Projeto "Micro Machines" de Laboratórios de Informática 1
Copyright: João Manuel da Costa Ferraz Soares <a77841@alunos.uminho.pt>;
           Filipa Alves dos Santos <a83631@alunos.uminho.pt>
-}


module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Data.Bitmap


type Estado = (Float,Float,Float,Float, [Picture],Float)


{-| A função 'estadoInicial' dá-nos o estado do jogo no primeiro instante de tempo.
       
       == Exemplo de utilização

           >>> estadoInicial [nave,tab]
           (0,0,0,0,[nave,tab],0)
-}

estadoInicial :: [Picture] -- ^ lista de imagens
              -> Estado    -- ^ estado do jogo
estadoInicial [nave,tab] = (0,150,0,0,[nave,tab],0)



{-| A função 'desenhaEstado' a cada instante desenha o que irá aparecer no ecrã.

        == Exemplo de utilização

            >>> desenhaEstado (0,0,0,0,[nave,tab],0)
            Pictures [ tab,(Translate 0 0 nave), Translate (-200) 310 (Scale 1 1 $ Text $ show $ 0)]
-}

desenhaEstado :: Estado  -- ^ estado num instante de tempo
              -> Picture -- ^ imagem resultante
desenhaEstado (x,y,vx,vy,[nave,tab],t) =  Pictures [ tab,(Translate x y nave), Translate (-200) 310 (Scale 1 1 $ Text $ show $ t)]
         


{-| A função 'move' altera a velocidade do carro consoante a tecla premida.             

        == Exemplo de utilização

            >>> move (EventKey (SpecialKey KeyUp) Down _ _) (0,0,0,0,[nave,tab],0)
            (0,0,0,-5,[nave,tab],0)
-}

move :: Event  -- ^ tecla premida
     -> Estado -- ^ estado dado à função
     -> Estado -- ^ estado após a função ser aplicada
move (EventKey (SpecialKey KeyUp) Down _ _)    (x,y,vx,vy,pic,t)  = (x,y,vx,5,pic,t)
move (EventKey (SpecialKey KeyDown) Down _ _)  (x,y,vx,vy,pic,t)  = (x,y,vx,-5,pic,t)
move (EventKey (SpecialKey KeyLeft) Down _ _)  (x,y,vx,vy,pic,t)  = (x,y,-5,vy,pic,t)
move (EventKey (SpecialKey KeyRight) Down _ _) (x,y,vx,vy,pic,t)  = (x,y,5,vy,pic,t)
move (EventKey (SpecialKey KeyUp) Up _ _)      (x,y,vx,vy,pic,t)  = (x,y,vx,0,pic,t)
move (EventKey (SpecialKey KeyDown) Up _ _)    (x,y,vx,vy,pic,t)  = (x,y,vx,0,pic,t)
move (EventKey (SpecialKey KeyLeft) Up _ _)    (x,y,vx,vy,pic,t)  = (x,y,0,vy,pic,t)
move (EventKey (SpecialKey KeyRight) Up _ _)   (x,y,vx,vy,pic,t)  = (x,y,0,vy,pic,t)
move _ estado = estado



{-| A função 'tempoPassa' desloca o carro segundo a velocidade dada. Também atualiza o tempo.

         == Exemplo de utilização

             >>> tempoPassa 0.1 (0,0,5,0,[nave,tab],0)
             (0,5,0,0,[nave,tab],0.1)
-}


tempoPassa :: Float  -- ^ instante de tempo passado
           -> Estado -- ^ estado nesse momento
           -> Estado -- ^ estado após esse instante de tempo
tempoPassa t' (x,y,vx,vy,pic,t) = (x+vx,y+vy,vx,vy,pic,t+t')



{-| A função 'fr' determina a framerate do jogo.
 
        == Exemplo de utilização

            >>> fr 
            50
-}


fr :: Int  -- ^ framerate
fr = 50



{-| A função 'dm' determina o tamanho da janela de jogo, e o seu nome.

        == Exemplo de utilização

             >>> dm
             InWindow "Novo Jogo" (1000,1000) (0,0)
-}

dm :: Display -- ^ janela
dm = InWindow "Novo Jogo" (1000,1000) (0,0)



{-| A função 'main' é o que faz o jogo correr e carrega as imagens necessárias. -}


main :: IO ()
main = do nave <- loadBMP "bmp/Nave.bmp"
          tab <- loadBMP "bmp/Mapa.bmp"

          play dm (greyN 0.5) fr (estadoInicial [nave,tab]) desenhaEstado move tempoPassa
