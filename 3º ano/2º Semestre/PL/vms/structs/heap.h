
#ifndef HEAP_H
#define HEAP_H

#include "types.h"
#include "array.h"

typedef struct heapElem{
    char c;
    heapPt next;
} HeapElem;

typedef struct heap{
    HeapElem* mem;
    int size;
    heapPt first;
} Heap;


void Heap_freeBlock(heapPt);
char* Heap_getBlock(heapPt);
heapPt Heap_alloc(char*, int);
void Heap_addPos(heapPt, Value);
void printHeap(char,int,char);

void Heap_free();
void Heap_init(int);

#endif
