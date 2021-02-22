//1********************************************************************
preenchimento por colunas(� standard) de uma matriz
A<-1:12
dim(A)=c(3,4)

preenchimento por linhas de uma matriz
B<-matrix(1:12,nc=4,nr=3,byrow=T)
//a)------------------------------------------------------------------
A+B //soma das duas matrizes

TA<-t(A) //matriz transposta de A

A%*%TA //produto matricial, s� funciona com dimens�es id�nticas
//b)------------------------------------------------------------------
A[2,3] //indexa��o com par�nteses retos

A[2,] //2� linha

A[,1] // 1� coluna

//c)------------------------------------------------------------------
A[,1]<-0

B[B%%2==0]<-0

//2********************************************************************
 nul6<-matrix(0,nr=6,nc=6)
OU
nul1<-rep(0,36)
dim(nul1)=c(6,6)
//a)-------------------------------------------------------------------
c<-col(nul6)-row(nul6)
c<-abs(c)
c[c!=1]<-0
m<-c
//b)--------------------------------------------------------------------
diag(m)<-1:6

//c)--------------------------------------------------------------------
SM<-m[c(T,F),c(F,T)]

rownames(m)<-pasteo("row",1:6)// dar nome �s linhas da matriz
colnames(m)<-paste0("col",1:6)// " " " colunas

m[,"col6"]//d�-nos o que est� na coluna 6

//d)--------------------------------------------------------------------
which(m%%2==0,arr.ind=T)

//3*********************************************************************
outer(x,y,f)//basicamente um map nos dois vetores
Exemplo:
f<-function(x,y){
cos(x)/(x+y)}
outer(x,y,f)
f(1:5,0)//1�coluna
f(1:5,1)//2�coluna

//a)-------------------------------------------------------------------
A<-outer(0:4,0:4,"+")

B<-outer(1:4,0:4,"*")

//b)--------------------------------------------------------------------
apply(B,2,mean)//aplica �s colunas a fun��o mean
colSums(B)//devolve a soma dos elementos de cada coluna
rowSums(B)//devolve a soma dos elementos de cada linhas























