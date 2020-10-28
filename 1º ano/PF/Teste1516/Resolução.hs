-----(1)

--(a) calcula uma lista com os mesmos elementos da recebida, sem repetições
nub :: Eq a => [a] -> [a] 
nub [h] = [h]
nub (h:t) | (temRepeticoes h t) = nub t 
          | otherwise = h:(nub t)

temRepeticoes :: Eq a => a -> [a] -> Bool
temRepeticoes h [] = False
temRepeticoes h (t:ts) | h == t = True
                       | otherwise = temRepeticoes h ts

--(b) combina os elementos de duas listas usando uma função especı́fica
zipWith' :: (a->b->c) -> [a] -> [b] -> [c] 
zipWith' f [] h = []
zipWith' f h [] = []
zipWith' f (h:t) (x:xs) = (f h x):(zipWith' f t xs)

-----(2)
type MSet a = [(a,Int)]

--(a) converte uma lista para um multi-conjunto
{-  *maneira alternativa*
converte :: Eq a => [a] -> MSet a
converte [] = []
converte (h:t) = (h, 1 + (length ( filter ( h == ) t ))) : converte (filter (h/=) t)
-}

converte :: Eq a => [a] -> MSet a
converte l = cria (todos l []) l
    where
        todos [] l = l
        todos (h:t) l | elem h l = todos t l
                      | otherwise = todos t (l++[h])

        conta a [] = 0
        conta a (h:t) | a == h = 1 + conta a t
                      | otherwise = conta a t

        cria [] l = []
        cria (h:t) l = (h,conta h l) : cria t l

--(b) calcula a intersecção de dois multi-conjuntos
intersect :: Eq a => MSet a -> MSet a -> MSet a
intersect l [] = []
intersect [] l = []
intersect ((a,i):t) l = (intersectAux (a,i) l) ++ (intersect t l)

intersectAux :: Eq a => (a,Int) -> MSet a -> MSet a
intersectAux (a,i) [] = []
intersectAux (a,i) ((b,j):r) | (a == b) && (i <= j) = [(a,i)]
                             | (a == b) && (i >  j) = [(a,j)]
                             | otherwise = intersectAux (a,i) r

-----(3)
data Prop = Var String | Not Prop | And Prop Prop | Or Prop Prop

p1 :: Prop
p1 = Not (Or (And (Not (Var "A")) (Var "B")) (Var "C"))

--(a) declare Prop como instância da classe Show
instance Show Prop where
 show (Var s)     = (show s)
 show (Not p)     = "-" ++ "(" ++ (show p) ++ ")"
 show (And p1 p2) = "(" ++ (show p1) ++ "e"  ++ (show p2) ++ ")"   -- aqui e na linha abaixo, se puder "\/" e "/\" dá erro
 show (Or p1 p2)  = "(" ++ (show p1) ++ "ou" ++ (show p2) ++ ")"

--(b) dada uma valoração calcula o valor lógico de uma expressão proposicional
eval :: [(String,Bool)] -> Prop -> Bool
eval l (Var a)   = compara l a
eval l (Not a)   = not (eval l a)
eval l (And a b) = (eval l a) && (eval l b)
eval l (Or a b)  = (eval l a) || (eval l b)

compara :: [(String,Bool)] -> String -> Bool
compara ((s,b):t) h | s == h = b
                    | otherwise = compara t h

--(c) recebe uma proposição e produz uma outra que lhe é equivalente, mas que está na forma normal negativa.
nnf :: Prop -> Prop
nnf (Not (Var s)) = Not (Var s)
nnf (Not (And p1 p2)) = Or (Not p1) (Not p2)
nnf (Not (Or p1 p2)) = And (Not p1) (Not p2)
nnf (Not (Not p)) = p 

{--(d) dada uma proposição, pergunta ao utilizador a valoração de cada variável presente na proposição e calcula com essa informação o seu valor lógico
avalia :: Prop -> IO Bool
avalia p = do l <- avaliaAux p (listOfVariables p)
return $ eval l p

listOfVariables :: Prop -> [String]
listOfVariables (Var a) = [a]
listOfVariables (Not a) = listOfVariables a
listOfVariables (And a b) = listOfVariables a ++ listOfVariables b
listOfVariables (Or a b) = listOfVariables a ++ listOfVariables b

avaliaAux :: Prop -> [String] -> IO [(String,Bool)]
avaliaAux p [] = return []
avaliaAux p (h:t) = do putStr ("Insira um valor para " ++ h ++ " (clique V se for verdadeiro, clique outra tecla para falso) \n")
  x <- getChar
  y <- avaliaAux p t
  putStr "\n"
  if x == 'V' || x == 'v' then return ((h,True):y) else return ((h,False):y) -}