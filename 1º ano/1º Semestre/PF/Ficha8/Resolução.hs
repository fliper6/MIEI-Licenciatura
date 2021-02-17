-----(1)
data ExpInt = Const Int
            | Simetrico ExpInt
            | Mais ExpInt ExpInt
            | Menos ExpInt ExpInt
            | Mult ExpInt ExpInt

e :: ExpInt
e = Const 7 -- = 7

e1 :: ExpInt
e1 = Simetrico e -- = -7

e2 :: ExpInt
e2 = Mais (Const 10) (Mult (Const 3) (Mais (Const 2) (Const 3))) -- = 10 + (3 * (2+3)) = 25

--(a)
calcula :: ExpInt -> Int
calcula (Const n)     = n 
calcula (Simetrico e) = -(calcula e)
calcula (Mais e d)    = (calcula e) + (calcula d)
calcula (Menos e d)   = (calcula e) - (calcula d)
calcula (Mult e d)    = (calcula e) * (calcula d)

--(b)
infixa :: ExpInt -> String
infixa (Const n)     = show n -- show :: Show a => a -> String
infixa (Simetrico e) = "-" ++ (infixa e)
infixa (Mais e d)    = "(" ++ (infixa e) ++ "+" ++ (infixa d) ++ ")"
infixa (Menos e d)   = "(" ++ (infixa e) ++ "-" ++ (infixa d) ++ ")"
infixa (Mult e d)    = "(" ++ (infixa e) ++ "*" ++ (infixa d) ++ ")"

--(c)
posfixa :: ExpInt -> String
posfixa (Const n)     = show n 
posfixa (Simetrico e) = "-" ++ (posfixa e)
posfixa (Mais e d)    = "(" ++ (posfixa e) ++ (posfixa d) ++ "+" ++ ")"
posfixa (Menos e d)   = "(" ++ (posfixa e) ++ (posfixa d) ++ "-" ++ ")"
posfixa (Mult e d)    = "(" ++ (posfixa e) ++ (posfixa d) ++ "*" ++ ")"

-----(2)
data RTree a = R a [RTree a]
             deriving Show

{-      7              rt :: RTree
      / |    \         rt = R 7 [R 2 [R 15 []]
     2  5     8                 ,R 5 [R 6 [], R 4 []]
    /  / \   /|\                ,R 8 [R 1 [], R 2 [], R 3 []]
   15 6   4 1 2 3               ]

-}

rt = R 7 [R 2 [R 15 []], R 5 [R 6 [], R 4 []], R 8 [R 1 [], R 2 [], R 3 []]]

--(a)

-- > soma (R 3 [])
-- 3

-- > soma (R 3 [R 2 [], R 4 []])  ( começa por fazer o somatório dos 'descendentes' (soma (R 2 []) e (soma (R 4 []), soma ambos e depois o somatório da '1ª' RTree )
-- 9

soma :: Num a => RTree a -> a
soma (R v l) = v + sum (map soma l)
--ou
soma'(R v l) = v + (foldr (+) 0 (map soma l))
--ou
soma''(R v l)= foldr (+) v (map soma l)

--(b)

-- > altura (R 3 [R 2 [], R 5 [R 1 []]]) 
-- 3

altura :: RTree a -> Int
altura (R _ []) = 1
altura (R _ l)  = 1 + maximum (map altura l)

--(c)

-- prune 1 rt
-- R 7 []

prune :: Int -> RTree a -> RTree a -- pode-se invocar a função 'prune' só com 1 argumento, p.e., 'prune 2' (Caso esta função fosse definida como (Int,RTree a) -> RTree)
prune 1 (R v l) = R v []           -- ou como (RTree a -> Int -> RTree a), já seria mais complicado definir esta função)
prune n (R v l) = R v (map (prune (n-1)) l)

--(d)
mirror :: RTree a -> RTree a
mirror (R v l) = R v (reverse (map mirror l))

--(e)

-- > postorder rt
-- [15,2,6,4,5,1,2,3,8,7]
postorder :: RTree a -> [a]
postorder (R v []) = [v]
postorder (R v l)  = lpo ++ [v]
                   where lpo = foldr 1 (++) (map postorder l)




































