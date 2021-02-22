// C program to illustrate 
// pipe system call in C 
// shared by Parent and Child 
#include <stdio.h> 
#include <unistd.h> 
#include <stdlib.h>
#include <sys/wait.h>

#define MSGSIZE 16 
char* msg1 = "hello, world #1"; 
char* msg2 = "hello, world #2"; 
char* msg3 = "hello, world #3"; 
  
int main() 
{ 
   	int pd[2];
   	pipe(pd);
   	char buf[1024];

   	if (!fork()){
   		close(pd[1]);
   		write(pd[0],"hugo\n",5);
   		_exit(0);
   	}

   	read(pd[0],buf,5);
}