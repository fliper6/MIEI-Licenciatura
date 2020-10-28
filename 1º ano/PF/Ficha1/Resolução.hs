-----(1)
--(a)
perimetro :: Double -> Double
perimetro r = 2*pi*r

--(b)
dis :: (Double,Double) -> (Double,Double) -> Double
dis (x1,y1) (x2,y2) = sqrt ((x1-x2)^2 + (y1-y2)^2)

--(c)
primUlt :: [a] -> (a,a)
primUlt l = (head l,last l)

--(d)
multiplo :: Int -> Int -> Bool
multiplo m n = mod m n == 0

--(e)
truncaImpar :: [Int] -> [Int]
truncaImpar l = if mod(length l) 2 == 0
                then l
                else tail l 

--(f)
max2 :: Double -> Double -> Double 
max2 x y = if y>x 
           then y
           else x 

--(g)
max3 :: Double -> Double -> Double -> Double
max3 x y z = if max2 x y < z
             then z
             else max2 x y 



-----(2)
--(a)
nRaizes :: Double -> Double -> Double -> Int
nRaizes a b c | ( b^2 -4*a*c ) > 0 = 2
              | ( b^2 -4*a*c ) == 0 = 1
              | ( b^2 -4*a*c ) < 0 = 0

--(b)
raizes :: Double -> Double -> Double -> [Double]
raizes a b c | (nRaizes a b c) == 2 = [((b^2 + sqrt(b^2-4*a*c))/2*a) , ((b^2 - sqrt(b^2-4*a*c))/2*a)]
             | (nRaizes a b c) == 1 = [(b^2/2*a)]
             | (nRaizes a b c) == 0 = []


-----(3)
type Hora = (Int,Int)
--(a)
horavalida :: Hora -> Bool
horavalida (h,m) = if (h<0 || h>=24 || m<0 || m>=60)
                   then False
                   else True

--(b)
comparaHora :: Hora -> Hora -> Bool
comparaHora h1 h2 = if ((converteMinutos h1) > (converteMinutos h2))
                    then True
                    else False

--(c)
converteMinutos :: Hora -> Int
converteMinutos (h,m) = h*60 + m 

--(d)
convHoras :: Int -> Hora
convHoras x = ((div x 60) , (mod x 60))

--(e)
difHoras :: Hora -> Hora -> Int
difHoras h1 h2 = abs(converteMinutos h1 - converteMinutos h2)

--(f)
adMinutos :: Hora -> Int -> Hora
adMinutos h m = convHoras(m+converteMinutos h)


-----(4)
data HoraDT = H Int Int 
            deriving (Eq, Show)

type Horario = (HoraDT,HoraDT)

f::HoraDT -> Bool
f(H h m) = h >=0 && h<24 && m>=0 && m<60
--(...)

-----(5)
data Semaforo = Verde
              | Amarelo
              | Vermelho
              deriving(Show,Eq)

s1 :: Semaforo
s1 = Verde

s2 :: Semaforo
s2 = Amarelo

s3 :: Semaforo
s3 = Vermelho

--(a)
next :: Semaforo -> Semaforo
next Verde    = Amarelo
next Amarelo  = Vermelho
next Vermelho = Verde

--(b)
stop :: Semaforo -> Bool
stop Verde    = False
stop Amarelo  = False
stop Vermelho = True

--(c)
safe :: Semaforo -> Semaforo -> Bool
safe x y | x == Vermelho = True
         | y == Vermelho = True
         | otherwise = False


-----(6)
data Ponto = C Double Double
           | P Double Double
           deriving (Show,Eq)

--(a)
posx :: Ponto -> Double
posx (C x y) = x 
posx (P x y) = x * cos(y)


--(b)
posy :: Ponto -> Double
posy (C x y) = y
posy (P x y) = x * sin(y)

--(c)
raio :: Ponto -> Double
raio (C x y) = sqrt( x^2 + y^2 )
raio (P x y) = x

--(d)
angulo :: Ponto -> Double
angulo (C x y) = atan(x / y)
angulo (P x y) = y

--(e)
dist :: Ponto -> Ponto -> Double
dist (C x1 y1) (C x2 y2) = sqrt((x2-x1)^2 + (y2-y1)^2)
dist (P x1 y1) (P x2 y2) = sqrt((cos(y2)-cos(y1))^2 + (sin(y2)-sin(y1))^2)

-----(7)
data Figura = Circulo Ponto Double
            | Rectangulo Ponto Ponto
            | Triangulo Ponto Ponto Ponto
            deriving (Show,Eq)

----------------------------------(em muitos exercícios abaixo, só fiz para quando o ponto é do tipo C(x1 y1))
--(a)
poligono :: Figura -> Bool
poligono (Circulo (C x y) r) = (r >= 0)                         
poligono (Rectangulo (C x1 y1) (C x2 y2)) = (x1 /= x2) && (y1 /= y2)
poligono (Triangulo (C x1 y1) (C x2 y2) (C x3 y3)) = (x1 /= x2) && (x3 /= x2) && (y1 /= y2) && (y1 /= y3) && (y2 /= y3)

--(b)
-- para os circulos não há vertices
vertices :: Figura -> [Ponto]
vertices (Rectangulo (C x1 y1) (C x2 y2)) = [(C x1 y1), (C x2 y2), (C x1 y2), (C x2 y1)]
ṽertices (Triangulo (C x1 y1) (C x2 y2) (C x3 y3)) = [(C x1 y1), (C x2 y2), (C x3 y3)]

--(c)
area :: Figura -> Double
area (Triangulo p1 p2 p3) = 
       let a = dist p1 p2
           b = dist p2 p3
           c = dist p1 p3 
           s = (a+b+c) / 2 --semi-perimetro
       in sqrt (s*(s-a)*(s-b)*(s-c)) --formula de Heron
area (Rectangulo (C x1 y1) (C x2 y2)) = (dist (C x1 y1) (C x2 y1)) * (dist (C x2 y1) (C x2 y2)) 
area (Circulo p1 r) = r^2 * pi 

--(d)
perimetro2 :: Figura -> Double
perimetro2 (Circulo p1 r) = 2*r*pi
perimetro2 (Rectangulo (C x1 y1) (C x2 y2)) = (dist (C x1 y1) (C x2 y1))*2 + (dist (C x2 y1) (C x2 y2))*2 
perimetro2 (Triangulo p1 p2 p3) = (dist p1 p2) + (dist p2 p3) + (dist p3 p1)


--6 (funções pré-definidas)