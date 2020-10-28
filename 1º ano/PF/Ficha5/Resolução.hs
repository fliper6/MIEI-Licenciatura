import Data.Char
--inDigit, in Alpha

{- l = [1,2,3]
   l = 1:2:3:[]
   l = [1]++[2]++[3]
   l = [1..3]

   Lista por compreensão
    - [ x | x <- [1,2,3] ]

    - Lista dos pares até 20
      [ x | x <- [1..20], even x ]

    - inits [1,2,3,4,5] = [[],[1],[1,2],[1,2,3],[1,2,3,4],[1,2,3,4,5]]
      inits l = [ take n l | n <- [0..length l] ]


-----(1)
--(a)
[ x | x <- [1..20],mod x 2 == 0
                  ,mod x 3 == 0 ] = [6,12,18]

--(b)
[ x | x <- [ y | y <- [1..20],mod y 2 == 0]
                             ,mod x 3 == 0] ] = [6,12,18]
--(c)
[ (x,y) | x <- [0..20], y <- [0..20], x+y == 30 ] = [(20,10),(10,20),(15,15),...]

--(d)
[ sum [ y | y <- [1..x], odd y] | x <- [1..10] ] = [1,1,4,...]


-----(2)
--(a)
Potências de 2 (de 2⁰ até 2¹⁰)
[ 2^e | e <- [1..10] ]

--(b)
Pares com soma de x e y igual a 6
[ (x,y) | x <- [1..5], y <- [1..5], x+y == 6]

                        (ou)

Pares com x a aumentar de 1 a 5 
          y a diminuir de 5 a 1
[ (x,6-x) | x <- [1..5] ]

--(c)
Listas de [1] a [1,2,3,4,5]
[ [1,x] | x <- [1..5] ]

--(d)
Listas de [1] a [1,1,1,1,1]
[ replicate x 1 | x <-[1..5] ]    -} 


-----(3)
digitAlpha :: String -> (String,String)
-- digitAlpha "2a3b" -> ( "23" , "ab")
digitAlpha [] = ([],[])
digitAlpha (h:t) | isDigit h = (h:ld,la)
                 | isAlpha h = (ld,h:la)
                 | otherwise = (ld,la)
                 where (ld,la) = digitAlpha t

-----(4)
nzp :: [Int] -> (Int,Int,Int)
nzp [] = (0,0,0)
nzp (h:t) | h < 0  = (n+1,z,p)
          | h == 0 = (n,z+1,p)
          | h > 0  = (n,z,p+1)
          | otherwise = (n,z,p)
          where (n,z,p) = nzp t

-----(6)
fromDigits :: [Int] -> Int
fromDigits [] = 0 
fromDigits (h:t) = h*10^(length t) + fromDigits t 

fromDigits' :: [Int] -> Int
fromDigits' l = fst (fromDigitsAux ll)

fromDigitsAux ::[Int] -> (Int,Int) -- (resultado,expoente(acumulador))
fromDigitsAux [] =  (0,0)
fromDigitsAux (h:t) = (h*10^e+r,e+1)
                    where (r,e) = fromDigitsAux t

{- fromDigits' [1,2,3,4] = fst (fromDigitsAux [1,2,3,4])         = fst (1234,4) = 1234

                        fromDigitsAux [1,2,3,4] = (1*10^e+r,e+1) = (1234,4)
                        where (r,e) = fromDigitsAux [2,3,4]   
                               234,3

                        fromDigitsAux [2,3,4] = (2*10^e+r,e+1)   = (234,3)
                        where (r,e) = fromDigitsAux [3,4]          
                               34,2

                        fromDigitsAux [3,4] = (3*10^e+r,e+1)     = (34,2)
                        where (r,e) = fromDigitsAux [4]          
                               4,1

                        fromDigitsAux 4:[] = (4*10^e+r,e+1)      = (4,1) 
                        where (r,e) = fromDigitsAux []           
                               0+0
}  





  