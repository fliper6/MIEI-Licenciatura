-----(1)
--(a)
(><) :: Int -> Int -> Int
a >< b | a==0 || b==0 = 0
       | b==1 = a 
       | otherwise = a + (a><(b-1))

--(b)
div' :: Int -> Int -> Int
div' a b | a < b = 0 
         | otherwise = 1 + (div' (a-b) b)

--(c) (não dá quando b < 0) 
power' :: Int -> Int -> Int 
power' a 0 = 1 
power' a b|b>0 = a * (power' a (b-1))

-----(2)
type Polinomio = [Monomio]
type Monomio = (Float, Int)
p :: Polinomio 
p = [(2,3),(3,4),(5,3),(4,5)]

--(a)
conta :: Int -> Polinomio -> Int
conta a [] = 0
conta a (x:xs) | a == snd(x) = 1 + conta a xs
               | otherwise = conta a xs 

--(b)
grau :: Polinomio -> Int
grau [x] = snd(x)
grau ((a,b):xs) | b >= grau xs = b 
                | otherwise = grau xs 

--grau(m:p) = max (snd m) gp
--       where gp = grau p 

--(c)
selgrau :: Int -> Polinomio -> Polinomio
selgrau a [] = []
selgrau a (x:xs) | a == snd(x) = x:selgrau a xs
                 | otherwise = selgrau a xs 

--(d)
deriv :: Polinomio -> Polinomio
deriv [] = []
deriv ((a,b):xs) | b==0 = deriv xs
                 | otherwise = ((a*fromIntegral b) , (b-1)):deriv xs

--(e)
calcula :: Float -> Polinomio -> Float
calcula x [] = 0 
calcula x ((a,b):t) | b==0 = calcula a t
                    | otherwise = (a*(x)^b) + calcula x t

--(f)
simp :: Polinomio -> Polinomio
simp [] = []
simp ((a,b):t) | a==0 = simp t
               | otherwise = (a,b):simp t

--(g)
mult :: Monomio -> Polinomio -> Polinomio
mult (a,b) [] = []
mult (a,b) ((c,d):xs) = ((a*c),(b+d)):mult (a,b) xs

--(h)
normaliza :: Polinomio -> Polinomio
normaliza [] = []
normaliza ((a,b):xs) | 




















