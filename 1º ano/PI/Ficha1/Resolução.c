#include <stdio.h> 
int main () {
/*
//--1
  //--1 
    int x , y ;
	x = 3;
	y = x +1;
	x = x*y; y = x + y;
	printf ( "%d %d\n", x, y ) ;

//--2
  //--1
	//--a
    int x , y ;
    x = 3; y = 5;
    if ( x > y )
     y = 6;
    printf ( "%d %d \n", x, y ) ;
    //--b
    x = y = 0;
    while ( x != 11) {
    x = x +1; y += x ;
    }
    printf ( "%d %d \n", x, y ) ;
*/
  //--2
    for (int i = 0; i < 5; i++) {
    	for (int j = 0; j < 5; j++)
    		putchar("#");
    
    putchar('\n');}
}
 

























