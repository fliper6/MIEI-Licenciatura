
#include <stdio.h>
#include <glib.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "semantic.h"
#include "structs/code.h"
#include "structs/opStack.h"
#include "structs/callStack.h"
#include "structs/heap.h"

extern GHashTable* labels;
extern Code code;
extern OpStack opstack;
extern Heap heap;
extern FILE* dbout;

void try(int);

void semPushi(Value v) {
    OperandElem oe = newOperandElem(v);
    OpStack_push(oe);
}

void semPushn(int n) {
    int i;
    for(i=0; i<n; i++) semPushi(newValue((Uvalue)0, T_int));
}


void semPushf(Value v) {
    OperandElem oe = newOperandElem(v);
    OpStack_push(oe);
}

void semWrite(Etype type) {
    OperandElem oe = NULL;
    char *s;
    try(OpStack_pop(&oe));
    fprintf(dbout, "> OUTPUT: \"\n"); fflush(dbout);
    switch(type) {
        case T_int    : fprintf(stdout, "%d", oe->val.val.i); break;
        case T_float  : fprintf(stdout, "%f", oe->val.val.f); break;
        case T_codePt : fprintf(stdout, "%d", oe->val.val.c); break;
        case T_opPt   : fprintf(stdout, "%d", oe->val.val.o); break;
        case T_heapPt :
            s = Heap_getBlock(oe->val.val.h);
            fprintf(stdout, "%s", s);
            free(s);
            break;
        default: try(-6);
    }
    fflush(stdout);
    fprintf(dbout, "\n\"\n");
    fflush(dbout);
}

void semWritei() { semWrite(T_int);     }
void semWritef() { semWrite(T_float);   }
void semWrites() { semWrite(T_heapPt);  }

void semNot() {
    OperandElem oe = NULL;
    Uvalue uv=(Uvalue)0;
    Value v;
    try(OpStack_pop(&oe));
    switch(oe->val.type) {
        case T_int      : uv.i = (oe->val.val.i == 0); break;
        case T_float    : uv.i = (oe->val.val.f == 0); break;
        case T_codePt   : uv.i = (oe->val.val.c == 0); break;
        case T_opPt     : uv.i = (oe->val.val.o == 0); break;
        case T_heapPt   : uv.i = (oe->val.val.h == 0); break;
        default: try(-7);
    }
    v = newValue(uv, T_int);
    OpStack_push(newOperandElem(v));
}

void semEqual() {
    OperandElem top, other;
    Uvalue uv=(Uvalue)0;
    Value v;
    try(OpStack_pop(&top));
    try(OpStack_pop(&other));
    if(top->val.type != other->val.type) {
        uv.i = 0;
        v = newValue(uv, T_int);
        OpStack_push(newOperandElem(v));
    }
    else{
        switch(top->val.type) {
            case T_int      : uv.i = (top->val.val.i == other->val.val.i); break;
            case T_float    : uv.i = (top->val.val.f == other->val.val.f); break;
            case T_codePt   : uv.i = (top->val.val.c == other->val.val.c); break;
            case T_opPt     : uv.i = (top->val.val.o == other->val.val.o); break;
            case T_heapPt   : uv.i = (top->val.val.h == other->val.val.h); break;
            default: try(-8);
        }
        v = newValue(uv, T_int);
        OpStack_push(newOperandElem(v));
    }
}

void operationsInt(char op) {
    OperandElem top, other;
    Uvalue uv;
    Value v;
    try(OpStack_pop(&top));
    try(OpStack_pop(&other));
    switch(op) {
        case '+': uv.i = other->val.val.i +  top->val.val.i;    break;
        case '-': uv.i = other->val.val.i -  top->val.val.i;    break;
        case '*': uv.i = other->val.val.i *  top->val.val.i;    break;
        case '/': uv.i = other->val.val.i /  top->val.val.i;    break;
        case '%': uv.i = other->val.val.i %  top->val.val.i;    break;
        case 's': uv.i = other->val.val.i >  top->val.val.i;    break;
        case 'S': uv.i = other->val.val.i >= top->val.val.i;    break;
        case 'i': uv.i = other->val.val.i <  top->val.val.i;    break;
        case 'I': uv.i = other->val.val.i <= top->val.val.i;    break;
    }
    v = newValue(uv, T_int);
    OpStack_push(newOperandElem(v));
}

void semAdd()   { operationsInt('+'); }
void semSub()   { operationsInt('-'); }
void semMul()   { operationsInt('*'); }
void semDiv()   { operationsInt('/'); }
void semMod()   { operationsInt('%'); }
void semInf()   { operationsInt('i'); }
void semInfeq() { operationsInt('I'); }
void semSup()   { operationsInt('s'); }
void semSupeq() { operationsInt('S'); }

void operationsFloat(char op) {
    OperandElem top, other;
    Uvalue uv;
    Value v;
    try(OpStack_pop(&top));
    try(OpStack_pop(&other));
    switch(op) {
        case '+': uv.f = other->val.val.f +  top->val.val.f;    break;
        case '-': uv.f = other->val.val.f -  top->val.val.f;    break;
        case '*': uv.f = other->val.val.f *  top->val.val.f;    break;
        case '/': uv.f = other->val.val.f /  top->val.val.f;    break;
        case 's': uv.f = other->val.val.f >  top->val.val.f;    break;
        case 'S': uv.f = other->val.val.f >= top->val.val.f;    break;
        case 'i': uv.f = other->val.val.f <  top->val.val.f;    break;
        case 'I': uv.f = other->val.val.f <= top->val.val.f;    break;
    }
    v = newValue(uv, T_float);
    OpStack_push(newOperandElem(v));
}

void semFadd()   { operationsFloat('+'); }
void semFsub()   { operationsFloat('-'); }
void semFmul()   { operationsFloat('*'); }
void semFdiv()   { operationsFloat('/'); }

void semFcos() {
  OperandElem top;
  Uvalue uv;
  Value v;
  try(OpStack_pop(&top));
  uv.f = cos(top->val.val.f);
  v = newValue(uv, T_float);
  OpStack_push(newOperandElem(v));
}

void semFsin() {
  OperandElem top;
  Uvalue uv;
  Value v;
  try(OpStack_pop(&top));
  uv.f = sin(top->val.val.f);
  v = newValue(uv, T_float);
  OpStack_push(newOperandElem(v));
}

void semFtan() {
  OperandElem top;
  Uvalue uv;
  Value v;
  try(OpStack_pop(&top));
  uv.f = tan(top->val.val.f);
  v = newValue(uv, T_float);
  OpStack_push(newOperandElem(v));
}


void semFinf()   { operationsFloat('i'); }
void semFinfeq() { operationsFloat('I'); }
void semFsup()   { operationsFloat('s'); }
void semFsupeq() { operationsFloat('S'); }

void semPadd() {
    OperandElem pt, integer;
    Uvalue uv;
    try(OpStack_pop(&integer));
    try(OpStack_pop(&pt));
    if( integer->val.type != T_int ) try(-9);
    switch(pt->val.type) {
        case T_codePt:
            uv.c = pt->val.val.c + integer->val.val.i;
            OpStack_push(newOperandElem(newValue(uv, T_codePt)));
            break;
        case T_opPt:
            uv.o = pt->val.val.o + integer->val.val.i;
            OpStack_push(newOperandElem(newValue(uv, T_opPt)));
            break;
        case T_heapPt:
            uv.h = pt->val.val.h + integer->val.val.i;
            OpStack_push(newOperandElem(newValue(uv, T_heapPt)));
            break;
        default: try(-10);
    }
}

void semConcat() {
    Uvalue uv;
    char *first, *second, *res;
    int len;
    OperandElem top, other;
    try(OpStack_pop(&top));
    try(OpStack_pop(&other));
    if(top->val.type != other->val.type || top->val.type != T_heapPt) try(-1);
    first = Heap_getBlock(top->val.val.h);
    second = Heap_getBlock(other->val.val.h);
    len = strlen(first);
    len += strlen(second);
    res = (char*)malloc(len*sizeof(char));
    snprintf(res, len, "%s%s", first, second);
    uv.h = Heap_alloc(res, len);
    OpStack_push(newOperandElem(newValue(uv, T_heapPt)));
    free(first); free(second); free(res);
}

void semAlloc(int len) {
    Uvalue uv;
    int i;
    char* s = (char*)malloc(sizeof(char) * len);
    for(i=0; i < len; i++) s[i] = '0';
    uv.h = Heap_alloc(s, len);
    OpStack_push(newOperandElem(newValue(uv, T_heapPt)));
}

void semAllocn() {
    OperandElem oe;
    try(OpStack_pop(&oe));
    if(oe->val.type != T_int) try(-11);
    semAlloc(oe->val.val.i);
}

void semFree() {
    OperandElem oe;
    try(OpStack_pop(&oe));
    if(oe->val.type != T_heapPt) try(-12);
    Heap_freeBlock(oe->val.val.h);
}

void auxAtox(char x) {
    char* s;
    Uvalue uv;
    OperandElem oe;
    try(OpStack_pop(&oe));
    if(oe->val.type != T_heapPt) try(-13);
    switch(x) {
        case 'i':
            s = Heap_getBlock(oe->val.val.h);
            uv.i = atoi(s);
            OpStack_push(newOperandElem(newValue(uv, T_int)));
            break;
        case 'f':
            s = Heap_getBlock(oe->val.val.h);
            uv.i = atof(s);
            OpStack_push(newOperandElem(newValue(uv, T_float)));
            break;
    }
    free(s);
}

void semAtoi() { auxAtox('i'); }
void semAtof() { auxAtox('f'); }

void semItof() {
    Uvalue uv;
    OperandElem oe;
    try(OpStack_pop(&oe));
    if(oe->val.type != T_int) try(-14);
    uv.f = (float)1.0 * (oe->val.val.i);
    OpStack_push(newOperandElem(newValue(uv, T_float)));
}

void semFtoi() {
    Uvalue uv;
    OperandElem oe;
    try(OpStack_pop(&oe));
    if(oe->val.type != T_float) try(-15);
    uv.i = (int)(oe->val.val.f);
    OpStack_push(newOperandElem(newValue(uv, T_float)));
}

void auxStrx(char x) {
    Uvalue uv;
    OperandElem oe;
    char *s = (char*)malloc(sizeof(char) * 15);
    int len;
    try(OpStack_pop(&oe));
    switch(x) {
        case 'i':
            if(oe->val.type != T_int) try(-16);
            snprintf(s, 15, "%d", oe->val.val.i);
            break;
        case 'f':
            if(oe->val.type != T_float) try(-17);
            snprintf(s, 15, "%f", oe->val.val.f);
            break;
    }
    len = strnlen(s, 15);
    uv.h = Heap_alloc(s, len);
    OpStack_push(newOperandElem(newValue(uv, T_heapPt)));
    free(s);
}

void semStri() { auxStrx('i'); }

void semStrf() { auxStrx('f'); }

void semPushs(GString* s) {
    Uvalue uv;
    uv.h = Heap_alloc(s->str, s->len);
    OpStack_push(newOperandElem(newValue(uv, T_heapPt)));
}

void semPushg(int index) {
    OperandElem oe;
    try(OpStack_getPos(opstack.gp+index, &oe));
    OpStack_push(newOperandElem(newValue(oe->val.val, oe->val.type)));
}

void semPushl(int index) {
    OperandElem oe;
    try(OpStack_getPos((opstack.fp)+index, &oe));
    OpStack_push(newOperandElem(newValue(oe->val.val, oe->val.type)));
}

void semPushsp() {
    OpStack_push(newOperandElem(newValue((Uvalue)opstack.sp, T_opPt)));
}

void semPushfp() {
    OpStack_push(newOperandElem(newValue((Uvalue)opstack.fp, T_opPt)));
}

void semPushgp() {
    OpStack_push(newOperandElem(newValue((Uvalue)opstack.gp, T_opPt)));
}

void semLoad(int index) {
    OperandElem oe;
    OperandElem loadOE;
    try(OpStack_pop(&oe));
    switch(oe->val.type) {
        case T_heapPt:
            try( OpStack_getPos(oe->val.val.h + index, &loadOE) );
            OpStack_push(newOperandElem(newValue(loadOE->val.val, loadOE->val.type)));
        break;
        case T_opPt:
            try( OpStack_getPos(oe->val.val.o + index, &loadOE) );
            OpStack_push(newOperandElem(newValue(loadOE->val.val, loadOE->val.type)));
        break;
        default: try(-18);
    }
}

void semLoadn() {
    OperandElem oe;
    try(OpStack_pop(&oe));
    if(oe->val.type != T_int) try(-19);
    semLoad(oe->val.val.i);
}

void semDup(int i) {
    int topo = opstack.sp-1;
    OperandElem oe;
    while( i-- > 0 ) {
        try(OpStack_getPos(topo-i, &oe));
        OpStack_push(newOperandElem(newValue(oe->val.val, oe->val.type)));
    }
}

void semDupn() {
    OperandElem oe;
    try(OpStack_pop(&oe));
    if(oe->val.type != T_int) try(-20);
    semDup(oe->val.val.i);
}

void semPop(int n) {
    int i;
    OperandElem oe;
    for(i=0; i<n; i++) try(OpStack_pop(&oe));
}

void semPopn() {
    OperandElem oe;
    try(OpStack_pop(&oe));
    if(oe->val.type != T_int) try(-21);
    semPop(oe->val.val.i);
}

void semStorel(int index) {
    OperandElem oe;
    try(OpStack_pop(&oe));
    try( OpStack_addPos(opstack.fp + index, newOperandElem(newValue(oe->val.val, oe->val.type))) );
}

void semStoreg(int index) {
    OperandElem oe;
    try(OpStack_pop(&oe));
    try( OpStack_addPos(opstack.gp + index, newOperandElem(newValue(oe->val.val, oe->val.type))) );
}

void semStore(int index, OperandElem va) {
    OperandElem v, pt;
    if(va == NULL) try(OpStack_pop(&v));
    else v = va;
    try(OpStack_pop(&pt));
    switch(pt->val.type) {
        case T_heapPt:
            Heap_addPos(pt->val.val.h + index, v->val);
            break;
        case T_opPt:
            OpStack_addPos(pt->val.val.o + index, newOperandElem(newValue(v->val.val, v->val.type))); v = va;
            break;
        default: try(-22);
    }
}

void semStoren() {
    OperandElem oe, v;
    try(OpStack_pop(&v));
    try(OpStack_pop(&oe));
    if(oe->val.type != T_int) try(-23);
    semStore(oe->val.val.i, v);
}

void semSwap() {
    OperandElem top, other;
    try(OpStack_pop(&top));
    try(OpStack_pop(&other));
    OpStack_push(top);
    OpStack_push(other);
}

void semRead() {
    size_t len;
    Uvalue uv;
    char *s=NULL;
    fprintf(dbout, "> INPUT\n"); fflush(dbout);
    len = getline(&s, &len, stdin);
    s[len-1] = '\0';
    uv.h = Heap_alloc(s,len);
    OpStack_push(newOperandElem(newValue(uv, T_heapPt)));
    free(s);
}

void semJump(GString* s) {
    HashData hd = g_hash_table_lookup(labels, s->str);
    code.pc = hd->line;
}

void semJz(GString* s) {
    OperandElem oe;
    HashData hd;
    try(OpStack_pop(&oe));
    if(oe->val.type != T_int) try(-24);
    if(oe->val.val.i == 0) {
        hd = g_hash_table_lookup(labels, s->str);
        code.pc = hd->line;
    }
}

void semPusha(GString* s) {
    HashData hd = g_hash_table_lookup(labels, s->str);
    OpStack_push( newOperandElem(newValue((Uvalue)hd->line, T_codePt)) );
}

void semCall() {
    OperandElem oe;
    try(OpStack_pop(&oe));
    CallStack_push(newCallElem(code.pc, opstack.fp));
    if(oe->val.type != T_codePt) try(-25);
    code.pc = oe->val.val.c;
    opstack.fp = opstack.sp;
    printOpStack(oe, '_', opstack.sp);
}

void semReturn() {
    CallElem ce;
    CallStack_pop(&ce);
    int i = opstack.sp - opstack.fp;
    semPop(i);
    code.pc = ce->pc;
    opstack.fp = ce->fp;
}

void semStart() {
    opstack.fp = opstack.sp;
}

void semNop() { ; }

void semErr(GString* s) {
  fprintf(dbout, "> OUTPUT: \"\n"); fflush(dbout);
  fprintf(stdout, "%s", s->str);
  fflush(stdout);
  fprintf(dbout, "\n\"\n");
  fflush(dbout);
}

void semStop() {code.pc = code.pc-1;}

void semCheck() { }
