import Data.List
--funcao any que testa se um predicado é verdade para algum elemento da lista
any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (x:xs) | f x == True = True
              | otherwise = any' f xs
--funcao ZipWith que combina os elementos de duas listas usando uma função específica
zipWith' :: (a->b->c) -> [a] -> [b] -> [c]
zipWith' f [] [] = []
zipWith' f (x:xs) (y:ys) = (f x y):(zipWith' f xs ys)
--funcao que determina os primeiros elementos da lista que satisfazem um dado predicado
takeWhile' :: (a->Bool) -> [a] -> [a]
takeWhile' f [] = []
takeWhile' f (x:xs) | f x == True = x:(takeWhile' f xs)
                    | otherwise = []
--funcao que elimina os primeiros elementos da lista que satisfazem um dado predicado
dropWhile' :: (a->Bool) -> [a] -> [a]
dropWhile' f [] = []
dropWhile' f (x:xs) | f x == True = dropWhile' f xs
                    | otherwise = (x:xs)
--funcao que calcula simultaneamente os dois resultados de dropwhile e takewhile
--pode ser definida usando takewhile e dropwhile no entanto não é eficiente.
spanito :: (a-> Bool) -> [a] -> ([a],[a])
spanito _ [] = ([],[])
spanito f (x:xs) | f x = (x:a,b)
                 | otherwise = (a,x:b)
                where (a,b) = spanito f xs
--funcao que apaga o primeiro elemento de uma lista que é "igual" a um dado elemento de acordo
--com a função de comparação que é passada como parâmetro
--deleteBy (\x y -> snd x == snd y) (1,2) [(3,3),(2,2),(4,2)]
deleteBy' :: (a -> a -> Bool) -> a -> [a] -> [a]
deleteBy' f _ [] = []
deleteBy' f x (h:t) | f x h = t
                   | otherwise = (h:deleteBy' f x t)
--funcao que ordna uma lista comparando os resultados
--de aplicar uma função de extracção de uma chave a cada elemento de uma lista.
--sortOn fst [(3,1),(1,2),(2,5)]

sortOn' :: Ord b => (a->b) -> [a] -> [a]
sortOn' f [] = []
sortOn' f [x] = [x]
sortOn' f (x:xs) | (f x) <= (f (head(aux))) = [x]++aux
                 | otherwise = [head(aux)]++(sortOn' f ([x]++tail(aux)))
                    where aux = sortOn' f xs
{-|
[1,2-1]
    1        spanito f [2,-1]
                2 spanito f [-1]
                     ([-1],[])
                ([-1],2:[])
-}
--polinomios consitem numa lista de monomios represntados por pares (coeficiente, expoente)
type Polinomio = [Monomio]
type Monomio = (Float,Int)
--por exx [(2,3), (3,4), (5,3), (4,5)] consiste no polinómio 2x^3 + 3x^4 + 5x^3 + 4x^5
--seleciona os monómios com um dado grau de um polinómio.
selgrau' :: Int -> Polinomio  -> Polinomio
selgrau' _ [] = []
selgrau' y (x:xs) | y == snd x = (x:selgrau' y xs)
                  | otherwise = selgrau' y xs
--indica de que forma a que (conta n p) indica quantos monómios de grau n existem em p.
conta :: Int -> Polinomio -> Int
conta _ [] = 0
conta y (h:t) | y == snd h = (conta y t) + 1
              | otherwise = conta y t
--indica o grau do polinomio
grau :: Polinomio -> Int
grau [] = 0
grau l = snd (maximum' l)
--funcao auxiliar da grau responsável por calcular o tuplo máximo de uma lista de tuplos
maximum' :: Polinomio -> Monomio
maximum' (x:xs) = maxTail x xs
  where maxTail currentMax [] = currentMax
        maxTail (m, n) (p:ps)  | n < (snd p) = maxTail p ps
                               | otherwise   = maxTail (m, n) ps
--funcao que calcula o valor de um polinómio para um dado valor de x.
calcula' :: Float -> Polinomio -> Float
calcula' x [] = 0.0
calcula' x (h:t) = (x^(snd h))*(fst h) + calcula' x t
--retira de um polinómio os monómios de coeficiente zero.
simp' :: Polinomio -> Polinomio
simp' [] = []
simp' (x:xs) | snd x == 0 = simp' xs
             | otherwise = x:(simp' xs)
--calcula o resultado da multiplicação de um monómio por um polinómio
mult' :: Monomio -> Polinomio -> Polinomio
mult' _ [] = []
mult' (x,y) (h:t) = ((x*(fst h)),(y+(snd h))):(mult' (x,y) t)
--ordena um polinómio por ordem crescente dos graus dos seus monómios.
ordena' :: Polinomio -> Polinomio
ordena' [] = []
ordena' [x] = [x]
ordena' (h:t) | h <= (head l) = [h] ++ l
              | otherwise = [head(l)] ++ (ordena' ([h] ++ tail(l)))
             where l = ordena' t
--dado um polinómio constroí um polinómio equivalente em que não podem aparecer
-- vários monómios com o mesmo grau.
normaliza :: Polinomio -> Polinomio
normaliza [] = []
normaliza [x] = [x]
normaliza (x:xs) = normaAux (length (x:xs)) (x:xs)
                where
                    normaAux 0 l = l
                    normaAux x (h:t) = normaAux (x-1) (verPoli h t)
--funcao responsável por somar monómio ao polinómio se tiverem o mesmo grau.
verPoli :: Monomio -> Polinomio -> Polinomio
verPoli x [] = x:[]
verPoli (a,b) ((x,y):t) | b == y = t++[(a+x,b)]
                        | otherwise = (x,y):verPoli (a,b) t
--faz a soma de dois polinómios de forma que se os polinómios que recebe estiverem
--normalizados produz também um polinómio normalizado.
soma' :: Polinomio -> Polinomio -> Polinomio
soma' x []  = x
soma' [] x = x
soma' (x:xs) (y:ys) = soma' xs (somaMon x (y:ys))

somaMon :: Monomio -> Polinomio -> Polinomio
somaMon (a,b) [] = [(a,b)]
somaMon (a,b) ((x,y):t) | b == y = ((x+a),y):t
                        | otherwise = (x,y):somaMon (a,b) t
 --VER SOMA

--algoritmo sort EZ
gaz :: Ord a  => [a] -> [a]
gaz l | ordena1 (ordena1 l) == ordena1 l = ordena1 l
      | otherwise = gaz (ordena1 l)

ordena1 :: Ord a => [a] -> [a]
ordena1 [] = []
ordena1 [x] = [x]
ordena1 (h:t:xs) | h < t = h:ordena1 (t:xs)
                 | otherwise = t:ordena1 (h:xs)

--funcao produto que calcula o produto de dois polinómios.
produto :: Polinomio -> Polinomio -> Polinomio
produto [] y = []
produto (x:xs) y = normaliza ((mult' x y) ++ (produto xs y))

--funcao que testa se dois polinómios são equivalentes
equiv :: Polinomio -> Polinomio -> Bool
equiv _ [] = False
equiv x y | ordena'(normaliza x) == ordena'(normaliza y) = True
          | otherwise = False
--Matrizes
type Mat a = [[a]]
--ordenado listas de linhas
--funcao que testa se uma matriz está bem construída (todas as linhas têm a mesma dimensão)
dimOK :: Mat a -> Bool
dimOK [] = False
dimOK [x] = True
dimOK (x:y:xs) | length x == length y = dimOK (y:xs)
               | otherwise = False
--funcao que calcula a dimensão de uma matriz
dimMat :: Mat a -> (Int,Int)
dimMat [] = (0,0)
dimMat (y:ys) = (length (y:ys),length y)
--funcao que adiciona duas Matrizes
addMat :: Num a => Mat a -> Mat a -> Mat a
addMat _ [] = []
addMat (x:xs) (y:ys) = (zipWith (+) x y):(addMat xs ys)
--funcao que calcula a transposta de uma Matrizes
transpose' :: Mat a -> Mat a
transpose' ([]:t:[]) = []
transpose' x = (map (head) x):(transpose' (map (tail) x))
--funcao que calcula o produto de duas Matrizes

multMat :: Num a => Mat a -> Mat a -> Mat a
multMat a b = [[sum $ zipWith (*) x y | y <- (transpose' b)] | x <- a]
--[[1,2],[3,4]] mult [[5,6],[7,8]]
--[[1,2],[3,4]] * [[5,7],[6,8]]
--funcao que, à semelhança do que acontece com a função zipWith, combina duas matrizes.
--Use essa função para definir uma função que adiciona duas Matrizes
zipWMat :: (a -> b -> c) -> Mat a -> Mat b -> Mat c
zipMat f [] [] = []
zipWMat f x y = zipWith (zipWith f ) x y
--funcao que testa se uma matriz quadrada é triangular superior
triSup :: (Num a,Eq a) => Mat a -> Bool
triSup mat1 = calcQuandoTri 0 mat1
--funcao que testa se a matriz quadrada é triangular superior sabendo o a linha, verificando os zeros
calcQuandoTri :: (Num a, Eq a) => Int -> Mat a -> Bool
calcQuandoTri _ [] = False
calcQuandoTri linha (y:xs) | (length (takeWhile (0==) y) == linha) = calcQuandoTri (linha + 1) xs
                           | otherwise = False
--funcao que roda uma matrix 90 graus para a esquerda. Por exemplo, o resultado de rodar
-- a matriz acima apresentada deve corresponder à matriz
rotateLeft :: Eq a => Mat a -> Mat a
rotateLeft [] = []
rotateLeft mat | (length (filter (/= []) mat)) == 0 = []
               | otherwise = (rotateLeft (map (tail) mat)) ++ [(map (head) mat)]
