import Data.Char
import System.Random

--getChar :: IO Char        (não recebe argumentos)
--putChar :: Char -> IO ()  (não retorna nada)

leCaracter :: IO ()
leCaracter = do 
    c <- getChar       -- c :: Char (o getChar não recebe nada mas devolve um Char) 
    putChar (toUpper c) 

leCaracter' :: IO ()
leCaracter' = do 
    c <- getChar  
    let c' = toUpper c
    putChar c' 

-----(1)
--randomIO :: Random a => IO
--randomRIO :: Random a => (a,a) -> IO a

--(a)
aleatorio :: (Int,Int) -> [Int] -> IO Int
aleatorio gama xs = do 
    n <- randomRIO gama
    if elem n xs
        then aleatorio gama xs
        else return n

bingo :: IO ()
bingo = bingo' []

bingo' :: [Int] -> IO ()
bingo' xs = if length xs >= 90 
   then return  () -- para acabar depois de se gerarem 90 números
   else 
       do
       getChar -- equivalente a carregar numa tecla
       n <- aleatorio (1,90) xs
       putStrLn (show n)
       bingo' (n:xs)

--(b)

compara :: [Int] -> [Int] -> (Int,Int)
compara xs ys = (c,e)
    where 
    c = comparaCorrectos xs ys
    e = comparaErrados xs ys


comparaCorrectos :: [Int] -> [Int] -> Int
comparaCorrectos xs ys = length (filter cmp (zip xs ys))
              where cmp (x,y) = y == x


comparaErrados :: [Int] -> [Int] -> Int
comparaErrados [] ys = 0
comparaErrados (x:xs) ys = if elem x ys
                          then 1 + comparaErrados xs ys
                          else comparaErrados xs ys
leInt :: IO Int
leInt = do 
    c <- getChar
    return (read [c])
 

geraSegredo :: IO [Int]
geraSegredo = do
    x1 <- randomRIO (0,9) 
    x2 <- randomRIO (0,9)
    x3 <- randomRIO (0,9)
    x4 <- randomRIO (0,9)
    return [x1,x2,x3,x4]


leSequencia :: IO [Int]
leSequencia = do
    c1 <- leInt
    c2 <- leInt
    c3 <- leInt
    c4 <- leInt
    return [c1,c2,c3,c4]


mastermind :: IO ()
mastermind = do 
    segredo <- geraSegredo
    mastermind' segredo


mastermind' :: [Int] -> IO ()
mastermind' segredo = do
    jogada <- leSequencia
    let (certos,errados) = compara segredo jogada
    putStrLn ""
    putStrLn  (show certos ++ "" ++ show errados)
    mastermind' segredo 

-----(2)
data Aposta = Ap [Int] (Int,Int)
--(a)
valida :: Aposta -> Bool
valida Ap n e = (validaNumeros n) && (validaEstrelas e)

validaNumeros :: [Int] -> Bool
validaNumeros n = (repeteNumeros n) && (intervaloValido n)

--repeteNumeros :: [Int] -> Bool
--intervaloValido :: [Int] -> Bool

validaEstrelas :: (Int,Int) -> Bool 
validaEstrelas (a,b) = (a/=b) && ((a >= 1) && (b >= 1) && (b <= 90) && (a <= 90))