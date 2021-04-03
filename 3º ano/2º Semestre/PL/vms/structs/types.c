
#include <glib.h>
#include <stdlib.h>
#include <stdio.h>

#include "types.h"

Value newValue(Uvalue val, Etype type){
    Value v;
    v.val = val;
    v.type = type;

    return v;
}

char* Value_toString(Value v){
    char* ret = (char*)malloc(MAX_LINE*sizeof(char));
    switch(v.type){
        case T_int      : snprintf(ret, MAX_LINE, "INT %d",      v.val.i);   break;
        case T_float    : snprintf(ret, MAX_LINE, "FLOAT %f",    v.val.f);   break;
        case T_codePt   : snprintf(ret, MAX_LINE, "CODE_PT %d",  v.val.c);   break;
        case T_heapPt   : snprintf(ret, MAX_LINE, "HEAP_PT %d",  v.val.h);   break;
        case T_opPt     : snprintf(ret, MAX_LINE, "OP_PT %d",    v.val.o);   break;
        case T_string   : snprintf(ret, MAX_LINE, "STRING \"\n%s\"",   v.val.s->str); break;
        case NOTHING    : snprintf(ret, MAX_LINE, "_ _");   break;
    }
    return ret;
}

char* Inst_toString(Einst i){
    char* ret = (char*)malloc(MAX_LINE*sizeof(char));
    switch(i){
        case ADD    : snprintf(ret, MAX_LINE, "ADD"); break;
        case SUB    : snprintf(ret, MAX_LINE, "SUB"); break;
        case MUL    : snprintf(ret, MAX_LINE, "MUL"); break;
        case DIV    : snprintf(ret, MAX_LINE, "DIV"); break;
        case MOD    : snprintf(ret, MAX_LINE, "MOD"); break;
        case NOT    : snprintf(ret, MAX_LINE, "NOT"); break;
        case INF    : snprintf(ret, MAX_LINE, "INF"); break;
        case INFEQ  : snprintf(ret, MAX_LINE, "INFEQ"); break;
        case SUP    : snprintf(ret, MAX_LINE, "SUP"); break;
        case SUPEQ  : snprintf(ret, MAX_LINE, "SUPEQ"); break;
        case FADD   : snprintf(ret, MAX_LINE, "FADD"); break;
        case FSUB   : snprintf(ret, MAX_LINE, "FSUB"); break;
        case FMUL   : snprintf(ret, MAX_LINE, "FMUL"); break;
        case FDIV   : snprintf(ret, MAX_LINE, "FDIV"); break;
        case FCOS   : snprintf(ret, MAX_LINE, "FCOS"); break;
        case FSIN   : snprintf(ret, MAX_LINE, "FSIN"); break;
        case FTAN   : snprintf(ret, MAX_LINE, "FTAN"); break;
        case FINF   : snprintf(ret, MAX_LINE, "FINF"); break;
        case FINFEQ : snprintf(ret, MAX_LINE, "FINFEQ"); break;
        case FSUP   : snprintf(ret, MAX_LINE, "FSUP"); break;
        case FSUPEQ : snprintf(ret, MAX_LINE, "FSUPEQ"); break;
        case PADD   : snprintf(ret, MAX_LINE, "PADD"); break;
        case CONCAT : snprintf(ret, MAX_LINE, "CONCAT"); break;
        case ALLOC  : snprintf(ret, MAX_LINE, "ALLOC"); break;
        case ALLOCN : snprintf(ret, MAX_LINE, "ALLOCN"); break;
        case FREE   : snprintf(ret, MAX_LINE, "FREE"); break;
        case EQUAL  : snprintf(ret, MAX_LINE, "EQUAL"); break;
        case ATOI   : snprintf(ret, MAX_LINE, "ATOI"); break;
        case ATOF   : snprintf(ret, MAX_LINE, "ATOF"); break;
        case ITOF   : snprintf(ret, MAX_LINE, "ITOF"); break;
        case FTOI   : snprintf(ret, MAX_LINE, "FTOI"); break;
        case STRI   : snprintf(ret, MAX_LINE, "STRI"); break;
        case STRF   : snprintf(ret, MAX_LINE, "STRF"); break;
        case PUSHI  : snprintf(ret, MAX_LINE, "PUSHI"); break;
        case PUSHN  : snprintf(ret, MAX_LINE, "PUSHN"); break;
        case PUSHF  : snprintf(ret, MAX_LINE, "PUSHF"); break;
        case PUSHS  : snprintf(ret, MAX_LINE, "PUSHS"); break;
        case PUSHG  : snprintf(ret, MAX_LINE, "PUSHG"); break;
        case PUSHL  : snprintf(ret, MAX_LINE, "PUSHL"); break;
        case PUSHSP : snprintf(ret, MAX_LINE, "PUSHSP"); break;
        case PUSHFP : snprintf(ret, MAX_LINE, "PUSHFP"); break;
        case PUSHGP : snprintf(ret, MAX_LINE, "PUSHGP"); break;
        case LOAD   : snprintf(ret, MAX_LINE, "LOAD"); break;
        case LOADN  : snprintf(ret, MAX_LINE, "LOADN"); break;
        case DUP    : snprintf(ret, MAX_LINE, "DUP"); break;
        case DUPN   : snprintf(ret, MAX_LINE, "DUPN"); break;
        case POP    : snprintf(ret, MAX_LINE, "POP"); break;
        case POPN   : snprintf(ret, MAX_LINE, "POPN"); break;
        case STOREL : snprintf(ret, MAX_LINE, "STOREL"); break;
        case STOREG : snprintf(ret, MAX_LINE, "STOREG"); break;
        case STORE  : snprintf(ret, MAX_LINE, "STORE"); break;
        case STOREN : snprintf(ret, MAX_LINE, "STOREN"); break;
        case CHECK  : snprintf(ret, MAX_LINE, "CHECK"); break;
        case SWAP   : snprintf(ret, MAX_LINE, "SWAP"); break;
        case WRITE  : snprintf(ret, MAX_LINE, "WRITE"); break;
        case WRITEI : snprintf(ret, MAX_LINE, "WRITEI"); break;
        case WRITES : snprintf(ret, MAX_LINE, "WRITES"); break;
        case WRITEF : snprintf(ret, MAX_LINE, "WRITEF"); break;
        case READ   : snprintf(ret, MAX_LINE, "READ"); break;
        case JUMP   : snprintf(ret, MAX_LINE, "JUMP"); break;
        case JZ     : snprintf(ret, MAX_LINE, "JZ"); break;
        case PUSHA  : snprintf(ret, MAX_LINE, "PUSHA"); break;
        case CALL   : snprintf(ret, MAX_LINE, "CALL"); break;
        case ARETURN: snprintf(ret, MAX_LINE, "RETURN"); break;
        case START  : snprintf(ret, MAX_LINE, "START"); break;
        case NOP    : snprintf(ret, MAX_LINE, "NOP"); break;
        case ERR    : snprintf(ret, MAX_LINE, "ERR"); break;
        case STOP   : snprintf(ret, MAX_LINE, "STOP"); break;
    }
    return ret;
}

HashData newHashData(codePt line){
    HashData hd = (HashData)malloc(sizeof(struct hashData));
    hd->line = line;
    return hd;
}
