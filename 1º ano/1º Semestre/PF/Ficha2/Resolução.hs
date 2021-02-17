import Data.Char
-----(2)
--(a)
dobros :: [Float] -> [Float]
dobros [] = []
dobros (x:xs) = (x*2):dobros xs

--(b)
numOcorre :: Char -> String -> Int
numOcorre a [] = 0
numOcorre a (x:xs) | x==a = 1+numOcorre a xs
                   | otherwise = numOcorre a xs

--(c)
positivos :: [Int] -> Bool
positivos [x] = x>=0
positivos (x:xs) | x<0 = False
                 | otherwise = positivos xs

--(d)
soPos :: [Int] -> [Int]
soPos [] = []
soPos (x:xs) | x>0 = x:soPos xs
             | x<=0 = soPos xs
 

--(e)
somaNeg :: [Int] -> Int
somaNeg [] = 0
somaNeg (x:xs) | (x >= 0) = somaNeg(xs)
               | otherwise = x + somaNeg(xs)         

--(f)
tresUlt :: [a] -> [a] 
tresUlt [] = []
tresUlt (x:xs) | length (x:xs) <= 3 = (x:xs)
               | otherwise = tresUlt (xs)

 --(g)
primeiros :: [(a,b)] -> [a]
primeiros [] = []
primeiros ((a,b):xs) = a:primeiros(xs)


primeiros2 [] = []
primeiros2 (x:xs) = fst x : primeiros2 xs
-- fst (primeiro de um par)

 -----(3)
 --(a)
soDigitos :: [Char] -> [Char]
soDigitos [] = []
soDigitos (x:xs) | isDigit x = (x:soDigitos(xs))
                 | otherwise = soDigitos(xs)

--(b)
minusculas :: [Char] -> Int
minusculas [] = 0
minusculas (x:xs) | isLower x = 1 + minusculas(xs)
                  | otherwise = minusculas(xs)

--(c)
nums :: String -> [Int]
nums [] = []
nums (x:xs) | isDigit x = digitToInt(x):nums(xs)
            | otherwise = nums(xs)

-----(4)
--(a)
segundos :: [(a,b)] -> [b]
segundos [] = []
segundos ((a,b):xs) = b:segundos(xs)

--(b)
nosPrimeiros :: (Eq a) => a -> [(a,b)] -> Bool
nosPrimeiros c [] = False
nosPrimeiros c ((a,b):xs) | c==a = True
                          | otherwise = nosPrimeiros c xs
                         
--(c)
minFst :: (Ord a) => [(a,b)] -> a 
minFst [(x,y)] = x
minFst (x:xs) | m < fst x = m
              | otherwise = fst x

         where m = minFst xs
--(d)
sndMinFstAux :: (Ord a) => [(a,b)] -> (a,b)
sndMinFstAux [(x,y)] = (x,y)
sndMinFstAux (x:xs) | m < fst x = (m,n)
                    | otherwise = x

   where (m,n) = sndMinFstAux xs

sndMinFst :: (Ord a) => [(a,b)] -> b
sndMinFst [(a,b)] = snd(sndMinFstAux [(a,b)])

--(e)
mfst :: (a,b,c) -> a
mfst (a,b,c) = a

msnd :: (a,b,c) -> b
msnd (a,b,c) = b

mtrd :: (a,b,c) -> c
mtrd (a,b,c) = c


sumTriplos :: (Num a, Num b, Num c) => [(a,b,c)] -> (a,b,c)
sumTriplos ((a,b,c):[]) = (a,b,c)
sumTriplos ((a,b,c):xs) = ((a + mfst(sumTriplos xs)),(b + msnd(sumTriplos xs)),(c + mtrd(sumTriplos xs)))

--(f)
maxTriplo :: (Ord a, Num a) => [(a,a,a)] -> a
maxTriplo ((a,b,c):[]) = a+b+c
maxTriplo ((a,b,c):xs) | (a+b+c) >= maxTriplo(xs) = a+b+c
                       | otherwise = maxTriplo(xs)