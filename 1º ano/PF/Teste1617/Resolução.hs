
-----(1)
type MSet a = [(a,Int)]

--(a) calcula a cardinalidade de um multi-conjunto
cardMSet :: MSet a -> Int
cardMSet [] = 0
cardMSet ((a,i):xs) = i + (cardMSet xs)

--(b) devolve a lista dos elementos com maior número de ocorrências
moda :: MSet a -> [a]
moda [] = []
moda t = aux2 t (maximum (aux t))

aux2 :: MSet a -> Int -> [a]
aux2 [] m = []
aux2 ((a,i):xs) m | i == m = a:(aux2 xs m)
                  | otherwise = aux2 xs m

aux :: MSet a -> [Int]
aux [] = []
aux ((a,i):xs) = i:(aux xs)
 
--(c) converte um multi-conjunto numa lista
converteMSet :: MSet a -> [a]
converteMSet [] = [] 
converteMSet (h:t) = (auxC h) ++ (converteMSet t)

auxC :: (a,Int) -> [a] 
auxC (a,0) = []
auxC (a,i) | i == i = [a]
           | otherwise = a:(auxC (a,(i-1)))

--(d) inserção de um dado número de ocorrências de um elemento no multi-conjunto, mantendo a ordenação por ordem decrescente da multiplicidade
addNcopies :: Eq a => MSet a -> a -> Int -> MSet a
addNcopies ((a,i):xs) b j | (jaExiste ((a,i):xs) b) && (a == b) = (a,i+j):xs                          -- falta ordenar
                          | (jaExiste ((a,i):xs) b) && (a /= b) = (a,i):(addNcopies xs b j)           
                          | otherwise = (ordena ((a,i):xs) (b,j) )

jaExiste :: Eq a => MSet a -> a -> Bool
jaExiste [] b = True
jaExiste ((a,i):xs) b | a == b = jaExiste xs b
                      | otherwise = False

ordena :: Eq a => MSet a -> (a,Int) -> MSet a
ordena [] (b,j) = [(b,j)]
ordena ((a,i):xs) (b,j) | j >= i = (b,j):(((a,i):xs))
                        | otherwise = ordena xs (b,j)

-----(2)
data SReais = AA Double Double | FF Double Double
            | AF Double Double | FA Double Double
            | Uniao SReais SReais

--(a) defina a SReais como instância da classe Show
instance Show SReais where
 show (AA x y) = "]" ++ (show x) ++ "," ++ (show y) ++ "["
 show (FF x y) = "[" ++ (show x) ++ "," ++ (show y) ++ "]"
 show (AF x y) = "]" ++ (show x) ++ "," ++ (show y) ++ "]"
 show (FA x y) = "[" ++ (show x) ++ "," ++ (show y) ++ "["
 show (Uniao x y) = "(" ++ (show x) ++ "U" ++ (show y) ++ ")"

--(b) testa se um elemento pertence a um conjunto
pertence :: Double -> SReais -> Bool
pertence n (AA x y) = (n > x) && (n < y)   
pertence n (FF x y) = (n >= x) && (n <= y)
pertence n (AF x y) = (n > x) && (n <= y)  
pertence n (FA x y) = (n >= x) && (n < y)  
pertence n (Uniao x y) = (pertence n x) || (pertence n y)

--(c) retira um elemento de um conjunto
tira :: Double -> SReais -> SReais 
tira n (AA x y) | pertence n (AA x y) = Uniao (AA x n) (AA n y)
                | otherwise = AA x y

tira n (FF x y) | pertence n (FF x y) && n == x = AF x y
                | pertence n (FF x y) && n == y = FA x y
                | pertence n (FF x y) = Uniao (FA x n) (AF n y)
                | otherwise = FF x y

tira n (AF x y) | pertence n (AF x y) && n == y = AA x y
                | pertence n (AF x y) = Uniao (AA x n) (AF n y)
                | otherwise = AF x y

tira n (FA x y) | pertence n (FA x y) && n == x = AA x y
                | pertence n (FA x y) = Uniao (FA x n) (AA n y)
                | otherwise = FA x y

tira n (Uniao  x y) = Uniao (tira n x) (tira n y)

-----(3)
data RTree a = R a [RTree a]

--(a) recebe um caminho e uma árvore e dá a lista de valores por onde esse caminho passa (se o caminho não for válido a função deve retornar Nothing)
percorre :: [Int] -> RTree a -> Maybe [a]
percorre i r | length (auxPercorre i r) == length i = Just (auxPercorre i r)
             | otherwise = Nothing

auxPercorre :: [Int] -> RTree a -> [a]
auxPercorre [] (R a l) = []
auxPercorre [h] (R a []) = []
auxPercorre (h:t) (R a l) | h > length l = []
                          | otherwise = a : auxPercorre t (l!!(h-1))

--(b)procura um elemento numa árvore e, em caso de sucesso, calcula o caminho correspondente.
procura :: Eq a => a -> RTree a -> Maybe [Int]
procura x (R y l) | x==y = Just []
procura x (R y [])| x/=y = Nothing
procura x (R y (h:t)) = case (procura x h) of
Just c -> Just (1:c)
Nothing -> case (procura x (R y t)) of
Nothing -> Nothing
Just [] -> Just []
Just (n:ns) -> Just ((n+1):ns)
