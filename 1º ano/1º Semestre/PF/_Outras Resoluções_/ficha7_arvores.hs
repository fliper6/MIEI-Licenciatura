--tipo para representar árvores binárias
data BTree a = Empty
        | Node a (BTree a) (BTree a)
    deriving Show
--função que calcula a altura da árvore
altura :: BTree a -> Int 
altura Empty = 0
altura (Node _ lnode rnode) = 1 + (max (altura lnode) (altura rnode))
--função que caçcula o número de nodos da árvore.
contaNodos :: BTree a -> Int
contaNodos Empty = 0
contaNodos (Node _ lnode rnode) = 1 + (contaNodos lnode) + (contaNodos rnode)
--funcao que calcula o número de folhas (nodos sem desenctes da árvore)
folhas :: BTree a -> Int
folhas Empty = 0
folhas (Node _ Empty Empty) = 1
folhas (Node _ lnode rnode) = (folhas lnode) + (folhas rnode)
--funcao que remove de uma árvore todos os elementos
--a partir de uma determinada profundidade
prune :: Int -> BTree a -> BTree a
prune _ Empty = Empty
prune 0 x = Empty
prune prof (Node a lnode rnode) = Node a (prune (prof-1) lnode) (prune (prof-1) rnode)
--funcao que dado um caminho (False corresponde à esquerda e True a direita) e uma árvore
--da a lista com informação dos nodos por onde esse caminho passa.
path :: [Bool] -> BTree a -> [a]
path [] _ = []
path x Empty = []
path (True:xs) (Node a lnode rnode) = a : (path xs rnode) 
path (False:xs) (Node a lnode rnode) = a : (path xs lnode) 
--função que dá a árvore simétrica
mirror :: BTree a -> BTree a
mirror Empty = Empty
mirror (Node a lnode rnode) = Node a (mirror rnode) (mirror lnode)
--generaliza  função zipwith para árvores binárias
zipWithBT :: (a->b->c) -> BTree a -> BTree b -> BTree c
zipWithBT f Empty _ = Empty
zipWithBT f _ Empty = Empty
zipWithBT f (Node a lnode rnode) (Node b leftn rightn) = Node (f a b) (zipWithBT f lnode leftn) (zipWithBT f rnode rightn)
-- funcao que generaçiza a função unzip (neste caso de triplos) para árvores binárias.
unzipBT :: BTree (a,b,c) -> (BTree a, BTree b, BTree c)
unzipBT Empty = (Empty,Empty,Empty)
unzipBT (Node (a,b,c) lnode rnode) =  (Node a q r, Node b w t, Node c e y) where
    (q,w,e) = unzipBT lnode 
    (r,t,y) = unzipBT rnode
--arvores binárias de procura
--funcao que calcula o menor elemento de uma árvore binária de procura NÃO VAZIA

minimo :: Ord a=> BTree a -> a
minimo n@(Node a x y) = minaux a n

minaux :: Ord a => a -> BTree a -> a
minaux x Empty = x
minaux x (Node a lnode rnode) = min a (min (minaux x lnode) (minaux x rnode))

minimo2 :: (Ord a) => BTree a -> a
minimo2 (Node x Empty _ ) = x
minimo2 (Node _ lnode _) = minimo2 lnode
--funcao que remove o menor elemento de uma árvore binária de procra não vazia
semMinimo :: (Ord a) => (BTree a) -> (BTree a)
semMinimo Empty = Empty
semMinimo (Node x Empty rnode) = rnode
semMinimo (Node x lnode rnode) = Node x (semMinimo lnode) rnode
--funcao quer calcula com uma única travessia da árvore o resultado das duas funções anteirores
minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin (Node a Empty rnode) = (a,rnode)
minSmin (Node x lnode rnode) = (a, Node x b rnode)
                                where (a,b) = minSmin lnode
--funcao que remove um elemento de uma árvore binária de procura, usando a função anterior
remove :: Ord a => a -> BTree a -> BTree a
remove _ Empty = Empty
remove a b | x == a = y
           | otherwise = groupin (Node x Empty Empty) (remove a y)
        where 
            (x,y) = minSmin b

groupin :: Ord a => BTree a -> BTree a -> BTree a
groupin x Empty = x
groupin x (Node a l r) = Node a (groupin x l) r
--cenas de alunos
type Aluno = (Numero, Nome, Regime, Classificacao)
type Numero = Int
type Nome = String
data Regime = ORD | TE | MEL deriving Show
data Classificacao = Aprov Int
                   | Rep
                   | Faltou
  deriving Show
type Turma = BTree Aluno 

--funcao que verifica se um aluno, com um dado  número, está inscrito.
inscNum :: Numero -> Turma -> Bool
inscNum _ Empty = False
inscNum x (Node (num,_,_,_) lnode rnode ) | x == num = True
                                          | otherwise = inscNum x lnode || inscNum x rnode
--funcao que verifica se um aluno, com um dado nome está inscrito.
inscNome :: Nome -> Turma -> Bool
inscNome _ Empty = False
inscNome nome (Node (_,name,_,_) lnode rnode) | nome == name = True
                                              | otherwise = inscNome nome lnode || inscNome nome rnode
--funcao que lista o número e nome dos alunos trabalhadores-estudantes 
trabEst :: Turma -> [(Numero, Nome)]
trabEst Empty = []
trabEst (Node (num,nome,TE,_) lnode rnode) = [(num,nome)] ++ (trabEst lnode) ++ trabEst (rnode) 
trabEst (Node (num,nome,_,_) lnode rnode) = (trabEst lnode) ++ (trabEst rnode) 
--funcao que calcula a classificação de um aluno
nota :: Numero -> Turma -> Maybe Classificacao
nota x Empty = Nothing
nota x (Node (num,_,_,classi) lnode rnode) | x == num = Just classi
                                           | x < num = nota x lnode
                                           | otherwise = nota x rnode
--calcula a percentagem de alunos que faltaram à avaliação                                                                                      
percFaltas :: Turma -> Float
percFaltas x = a/b
            where (a,b) = calcFaltas x
            

calcFaltas :: Turma -> (Float,Float)
calcFaltas Empty = (0,0)
calcFaltas (Node (_,_,_,Faltou) lnode rnode) = (a+1,b+1)
                            where 
                                (a,b) = (c+e,d+f)
                                (c,d) = calcFaltas lnode
                                (e,f) = calcFaltas rnode                                             
calcFaltas (Node (_,_,_,_) lnode rnode) = (a,b+1)                                               
                             where 
                                (a,b) = (c+e,d+f)
                                (c,d) = calcFaltas lnode
                                (e,f) = calcFaltas rnode
--calcula a média das notas dos alunos que passaram
mediaAprov :: Turma -> Float
mediaAprov x = a/b
            where (a,b) = calcMedia x

calcMedia :: Turma -> (Float, Float)
calcMedia Empty = (0,0)
calcMedia (Node (_,_,_,Aprov x) lnode rnode) = (a+(fromIntegral(x)) ,b+1)
                            where 
                                (a,b) = (c+e,d+f)
                                (c,d) = calcMedia lnode
                                (e,f) = calcMedia rnode                                             
calcMedia (Node (_,_,_,_) lnode rnode) = (a,b)                                               
                             where 
                                (a,b) = (c+e,d+f)
                                (c,d) = calcMedia lnode
                                (e,f) = calcMedia rnode
--calcula o rácio de alunos aprovados por avaliados. Implemente fazendo apenas uma travessia
aprovAv :: Turma -> Float
aprovAv x = a/b 
            where (a,b) = contaAvaliacoes x
contaAvaliacoes :: Turma -> (Float, Float)
contaAvaliacoes Empty = (0,0)
contaAvaliacoes (Node (_,_,_,Aprov x) lnode rnode) = (a+1,b+1)
                                        where (a,b) = (c+e,d+f)
                                              (c,d) = contaAvaliacoes lnode
                                              (e,f) = contaAvaliacoes rnode
contaAvaliacoes (Node (_,_,_, Rep) lnode rnode) = (a,b+1)
                                        where (a,b) = (c+e,d+f)
                                              (c,d) = contaAvaliacoes lnode
                                              (e,f) = contaAvaliacoes rnode       
contaAvaliacoes (Node (_,_,_, Faltou) lnode rnode) = (a,b)
                                        where (a,b) = (c+e,d+f)
                                              (c,d) = contaAvaliacoes lnode
                                              (e,f) = contaAvaliacoes rnode 
            