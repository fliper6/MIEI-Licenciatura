
#ifndef ARRAY_H
#define ARRAY_H

typedef struct array {
    int len;
    int allocSize;
    void** array;
} Array;

int  Array_remove(Array*, int, void**);
int  Array_getPos(Array*, int, void**);
int  Array_addPos(Array*, int, void*);
void Array_add(Array*, void*);

void Array_init(Array*, int);
void Array_free(Array*);

#endif
