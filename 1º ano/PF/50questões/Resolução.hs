import Data.Char

--(1)
myEnumFromTo :: Int -> Int -> [Int]
myEnumFromTo x y | x==y = [y]
                 | x<y = x:myEnumFromTo (x+1) y
                 | x>y = x:myEnumFromTo (x-1) y

--(2)
myEnumFromThenTo :: Int -> Int -> Int -> [Int]
myEnumFromThenTo x y z | x == z = [x]
                       | x<z && y<x = []
                       | x>z && y>0 = []
                       | x<z && y>z = [x]
                       | x>z && y<x && y<z = [x]
                       | x == y = error"Lista Impossivel"
                       | otherwise = x:y:myEnumFromThenTo a b z
                      where a = (y+(y-x))
                            b = (a+(y-x))                      

--(3)
myConectList :: [a] -> [a] -> [a]
myConectList [] l2 = l2
myConectList (x:xs) l2 = x:myConectList xs l2

--(4)
myPosicao :: [a] -> Int -> a
myPosicao (x:xs) p = if p > 0 then myPosicao xs (p-1)
                     else x 

--(5)
myReverse :: [a] -> [a]
myReverse [] = []
myReverse l = (last l:myReverse (init l))

--(6)
myTake :: Int -> [a] -> [a]
myTake n (x:xs) | n==0 = []
                | length (x:xs) <= n = (x:xs)
                | length (x:xs) > n = x:myTake (n-1) xs

--(7)
myDrop :: Int -> [a] -> [a]
myDrop n (x:xs) | n==0 = (x:xs)
                | length (x:xs) <= n = []
                | length (x:xs) > n = myDrop (n-1) xs

--(8)
myZip :: [a]-> [b] -> [(a,b)]
myZip [] [] = []
myZip [] _  = []
myZip _ []  = []
myZip (a:as) (b:bs) = (a,b):(myZip as bs)

--(9)
myElem :: Eq a => a -> [a] -> Bool
myElem a [] = False
myElem a (x:xs) | a==x = True
                | otherwise = myElem a xs

--(10)
myReplicate :: Int -> a -> [a]
myReplicate 0 a = []
myReplicate x a = a:myReplicate (x-1) a

--(11)
myIntersperce :: a -> [a] -> [a]
myIntersperce a [] = []
myIntersperce a [x] = [x]
myIntersperce a (x:xs) = x:a:myIntersperce a xs

--(12)
myGroup :: Eq a => [a] -> [[a]]
myGroup [] = []
myGroup l = lst:myGroup (myDrop (length lst) l)
    where lst = mkglist l

mkglist :: Eq a => [a] -> [a]
mkglist [x] = [x]
mkglist (x:x2:t) = if x==x2 then x: mkglist (x2:t) else [x]

--(13)
myConcat :: [[a]] -> [a]
myConcat          [] = []
myConcat     ([]:ys) = myConcat(ys)        --skippa elementos vazios         
myConcat ((x:xs):ys) = x:myConcat(xs:ys)

concat2 :: [[a]] -> [a]
concat2 [] = []
concat2 (x:xs) = x ++ concat2 xs
--(14)
myInits :: [a] -> [[a]] 
myInits [] = [[]]
myInits (x:xs) = (myInits (init (x:xs))) ++ [x:xs]

--(15)
myTails :: [a] -> [[a]]
myTails [] = [[]]
myTails (x:xs) = (x:xs): myTails(xs)

--(16)
myIsPrefixOf :: Eq a => [a] -> [a] -> Bool
myIsPrefixOf l1 [] = False
myIsPrefixOf [] l2 = True
myIsPrefixOf l1 l2 | l1 == l2 = True
                   | otherwise = myIsPrefixOf l1 (init l2)

--(17)
myIsSufixOf :: Eq a => [a] -> [a] -> Bool
myIsSufixOf l1 [] = False
myIsSufixOf [] l2 = True
myIsSufixOf l1 l2 | l1 == l2 = True
                  | otherwise = myIsSufixOf l1 (tail l2)

--(18)
myIsSubsequenceOf :: Eq a => [a] -> [a] -> Bool
myIsSubsequenceOf [] _ = True
myIsSubsequenceOf _ [] = False
myIsSubsequenceOf (x:xs) (y:ys) | x == y =  myIsSubsequenceOf xs ys
                                | otherwise = myIsSubsequenceOf (x:xs) ys

--(19)
myElemIndices :: Eq a => a -> [a] -> [Int]
myElemIndices a [] = []
myElemIndices a l | a /= last l = myElemIndices a (init l)
                  | otherwise = reverse(((length l)-1):myElemIndices a (init l))

--(20)
myNub :: Eq a => [a] -> [a]
myNub [] = []
myNub (y:ys) = y: myNub ((myNubAux y ys))

myNubAux :: Eq a => a -> [a] -> [a]
myNubAux _ [] = []
myNubAux a (x:xs) | a == x = myNubAux a xs
                  | otherwise = x:myNubAux a xs
  
--(21)
myDelete :: Eq a => a -> [a] -> [a]
myDelete _ [] = []
myDelete a (h:t) | a == h = t
                 | otherwise = h : myDelete a t

--(22)
my2Barras :: Eq a => [a] -> [a] -> [a] 
my2Barras l1 [] = []
my2Barras [] _ = []
my2Barras (x:xs) (y:ys) | x == y = my2Barras xs ys
                        | otherwise = x:my2Barras xs (y:ys)

--(23)
myUnion :: Eq a => [a] -> [a] -> [a]
myUnion l1 [] = l1
myUnion [] l2 = l2
myUnion  a (h:t) | elem h a = myUnion a t
                 | otherwise = myUnion (a ++ [h]) t

--(24)
myIntersect :: Eq a => [a] -> [a] -> [a]
myIntersect [] l2 = []
myIntersect (x:xs) l2 = myIntersectAux x l2 ++ myIntersect xs l2 

myIntersectAux :: Eq a => a -> [a] -> [a] 
myIntersectAux a [] = [a]
myIntersectAux a (x:xs) | a==x = [a]
                        | otherwise = myIntersectAux a xs

--(25)
myInsert :: Ord a => a -> [a] -> [a]
myInsert a [] = []
myInsert a (x:xs) | a > x  = x:myInsert a xs
                  | a <= x = a:x:xs 
 
--(26)
myUnwords :: [String] -> String
myUnwords [] = []
myUnwords (x:xs) = x ++ " " ++ myUnwords(xs)

--(27)
myUnlines :: [String] -> String
myUnlines [] = [] 
myUnlines (x:xs) = x ++ "\n" ++ myUnlines(xs)

--(28)
myPMaior :: Ord a => [a] -> Int
myPMaior [x] = 0 
myPMaior l  | last l == maxL (l) = length l - 1
            | otherwise = myPMaior (init l)

maxL :: Ord a => [a] -> a
maxL [x] = x
maxL (x:xs) | x > maxL xs = x
            | otherwise = maxL xs
--(29)
temRepetidos :: Eq a => [a] -> Bool
temRepetidos [] = False
temRepetidos (x:xs) | temRepetidosAux x xs = True
                    | otherwise = temRepetidos xs

temRepetidosAux :: Eq a => a -> [a] -> Bool
temRepetidosAux a [] = False
temRepetidosAux a (h:t) | a==h = True
                        | otherwise = temRepetidosAux a t 

--(30)
algarismos :: [Char] -> [Char]
algarismos [] = []
algarismos (x:xs) | isDigit x = x:algarismos xs
                  | otherwise = algarismos xs

--(31)
posImpares :: [a] -> [a]
posImpares [] = []
posImpares l | (mod (length l) 2) == 0 = posImpares (init l)
             | otherwise = (posImpares (init l)) ++ [last l]

--(32)
posPares :: [a] -> [a]
posPares [] = []
posPares l | mod (length l) 2 /= 0 = posPares (init l)
           | otherwise = (posPares (init l)) ++ [last l]

--(33)
isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted (x:xs) | isSortedAux x xs = isSorted (xs)
                | otherwise = False

isSortedAux :: Ord a => a -> [a] -> Bool
isSortedAux a [] = True
isSortedAux a (h:t) | a <= h = isSortedAux a t
                    | otherwise = False

--(34)
myiSort :: Ord a => [a] -> [a]
myiSort [] = []
myiSort (h:t) = myInsert h (myiSort t)

--(35)
menor :: String -> String -> Bool
menor [] [] = False
menor [] _  = True
menor _  [] = False
menor (x:xs) (y:ys) | ord x < ord y = True
                    | ord x == ord y = menor xs ys
                    | otherwise = False

--(36)
elemMSet :: Eq a => a -> [(a,Int)] -> Bool
elemMSet x [] = False
elemMSet x ((a,b):xs) | x==a = True
                      | otherwise = elemMSet x xs 

--(37)
lengthMSet :: [(a,Int)] -> Int
lengthMSet [] = 0
lengthMSet ((a,b):xs) = b + lengthMSet xs
 
--(38)
converteMSet :: [(a,Int)] -> [a]
converteMSet [] = []
converteMSet ((a,x):xs) = converteMSetAux a x ++ converteMSet xs


converteMSetAux :: a -> Int -> [a]
converteMSetAux a 0 = []
converteMSetAux a x = [a] ++ converteMSetAux a (x-1) 

--(39)
insereMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
insereMSet a [] = [(a,1)]
insereMSet a ((b,x):xs) | a==b = (b,x+1):xs
                        | otherwise = (b,x):(insereMSet a xs)
--(40)
removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet a [] = []
removeMSet a [(b,1)] | a == b = []
removeMSet a ((b,x):xs) | a==b = (b,x-1):xs
                        | otherwise = (b,x):(removeMSet a xs)
--(41)
constroiMSet :: Ord a => [a] -> [(a,Int)]
constroiMSet l = constroiMSetAux l 0

constroiMSetAux :: Ord a => [a] -> Int -> [(a,Int)]
constroiMSetAux (h:[]) n = [(h, n + 1)]
constroiMSetAux [] _ = [] 
constroiMSetAux (h:t) n | h == (head t) = constroiMSetAux t (n+1)
                        | otherwise = (h, n+1) : constroiMSetAux t 0
--(42)
myPartitionEithers :: [Either a b] -> ([a],[b])
myPartitionEithers l = eithersAux l ([],[])

eithersAux :: [Either a b] -> ([a],[b]) -> ([a],[b])
eithersAux ((Left h):t)  (l1,l2) = eithersAux t (h:l1,l2)
eithersAux ((Right h):t) (l1,l2) = eithersAux t (l1,h:l2)
eithersAux [] ls = ls

--(43)
myCatMaybes :: [Maybe a] -> [a]
myCatMaybes (Just x :t) = x:myCatMaybes t
myCatMaybes (Nothing:t) = myCatMaybes t
myCatMaybes [] = []

--(44)
data Movimento = Norte | Sul | Este | Oeste
               deriving Show

posicao :: (Int,Int) -> [Movimento] -> (Int,Int)
posicao (x,y) [] = (x,y)
posicao (x,y) (Norte:t) = posicao (x, y+1) t
posicao (x,y) (Sul:t)   = posicao (x, y-1) t
posicao (x,y) (Este:t)  = posicao (x+1, y) t
posicao (x,y) (Oeste:t) = posicao (x-1, y) t

--(45)
caminho :: (Int,Int) -> (Int,Int) -> [Movimento]
caminho (x1,y1) (x2,y2) | (x1 == x2 && y1 == y2) = []
                        | (x1 == x2 && y1 < y2)  = Norte        :caminho (x1, y1+1) (x2,y2)
                        | (x1 == x2 && y1 > y2)  = Sul          :caminho (x1, y1-1) (x2,y2)
                        | (x1 < x2  && y1 == y2) = Este         :caminho (x1+1, y1) (x2,y2)
                        | (x1 > x2  && y1 == y2) = Oeste        :caminho (x1-1, y1) (x2,y2)
                        | (x1 < x2  && y1 < y2)  = Este:Norte   :caminho (x1+1, y1+1) (x2,y2)
                        | (x1 > x2  && y1 < y2)  = Oeste:Norte  :caminho (x1-1, y1+1) (x2,y2)
                        | (x1 < x2  && y1 > y2)  = Este:Sul     :caminho (x1+1, y1-1) (x2,y2)
                        | (x1 > x2  && y1 > y2)  = Oeste:Sul    :caminho (x1-1, y1-1) (x2,y2)

--(46)
vertical :: [Movimento] -> Bool
vertical []        = False
vertical [Norte]   = True
vertical [Sul]     = True
vertical (Norte:t) = vertical t
vertical (Sul:t)   = vertical t
vertical (Este:t)  = False
vertical (Oeste:t) = False

--(47)
data Posicao = Pos Int Int
             deriving Show

dis :: Posicao -> Double
dis (Pos a b) = sqrt ( (fromIntegral a)^2 + (fromIntegral b)^2 )

maisCentral :: [Posicao] -> Posicao
maisCentral ((Pos a b):[]) = Pos a b
maisCentral ((Pos a b):xs) | dis (Pos a b) < dis (maisCentral xs) = Pos a b
                           | otherwise = maisCentral xs
 
--(48)
vizinhos :: Posicao -> [Posicao] -> [Posicao] 
vizinhos (Pos x y) [] = []
vizinhos (Pos x y) ((Pos x1 y1):xs) | (y == y1 && x == (x1 +1)) || (y == y1 && x == (x1 -1)) || (x == x1 && y == (y1 +1)) || (x == x1 && y == (y1 -1)) = (Pos x1 y1):vizinhos (Pos x y) xs
                                    | otherwise = vizinhos (Pos x y) xs

--(49)
ordenada :: Posicao -> Int
ordenada (Pos x xs) = xs

mesmaOrdenada :: [Posicao] -> Bool
mesmaOrdenada [] = False
mesmaOrdenada [Pos a b] = True
mesmaOrdenada ((Pos a b):xs) | b == ordenada(head(xs)) && (mesmaOrdenada xs) = True 
                             | otherwise = False

--(50)
data Semaforo = Verde | Amarelo | Vermelho
              deriving Show

interseccaoOK :: [Semaforo] -> Bool
interseccaoOK l = interseccaoOKAux l False

interseccaoOKAux :: [Semaforo] -> Bool -> Bool
interseccaoOKAux (Vermelho:t) v = interseccaoOKAux t v
interseccaoOKAux (_ :t) False   = interseccaoOKAux t True -- "marca" a 1ª cor não vermelha
interseccaoOKAux (_ :t) True    = False                   -- quando aparecer a 2ª cor não vermelha, devolve False
interseccaoOKAux [] _           = True

