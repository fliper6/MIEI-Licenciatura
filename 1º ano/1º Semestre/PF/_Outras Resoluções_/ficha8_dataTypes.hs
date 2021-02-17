data ExpInt = Const Int                 --arvores cujas folhas são inteiros e cujos nodos (não folhas) são operadores.
             | Simetrico ExpInt
             | Mais ExpInt ExpInt
             | Menos ExpInt ExpInt
             | Mult ExpInt ExpInt
--funcao que dada uma destas expressoes calcula o seu valor.
calcula :: ExpInt -> Int
calcula (Const x) = x
calcula (Simetrico x) = (calcula x) * (-1)
calcula (Mais x y) = (calcula x) + (calcula y)
calcula (Menos x y) = (calcula x) - (calcula y)
calcula (Mult x y) = (calcula x) * (calcula y)
--função infixa de forma a que infixa (Mais (Const 3) (Menos (Const 2) (Const 5))) dê como resultado
--"(3 + (2-5)"
infixa :: ExpInt -> String
infixa (Const x) = show x
infixa (Simetrico x) = "(-" ++ infixa x ++ ")"
infixa (Mais x y ) = "(" ++ infixa x ++ " + " ++ infixa y ++ ")"
infixa (Menos x y) = "(" ++ infixa x ++ " - " ++ infixa y ++ ")"
infixa (Mult x y) = "(" ++ infixa x ++ " x " ++ infixa y ++ ")"
--defina outra função de conversão para strings, de forma a que quando aplicada à expressão acima dê
--como resultado 2e 2 5 - +)
posfixa :: ExpInt -> String
posfixa (Const x) = show x
posfixa (Simetrico x) = "-" ++ posfixa x
posfixa (Mais x y) = posfixa x ++ " " ++ posfixa y ++ " +"
posfixa (Menos x y) = posfixa x ++ " " ++ posfixa y ++ " -"
posfixa (Mult x y) = posfixa x ++ " " ++ posfixa y ++ " *"

--árvores irregulares
data RTree a = R a [RTree a]
--funcao que soma elementos da árvore
soma :: (Num a) => (RTree a) -> a
soma (R valor []) = valor
soma (R valor subNodes) = valor + (sum (map soma subNodes))
--funcao que calcula a altura da árvore
--R 12 [RTree ; RTree , RTree , RTree, RTree]
--      R12 []  R18 []  R3 []  R20 []  R5 [RTree]
--                                          R 10 []
--(R 12 [(R 18 []),(R 3 []),(R 20 []),(R 5 [(R 10 [])])])
altura :: (RTree a) -> Int
altura (R valor subNodes) = 1 + (foldl max 0 (map altura subNodes))
--funcao que remove de uma árvore a partir de uma determinada profundidade
prune :: Int -> (RTree a) -> (RTree a)
prune 1 (R x subNodes) = R x []
prune y (R x subNodes) = R x (map (prune (y-1)) subNodes)
--funcao mirror que gera a àrvore simétrica
mirror :: (RTree a) -> (RTree a)
mirror (R x subNodes) = R x (map (mirror) (reverse subNodes))
--que corresponde à travessia post order da árvore
postorder :: (RTree a) -> [a]
postorder (R x subNodes) = foldr (++) [x] (map postorder subNodes) -- foldr 

data BTree a = Empty | Node a (BTree a) (BTree a)
data LTree a = Tip a | Fork (LTree a) (LTree a)
--funcao que soma as folhas de uma árvore
ltSum :: (Num a) => (LTree a) -> a
ltSum (Tip a) = a
ltSum (Fork x y) = (ltSum x) + (ltSum y)
--funcao que lista as folhas de uma árvore (da esquerda para a direita)
listaLT :: (LTree a) -> [a]
listaLT (Tip a) = [a]
listaLT (Fork x y) = (listaLT x) ++ (listaLT y)
--funcao que calcula a altura de uma árvore
ltHeight :: (LTree a) -> Int
ltHeight (Tip a) = 1
ltHeight (Fork x y) = (ltHeight x) + (ltHeight y) --analisar questao do max

--full trees -> informação está nos nodos como também nas folhas (embora o tipo de informação nos nodos
-- e nas folhas nao necessite de ser o mesmo)
data FTree a b = Leaf b | No a (FTree a b) (FTree a b)
    deriving Show

--funcao que separa uma árvore com informação nos nodos e nas folhas em duas árvores de tipos diferentes
splitFTree :: (FTree a b) -> (BTree a, LTree b) 
splitFTree (Leaf x) = (Empty, Tip x)
splitFTree (No x l r) = (Node x l1 r1, Fork l2 r2) 
                                where (l1,l2) = splitFTree l
                                      (r1,r2) = splitFTree r
--funcao inversa da anterior, que sempre que árvores sejam compatíveis as junta numa só
joinTrees :: (BTree a) -> (LTree b) -> Maybe (FTree a b)
joinTrees Empty (Tip x) = Just (Leaf x)
joinTrees (Node x lnode rnode) (Fork l r) = case (joinTrees lnode l) of
    Nothing -> Nothing
    Just l1-> case (joinTrees rnode r) of
        Nothing -> Nothing
        Just r1 -> Just (No x l1 r1)
joinTrees _ _ = Nothing 