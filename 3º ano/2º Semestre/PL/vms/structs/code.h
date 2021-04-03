
#ifndef CODE_H
#define CODE_H

#include "types.h"
#include "array.h"

typedef struct codeElem{
    Einst inst;
    Value first;
    Value second;
} *CodeElem;

typedef struct code{
    Array array;
    codePt pc;
} Code;

void Code_add(CodeElem);
int  Code_get(CodeElem*);
char* Code_toString(CodeElem);
void Code_free();

void Code_init(int);
CodeElem newCodeElem(Einst, Value, Value);
void printCode(CodeElem ce, char signal, int index);

#endif
