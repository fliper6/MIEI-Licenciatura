
#ifndef OPSTACK_H
#define OPSTACK_H

#include "types.h"
#include "array.h"

typedef struct operandElem{
    Value val;
} *OperandElem;

typedef struct opStack{
    Array stack;
    opPt sp;
    opPt fp;
    opPt gp;
} OpStack;



int OpStack_pop(OperandElem*);
int OpStack_top(OperandElem*);
int OpStack_getPos(int, OperandElem*);
int OpStack_addPos(int, OperandElem);
void OpStack_push(OperandElem);

OperandElem newOperandElem(Value);
void OpStack_init(int);
void OpStack_free();
void printOpStack(OperandElem,char,int);

#endif
