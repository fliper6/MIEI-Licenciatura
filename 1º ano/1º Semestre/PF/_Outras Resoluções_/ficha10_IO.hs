import System.Random
import Data.Char
import Data.List

-- | EX 1
-- | a)
--programa que sorteia os números para o jogo do bingo. Sempre que uma tecla é pressionada é apresentado
--um número aleatório entre 1 e 90. Obviamente, não podem ser apresentados números repetidos e o programa termina
-- depois de gerados os 90 números diferentes.
bingo :: IO()
bingo = do bingi []

bingi :: [Int] -> IO()
bingi lista = do {
                      if length lista == 90 then do {
                                                     putStrLn "Já Saíram todos os números";
                                                     return()
                                                    }
                      else do {
                               n <- randomRIO (1,90);
                               if (elem n lista) then bingi lista
                               else do {
                                        putStrLn "Prima Enter";
                                        getChar ;
                                        print n;
                                        bingi (n:lista)
                                      }
                             }
                }
--implementa uma variante do jogo de descodificação de padrões mastermind
-- o programa deve começar por gerar uma sequência secreta de 4 dígitos aleatórios.
-- que o jogador vai tentar descodificar.
-- Sempre que o jogador introduz uma sequência de 4 dígitos, o programa responde
-- com o número de dígitos com o valor correcto na posição correcta
-- e com o número de dígitos com o valor correcto na posição errada.
-- o jogo termina quando o jogador acertar na sequência de dígiots secreta.
-- | b)
mastermind :: IO()
mastermind = do {
                x <- geraSeqSecreta [];
                y <- lerInputUser [];
                putStrLn "Elementos corretos na posição correta: ";
                elementosCorrPos x y;
                putStrLn "Elementos corretos, mas infelizmente, na posição errada xD : ";
                elementosCorr 0 x y;
                }

elementosCorr :: Int -> [Char] -> [Char] -> IO()
elementosCorr _ [] _ = return()
elementosCorr y (x:xs) l | (elem x l) && ((l !! y) /= x) = do {
                                       print x;
                                       elementosCorr (y+1) xs l
                                       }
                         | otherwise = elementosCorr (y+1) xs l

elementosCorrPos :: [Char] -> [Char] -> IO()
elementosCorrPos [] [] = return()
elementosCorrPos (x:xs) [] = return()
elementosCorrPos (x:xs) (y:ys) | x == y = do {
                                            print x;
                                            elementosCorrPos xs ys;
                                             }
                               | otherwise = elementosCorrPos xs ys


geraSeqSecreta :: [Char] -> IO([Char])
geraSeqSecreta list = do {
                            if length list == 4 then do{
                            putStrLn "Sequência Secreta gerada (entre 0 e 10)";
                            return(list)
                            }
                            else do {
                            n <- randomRIO (0,9);
                            geraSeqSecreta ((intToDigit n):list)
                            }
                        }


lerInputUser :: [Char] -> IO([Char])
lerInputUser list2 = do {
                          if length list2 == 4 then do {
                            putStrLn "Jogada Registada";
                            return(list2)
                          }
                          else do {
                            putStrLn "Introduza a sua sequência de 4 números e pressione Enter ";
                            getLine;
                          }
                       }
--funcao auxiliar para testes durante a algoritmização
printe :: [Char] -> IO()
printe [] = do (return())
printe (h:t) = do {
                  print h;
                  printe t
                          }

-- | EX 2 [1,2,10,20,50]
--apostas euromilhoes
--escolha de 5 números e 2 estrelas
--os Números são inteiros entre 1 e 50
data Aposta = Ap [Int] (Int,Int)


--a funcao valida que testa se uma dada aposta é válida (tem os 5 números e 2 estrelas, dentro dos valores aceites e não tem reps)
valida :: Aposta -> Bool
valida (Ap [] _) = False
valida (Ap nums (y,x)) | ((length (filter (<50) nums)) == 5) && ((length nums) == 5) && semRep nums && x <= 9 && x >= 1 && y <= 9 && y >= 1 = True  
                       | otherwise = False

valida2 :: Aposta -> Bool
valida2 (Ap l (a,b)) = (all (\x->x>=1 && x<=50) l) && semRep l && (length l)==5 && a/=b && (elem a [1..12]) && (b>=1) && (b<=12)


semRep :: Eq a => [a] -> Bool
semRep [] = True
semRep (x:xs) | elem x xs = False
              | otherwise = semRep xs 

--b funcao que dada uma aposta e uma chave, calcula quantos números e quantas estrelas existem em comum nas duas aposta
comuns :: Aposta -> Aposta -> (Int, Int)
comuns (Ap nums1 stars1) (Ap nums2 stars2) = (a,b)
                where 
                 a = checkLista nums1 nums2
                 b = checkTup stars1 stars2
                 

checkLista :: [Int] -> [Int] -> Int
checkLista [] _ = 0
checkLista (x:xs) l | elem x l = 1 + checkLista xs l
                    | otherwise = checkLista xs l


checkTup :: (Int,Int) -> (Int,Int) -> Int
checkTup (a,b) (c,d) | (a == c) || (a == d) && (b == c) || (b == d) = 2
                     | (a == c) || (a == d) || (b == c) || (b == d) = 1
                     | otherwise = 0
--c definir a funcao da alinea anterior para 
----i defina Aposta como instância da classe Eq
instance Eq Aposta where
  x == y = comuns x y == (5,2)

instance Show Aposta where
  show (Ap nums (x,y)) = "Os números registados foram " ++ show nums ++ "\nAs Estrelas Registadas foram" ++ show x ++ " e " ++ show y ++ "\n"
----ii defina a funcao premio :: Aposta -> Aposta -> Maybe Int que dada uma aposta
-- e a chave do concurso indica qual o prémio que a aposta tem.
--premios 5 números 2 estrela - 1
--premios 5 números 1 estrela - 2
--premios 5 números 0 estrelas - 3
--premios 4 números 2 estrelas - 4
--premios 4 números 1 estrela - 5
--premios 4 números 0 estrelas - 6
--premios 3 números e 2 estrelas - 7
--premios 2 números e 2 estrelas - 8
--premios 3 números e 1 estrela - 9
--premios 3 números e 0 estrelas - 10
--premios 1 número e 2 estrelas - 11
--premios 2 números e 1 estrela - 12
--premios 2 números e 0 estrelas - 13

premio :: Aposta -> Aposta -> Maybe Int
premio x y = calcSomaPremios (comuns x y) 

calcSomaPremios :: (Int,Int) -> Maybe Int
calcSomaPremios (x,y) | x == 5 && y == 2 = Just 1
                      | x == 5 && y == 1 = Just 2
                      | x == 5 && y == 0 = Just 3
                      | x == 4 && y == 2 = Just 4
                      | x == 4 && y == 1 = Just 5
                      | x == 4 && y == 0 = Just 6
                      | x == 3 && y == 2 = Just 7
                      | x == 2 && y == 2 = Just 8
                      | x == 3 && y == 1 = Just 9
                      | x == 3 && y == 0 = Just 10
                      | x == 1 && y == 2 = Just 11
                      | x == 2 && y == 1 = Just 12
                      | x == 2 && y == 0 = Just 13
                      | otherwise = Nothing

premio1 :: Aposta -> Aposta -> Maybe Int
premio1 a b = case (comuns a b) of
              (5,2) -> Just 1
              (5,1) -> Just 2
              (5,0) -> Just 3
              (4,2) -> Just 4
              (4,1) -> Just 5
              (4,0) -> Just 6
              (3,2) -> Just 7
              (2,2) -> Just 8
              (3,1) -> Just 9
              (3,0) -> Just 10
              (1,2) -> Just 11
              (2,1) -> Just 12
              (2,0) -> Just 13
              (_,_) -> Nothing

--d para permitir que um apostador possa jogar de forma interactiva:
--definir a função ler aposta que lê do teclado uma aposta. Esta função deve garantir que a aposta produzida é valida.

leAposta :: IO Aposta
leAposta = do putStrLn "Insira Lista de 5 Numeros: "
              nums <- getLine
              putStrLn "Insira o Par de Estrelas: "
              est  <- getLine
              let ap = (Ap (read nums) (read est))
              if (valida ap) 
                 then return ap    
                 else do putStrLn "Aposta invalida !!"
                         leAposta
--e Defina a fun ̧c ̃ao joga :: Aposta -> IO () que recebe a chave do concurso, lˆe uma aposta do teclado e imprime o pr ́emio no ecr ̃a.
joga :: Aposta -> IO()
joga x  = do
            ap <- leAposta;
            case (premio ap x) of
                (Just n) -> putStr ("Você ganhou o prémio nº " ++ (show n) ++ "\n")
                Nothing -> putStr "Não obteve prémio"
                     
--e defina a funcao geraChave que gera uma chave válida de forma aleatória
geraChave :: IO Aposta
geraChave = do {
                numsi <- getNumbers [];
                starsi <- getStars (0,0);
                return(Ap numsi starsi);
                }


getNumbers :: [Int] -> IO([Int])
getNumbers nums = do {
                      if length nums == 5 then do{
                        return(nums);
                      }
                  else do {
                        n <- randomRIO (1,50);
                        getNumbers (n:nums)
                          }
                      }

getStars :: (Int,Int) -> IO((Int,Int))
getStars (x,y) = do {
                      if (x > 0 && y > 0) then do {
                        return ((x,y));
                      }
                      else do {
                        z <- randomRIO (1,9);
                        k <- randomRIO (1,9);
                        return (z,k)
                      }
                      }

ciclo :: Aposta -> IO ()
ciclo ch = do{
             i <- menu;
             case i of
              ('1':_) -> do joga ch
                            ciclo ch 
              ('2':_) -> do geraChave 
                            ciclo ch
              ('0':_) -> return()
              (_:_)   ->  ciclo ch

} 


main :: IO()
main = do ch <- geraChave
          ciclo ch

menu :: IO String
menu = do {
          putStrLn menutxt;
          putStr "Opção: ";
          c <- getLine;
          return c;
          }
          where menutxt = unlines ["",
                                  "Apostar ........... 1",
                                  "Gerar nova chave .. 2",
                                  "",
                                  "Sair................0"]
  