
#include <stdlib.h>
#include "callStack.h"

#include <stdio.h>


extern CallStack callstack;
extern FILE* dbout;

extern void try(int);

void CallStack_pop(CallElem* ret) {
    try(Array_remove(&(callstack.stack), callstack.stack.len-1, (void**)ret));
    printCallStack(*ret, '-');
}

void CallStack_push(CallElem ce){
    Array_add(&(callstack.stack), ce);
    printCallStack(ce, '+');
}

void CallStack_init(int size) {
    Array_init(&(callstack.stack), size);
}

void CallStack_free() {
    Array_free(&callstack.stack);
}


CallElem newCallElem(codePt pc, opPt fp){
    CallElem ce = (CallElem)malloc(sizeof(struct callElem));
    ce->pc = pc;
    ce->fp = fp;
    return ce;
}

void printCallStack(CallElem ce, char signal) {
    fprintf(dbout, "> CALLSTACK %c %d %d %d\n", signal, callstack.stack.len , ce->pc, ce->fp);
    fflush(dbout);
}
