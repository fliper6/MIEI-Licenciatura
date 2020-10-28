--tipo para representar funções
data Frac = F Integer Integer

--funcao normaliza :: Frac -> Frac
-- dada uma fração calcula uma fração equivalente, irredutível, e com o denominador postivoi
normaliza :: Frac -> Frac
normaliza (F x 0) = error "Impossivel dividir por 0"
normaliza (F 0 y) = F 0 1
normaliza (F x y) = F ((signum y)*(div x a)) (div (abs y) a)
                        where a = mdc (abs x) (abs y)
--Funcao que calcula o maximo divisor comum
--usando o algoritmo de euclides mdc x y == mdc (x+y) y == mdc (y+x)
mdc1 :: Integer -> Integer -> Integer
mdc1 a b | b == 0 = abs a
         | otherwise = mdc1 b (a `mod`b)

mdc :: Integer -> Integer -> Integer
mdc x y | x > y = mdc (x - y) y
        | x < y = mdc x (y - x)
        | x == y = x
--Definir Frac omo instância da Classe EQ.
instance Eq Frac where
  (==) x y = (a1 == a2) && (b1 == b2) where
    (F a1 b1) = normaliza x
    (F a2 b2) = normaliza y
--Definir Frac como instância da Classe
instance Ord Frac where
  (<=) (F n1 d1) (F n2 d2) = (<=) (n1 * d2) (d1 * n2)
--Definir Frac como instância da classe Show, de forma a que cada fração fração seja apresentada
--por numerador / denominador
instance Show Frac where
  show (F num dem) = "(" ++ show num ++ "/" ++ show dem ++ ")"
--Definir Frac como instância da classe Num
instance Num Frac where
    (+) (F n1 d1) (F n2 d2) = normaliza (F ((n1 * d2) + (n2 * d1)) (d1*d2))
    (-) (F n1 d1) (F n2 d2) = normaliza (F ((n1 * d2) - (n2 * d1)) (d1*d2))
    (*) (F n1 d1) (F n2 d2) = normaliza (F (n1 * d2) (d1 * d2))
    abs (F n d) = (F (abs n) (abs d))
    negate (F n d) = (F (negate n) (negate d))
    signum (F n d) | a == 0 = 0
                   | a > 0 = 1
                   | otherwise = -1
                    where (F a b) = normaliza (F n d)
    fromInteger x = (F x 1)
--Definir uma função que dada uma fração F e uma lista de frações l, seleciona de l
--os elementos que são maiores do que o dobro de f.
colhoesDeAco :: Frac -> [Frac] -> [Frac]
colhoesDeAco y [] = []
colhoesDeAco y (x:xs) | y*2 < x = x:colhoesDeAco y xs
                      | otherwise = colhoesDeAco y xs
--Relembrar Tipo
data ExpInt = Const Int 
             | Simetrico ExpInt               
             | Mais ExpInt ExpInt
             | Menos ExpInt ExpInt
             | Mult ExpInt ExpInt
--declarar Exp como uma instancia show
instance Show ExpInt where 
  show (Const a) = show a
  show (Simetrico a) = "-" ++ show a
  show (Mais a b) = show a ++ "+" ++ show b
  show (Menos a b) = show a ++ "-" ++ show b
  show (Mult a b) = show a ++ "*" ++ show b

instance Eq ExpInt where
  (==) x y = (calcula x) == (calcula y)

calcula :: ExpInt -> Int
calcula (Const a) = a
calcula (Simetrico a) = (calcula a) * (-1)
calcula (Mais a b) = (calcula a) + (calcula b) 
calcula (Menos a b) = (calcula a) - (calcula b)
calcula (Mult a b) = (calcula a) * (calcula b)

instance Num ExpInt where 
  (+) x y = (Mais x y)
  (-) x y = (Menos x y)
  (*) x y = (Mult x y)
  negate x = (Simetrico x)
  abs x | calcula x < 0 = (Simetrico x)
        | otherwise = x
  signum x | calcula x < 0 = -1
           | calcula x > 0 = 1
           | otherwise = 0
  fromInteger x = (Const (fromInteger x))

data Movimento = Credito Float | Debito Float
data Data = D Int Int Int
data Extracto = Ext Float [(Data, String, Movimento)]
--definir data com instância da classe Ord
instance Eq Data where
 (==) (D d1 m1 a1) (D d2 m2 a2) = (d1 == d2) && (m1 == m2) && (a1 == a2)

instance Ord Data where
 (<=) (D d1 m1 a1) (D d2 m2 a2) = (d1 == d2) && (m1 == m2) && (a1 == a2)

instance Show Data where
  show (D d m a) = show d ++ "/" ++ show m ++ "/" ++ show a

--funcao que transforma um extracto de modo a que a lista de movimentos apareça ordenada
-- por ordem crescente de data
ordenaExt :: Extracto -> Extracto
ordenaExt (Ext st moves) = (Ext st (oAux moves []))
                            where
                              oAux [] novaLista = novaLista
                              oAux (h:ts) novaLista = oAux ts (insOrdAux h novaLista)
                              insOrdAux x [] = [x]
                              insOrdAux (dt,x,y) ((date,strg,move):ts) | (dt > date) = (date,strg,move):(insOrdAux (dt,x,y) ts) 
                                                                       | otherwise = (dt,x,y):(date,strg,move):ts
instance Show Extracto where
  show (Ext st list) = "Saldo anterior: " ++ (show st) ++ "\n----------------------------------------------\nData\t\tDescricao\tCredito\tDebito\n----------------------------------------------\n" ++ (concat (map auxMovimento list)) ++ "----------------------------------------------\nSaldo actual: " ++ (show (saldo (Ext st list))) where
    auxMovimento (dt,strg,Credito x) | (length strg) < 7 = (show dt) ++ "\t" ++ (show strg) ++ "\t\t" ++ (show x) ++ "\n"
                                     | otherwise = (show dt) ++ "\t" ++ strg ++ "\t" ++ (show x) ++ "\n"
    auxMovimento (dt,strg,Debito x) | (length strg) < 7 = (show dt) ++ "\t" ++ strg ++ "\t\t\t" ++ (show x) ++ "\n" 
                                    | otherwise = (show dt) ++ "\t" ++ strg ++ "\t\t" ++ (show x) ++ "\n"


saldo :: Extracto -> Float
saldo (Ext x l) = x + calcula l
                  where
                    calcula [] = 0
                    calcula ((dt,strg,Credito x):t) = x + calcula t
                    calcula ((dt,strg,Debito x):t) = x + calcula t
ext1 :: Extracto
ext1 = Ext 300 [(D 5 4 2010,"DEPOSITO",Credito 2000),(D 10 8 2010,"COMPRA",Debito 37.5),(D 1 9 2010,"LEV",Debito 60),(D 7 1 2011,"JUROS",Credito 100),(D 22 1 2011,"ANUIDADE",Debito 8)]

