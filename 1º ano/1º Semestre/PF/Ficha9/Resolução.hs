-----(2)
data Exp a = Const a
           |Simetrico (Exp a)
           |Mais (Exp a) (Exp a)
           |Menos (Exp a) (Exp a)
           |Mult (Exp a) (Exp a)

-- 2 * (3+4)
e :: Exp Int
e = Mult (Const 2) (Mais (Const 3) (Const 4)) 

--(a)

showExp :: Show a => Exp a -> String
showExp (Const v) = show v
showExp (Simetrico e) = "(-" ++ showExp e ++ ")"
showExp (Mais e d)    = "(" ++ showExp e ++ "+" ++ showExp d ++ ")"
showExp (Menos e d)   = "(" ++ showExp e ++ "-" ++ showExp d ++ ")"
showExp (Mult e d)    = "(" ++ showExp e ++ "*" ++ showExp d ++ ")"

instance Show a => Show (Exp a) where
    show = showExp

{- OU
instance Show a => Show (Exp a) where
  show (Const v) = show v
  show (Simetrico e) = "(-" ++ show e ++ ")"
  show (Mais e d)    = "(" ++ show e ++ "+" ++ show d ++ ")"
  show (Menos e d)   = "(" ++ show e ++ "-" ++ show d ++ ")"
  show (Mult e d)    = "(" ++ show e ++ "*" ++ show d ++ ")"
-}

--(b)
cmpExp :: (Eq a,Num a) => Exp a -> Exp a -> Bool 
cmpExp e1 e2 = (calculaExp e1) == (calculaExp e2)

calculaExp :: Num a => Exp a -> a
calculaExp (Const n)     = n            
calculaExp (Simetrico e) = -(calculaExp e)
calculaExp (Mais e d)    = (calculaExp e) + (calculaExp d)
calculaExp (Menos e d)   = (calculaExp e) - (calculaExp d)
calculaExp (Mult e d)    = (calculaExp e) * (calculaExp d)

instance (Eq a,Num a) => Eq (Exp a) where
    (==) = cmpExp

ordExp :: (Ord a,Num a) => Exp a -> Exp a -> Bool 
ordExp e1 e2 = (calculaExp e1) <= (calculaExp e2)

instance (Ord a,Num a) => Ord (Exp a) where
    (<=) = ordExp
--(c)
{-
A classe Num tem a seguinte definição: 
class Num a where
   (+),(*),(-) :: a -> a -> a
   negate,abs,signum :: a -> a
   fromInteger :: Integer -> a
-}

instance Num a => Num (Exp a) where
    e1 + e2  = Const ((calculaExp e1) + (calculaExp e2))
    e1 * e2  = Const ((calculaExp e1) * (calculaExp e2))
    e1 - e2  = Const ((calculaExp e1) - (calculaExp e2))
    negate e = Simetrico e 
    abs e    = Const (abs (calculaExp e))
    signum e = Const (signum (calculaExp e))
    fromInteger i = Const (fromInteger i)

-----(3)
data Movimento = Credito Float | Debito Float
data Data = D Int Int Int
data Extracto = Ext Float [(Data, String, Movimento)] 



 




