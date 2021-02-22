module Ficha1 where

--1)
{- a. (f.g)x = f(gx) = f(x+1) = 2*(x+1) = 2*x+2
 -    (f.g)x = f(gx) = f(2*x) = succ(2*x) = 2*x+1
 -    (f.g)x = f(gx) = f(length x) = succ(length x) = length x + 1
 -    (f.g)x = f(gx) = f(gxy) = f(x+y) = succ.(2*).(x+y) = succ(2*x+2*y) = 2*x + 2*y +1
   b. 
   c. id é a função identidade, devolve o próprio input, logo é indiferente onde é usada
-}

--2)
length' :: [a] -> Int
length' [] = 0
length' (h:t) = 1 + length' t

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (h:t) = reverse' t ++ [h]

--3)
--data Maybe a = Nothing | Just a
catMaybes' :: [Maybe a] -> [a]
catMaybes' [] = []
catMaybes' (Just a : t) = a : catMaybes' t
catMaybes' (Nothing : t) = catMaybes' t

--4)
{- executa uma função que recebe os 2 argumentos como tuplo em vez de separados
   exemplo: uncurry mod (5,2) = mod 5 2 = 1
	(a->b->c) - argumento função que recebe dois ints e devolve outro
	(a,b) - argumento duplo de ints
	c - resultado int -}
uncurry' :: (a->b->c) -> (a,b) -> c
uncurry' f(x,y) = f x y

curry' :: ((a,b)->c) -> a -> b -> c
curry' f x y = f(x,y)

flip' :: (a->b->c) -> b -> a -> c
flip' f y x = f x y

--5)
data LTree a = Leaf a | Fork (LTree a, LTree a)

flatten' :: LTree a -> [a]
flatten' (Leaf a) = [a]
flatten' (Fork(l,r)) = flatten' l ++ flatten' r

mirror' :: LTree a -> LTree a
mirror' (Fork(l,r)) = Fork(mirror' r, mirror' l)
mirror' x = x

fmap' :: (b->a) -> LTree b -> LTree a
fmap' f (Leaf a) = Leaf (f a)
fmap' f (Fork(l,r)) = Fork(fmap' f l, fmap' f r)

--6)
--a.
length'' :: [a] -> Int
length'' = foldr (\_ x -> succ x) 0

--b. função identidade, replica a lista

--7)
concat' :: [[a]] -> [a]
concat' [] = []
concat' (h:t) = h ++ concat' t

--8)
--f s = [a + 1 | a <- s, a > 0]
--f s = if s > 0 then succ s
f :: [Int] -> [Int]
f (h:t) = foldr (\x acc -> if x > 0 then succ x : acc else acc) []

--9)
--a.
m :: (a->b) -> [a] -> [b]
m f l = foldr (\x acc -> f x : acc) [] 1

--b.
m' :: (a->b) -> [a] -> [b]
m' f l = map f l

