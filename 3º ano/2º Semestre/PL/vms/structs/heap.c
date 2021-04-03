
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

#include "heap.h"

extern Heap heap;
extern FILE* dbout;

HeapElem* get(heapPt pt){
//((heap.mem)[pt]).c == '\0' ||
    if( pt<0 || pt>heap.size) return NULL;
    return &(heap.mem[pt]);
}

char* Heap_getBlock(heapPt pt){
    HeapElem *he=NULL, *prox=NULL;
    int i, len = 100;
    char* ret = (char*)malloc(len*sizeof(char));
    for(i=0, prox=&(heap.mem[pt]); (prox->c)!='\0'; prox = get(he->next), i++){
        he = prox;
        ret[i] = he->c;
    }
    ret[i] = '\0';
    return ret;
}

void Heap_freeBlock(heapPt pt){
    HeapElem *he=NULL, *prox=NULL;
    if( (prox = get(pt)) == NULL ) return;
    printHeap('~', pt, '\0');
    for(prox=get(pt); prox; prox=get(he->next)){
        he = prox;
        if(he->c=='\0') break;
        he->c = '\0';
        printHeap('~', he->next, '\0');
    }

    (heap.mem)[he->next].next = heap.first;
    heap.first = pt;
}

void alloc(char c){
    int size = heap.size;
    HeapElem* he;
    if(heap.first == size){
        heap.size *= 2;
        heap.mem = (HeapElem*)realloc( heap.mem, (heap.size)*sizeof(HeapElem) );
        //inizializar nova heap com \0 e a apontar pra o prox
        while(size < heap.size){
            he = get(size);
            he->c = '\0';
            he->next = size+1;
            size++;
        }
    }
    printHeap('+', heap.first, c);
    he = get(heap.first);
    he->c = c;
    heap.first = he->next;
}

heapPt Heap_alloc(char* s, int len){
    heapPt ret = heap.first;
    int i=0;
    while(i<len) alloc(s[i++]);
    alloc('\0');
    return ret;
}

void add(heapPt pt, char c){
    HeapElem* he;
    printHeap('~', pt, c);
    he = get(pt);
    he->c = c;
}
void Heap_addPos(heapPt pt, Value v){
    char *buffer;
    int len, i;
    switch(v.type){
        case T_int:
            len = asprintf(&buffer, "%d", v.val.i);
		break;
        case T_float:
            len = asprintf(&buffer, "%f", v.val.f);
		break;
        case T_string:
            buffer = v.val.s->str;
            len = v.val.s->len;
		break;
        case T_codePt:
            len = asprintf(&buffer, "%d", v.val.c);
		break;
        case T_opPt:
            len = asprintf(&buffer, "%d", v.val.o);
		break;
        case T_heapPt:
            len = asprintf(&buffer, "%d", v.val.h);
		break;
        default: len = asprintf(&buffer, "");
    }
    for(i=0; i<len; i++) add(pt+i, buffer[i]);
    add(pt+i, '\0');
}



void Heap_init(int size){
    int i=0;
    HeapElem* he;
    heap.mem = (HeapElem*)malloc(size*sizeof(HeapElem));
    heap.size = size;
    heap.first = 0;
    while(i < heap.size){
        he = &((heap.mem)[i]);
        he->c = '\0';
        he->next = i+1;
        i++;
    }
}

void Heap_free() {
    free(heap.mem);
}

void printHeap(char signal, int index, char c){
    fprintf(dbout, "> HEAP %c %d \"\n%c\n\"\n", signal, index, c);
    fflush(dbout);
}
