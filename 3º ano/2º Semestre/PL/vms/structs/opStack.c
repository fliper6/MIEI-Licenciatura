
#include <stdlib.h>
#include "opStack.h"

#include <stdio.h>

extern OpStack opstack;
extern FILE* dbout;

extern void try(int);

int OpStack_pop(OperandElem* ret){
    if(opstack.sp == opstack.fp) return -3;
    opstack.sp -= 1;
    try(Array_remove(&(opstack.stack), opstack.sp, (void**)ret));
    printOpStack(*ret, '-', opstack.sp);
    return 0;
}

int OpStack_top(OperandElem* ret){
    return Array_getPos(&(opstack.stack), opstack.sp-1, (void**)ret);
}

int OpStack_getPos(int index, OperandElem* ret){
    return Array_getPos(&(opstack.stack), index, (void**)ret);
}

int OpStack_addPos(int index, OperandElem oe){
    printOpStack(oe, '~', index);
    return Array_addPos(&(opstack.stack), index, oe);
}

void OpStack_push(OperandElem oe){
    Array_add(&(opstack.stack), oe);
    printOpStack(oe, '+', opstack.sp);
    opstack.sp += 1;
}


void OpStack_init(int size){
    Array_init(&(opstack.stack), size);
    opstack.sp = 0;
    opstack.fp = 0;
    opstack.gp = 0;
}
void OpStack_free(){
    Array_free(&opstack.stack);
}


OperandElem newOperandElem(Value v){
    OperandElem oe = (OperandElem)malloc(sizeof(struct operandElem));
    oe->val = v;
    return oe;
}

void printOpStack(OperandElem oe, char signal, int index){
    fprintf(dbout, "> OPSTACK %c %d %s %d %d %d\n", signal, index, Value_toString(oe->val), opstack.sp, opstack.fp, opstack.gp);
    fflush(dbout);
}
