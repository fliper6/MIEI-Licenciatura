-----(1)
--(a)
any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs) | p x = True
              | otherwise = any' p xs

--(b
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f [] _ = []
zipWith' f _ [] = []
zipWith' f (x:xs) (y:ys) = (f x y):(zipWith' f xs ys)

--(c)
takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' p [] = []
takeWhile' p (x:xs) | p x = x:(takeWhile' p xs)
                    | otherwise = []

--(d)
dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' p [] = []
dropWhile' p (x:xs) | p x = (dropWhile' p xs)
                    | otherwise = (x:xs)

--(e)
{- Raciocínio para otimizar:

    span odd [1,3,4,5,6]
             'x'  xs   '  span odd xs = ([3],[4,5,6]) 
                                                       (...) 
-}

span' :: (a -> Bool) -> [a] -> ([a],[a])
span' p [] = ([],[])
span' p (x:xs) | p x = (x:lt,ld)
               | otherwise = ([],(x:xs))
               where (lt,ld) = span' p xs
--(f)
deleteBy' :: (a -> a -> Bool) -> a -> [a] -> [a]
deleteBy' _ _ [] = []
deleteBy' f v (x:xs) | f v x = xs -- só apaga a 1ª ocorrência (a função para aqui)
                     | otherwise = x:deleteBy' f v  xs
-----(2)
type Polinomio = [Monomio]
type Monomio = (Float,Int)

p :: Polinomio
p = [(2,3),(3,4),(5,3),(4,5)]

--(a)
selgrau' :: Int -> Polinomio -> Polinomio
selgrau' e p = filter f p           -- a função 'filter' seleciona apenas os elementos que satisfazem uma certa condição (filtra os que não satisfazem) -> comprimento da lista muda
             where f (c,g) = g == e                                 -- filter :: (a -> Bool) -> [a] -> [a]

--(b) 
conta' :: Int -> Polinomio -> Int
conta' e p =  length $ filter ( \(c,g) -> g == e ) p  -- $ filter ( \(e,g)-> g==e ) p  OU ( filter ( \(e,g)-> g==e ) p )

conta2 :: Int -> Polinomio -> Int -- como o resultado é um Int (e não uma lista), tipicamente usa-se o foldr e não o map/filter
conta2 e p = foldr f 0 p
           where f(_,g) r | g == e = 1+r
                          | otherwise = r  -- (r = resultado anterior)
             
--(d)
derivada :: Polinomio -> Polinomio
derivada p = map deriv p                                  -- a função 'map' transforma os elementos da lista noutros através de um função -> comprimento da lista é igual
           where deriv (c,e) = (c * fromIntegral e, e-1)                           -- map :: (a -> b) -> [a] -> [b]

--(e)
calcula' :: Float -> Polinomio -> Float
calcula' x p = sum $ map (\(c,e) -> c*x^e) p 

------------------------
sum' l = foldr (+) 0 l                            -- a função 'foldr' (atravessa a lista da direita para esquerda)
prod l = foldr (*) 1 l                                          -- foldr :: (a -> b -> b) -> b -> [a] -> b
------------------------                                                                                                    
                                                         
calcula2 :: Float -> Polinomio -> Float                  -- p = (2,3) : (3,4) : (5,3) : (4,5) : []
calcula2 x p = foldr f 0 p                              -- (2,3) 'f' (3,4) 'f' (5,3) 'f' (4,5) 'f' []
             where f (c,e) r = c * x^e + r                                         


                       









