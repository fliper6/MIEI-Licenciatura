/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    _ADD = 258,
    _SUB = 259,
    _MUL = 260,
    _DIV = 261,
    _MOD = 262,
    _NOT = 263,
    _INF = 264,
    _INFEQ = 265,
    _SUP = 266,
    _SUPEQ = 267,
    _FADD = 268,
    _FSUB = 269,
    _FSIN = 270,
    _FCOS = 271,
    _FTAN = 272,
    _FMUL = 273,
    _FDIV = 274,
    _FINF = 275,
    _FINFEQ = 276,
    _FSUP = 277,
    _FSUPEQ = 278,
    _PADD = 279,
    _CONCAT = 280,
    _ALLOC = 281,
    _ALLOCN = 282,
    _FREE = 283,
    _EQUAL = 284,
    _ATOI = 285,
    _ATOF = 286,
    _ITOF = 287,
    _FTOI = 288,
    _STRI = 289,
    _STRF = 290,
    _PUSHI = 291,
    _PUSHN = 292,
    _PUSHF = 293,
    _PUSHS = 294,
    _PUSHG = 295,
    _PUSHL = 296,
    _PUSHSP = 297,
    _PUSHFP = 298,
    _PUSHGP = 299,
    _LOAD = 300,
    _LOADN = 301,
    _DUP = 302,
    _DUPN = 303,
    _POP = 304,
    _POPN = 305,
    _STOREL = 306,
    _STOREG = 307,
    _STORE = 308,
    _STOREN = 309,
    _CHECK = 310,
    _SWAP = 311,
    _WRITEI = 312,
    _WRITEF = 313,
    _WRITES = 314,
    _READ = 315,
    _READI = 316,
    _READF = 317,
    _READS = 318,
    _JUMP = 319,
    _JZ = 320,
    _PUSHA = 321,
    _CALL = 322,
    _ARETURN = 323,
    _START = 324,
    _NOP = 325,
    _ERR = 326,
    _STOP = 327,
    _INT = 328,
    _FLOAT = 329,
    _STRING = 330,
    _LABEL = 331
  };
#endif
/* Tokens.  */
#define _ADD 258
#define _SUB 259
#define _MUL 260
#define _DIV 261
#define _MOD 262
#define _NOT 263
#define _INF 264
#define _INFEQ 265
#define _SUP 266
#define _SUPEQ 267
#define _FADD 268
#define _FSUB 269
#define _FSIN 270
#define _FCOS 271
#define _FTAN 272
#define _FMUL 273
#define _FDIV 274
#define _FINF 275
#define _FINFEQ 276
#define _FSUP 277
#define _FSUPEQ 278
#define _PADD 279
#define _CONCAT 280
#define _ALLOC 281
#define _ALLOCN 282
#define _FREE 283
#define _EQUAL 284
#define _ATOI 285
#define _ATOF 286
#define _ITOF 287
#define _FTOI 288
#define _STRI 289
#define _STRF 290
#define _PUSHI 291
#define _PUSHN 292
#define _PUSHF 293
#define _PUSHS 294
#define _PUSHG 295
#define _PUSHL 296
#define _PUSHSP 297
#define _PUSHFP 298
#define _PUSHGP 299
#define _LOAD 300
#define _LOADN 301
#define _DUP 302
#define _DUPN 303
#define _POP 304
#define _POPN 305
#define _STOREL 306
#define _STOREG 307
#define _STORE 308
#define _STOREN 309
#define _CHECK 310
#define _SWAP 311
#define _WRITEI 312
#define _WRITEF 313
#define _WRITES 314
#define _READ 315
#define _READI 316
#define _READF 317
#define _READS 318
#define _JUMP 319
#define _JZ 320
#define _PUSHA 321
#define _CALL 322
#define _ARETURN 323
#define _START 324
#define _NOP 325
#define _ERR 326
#define _STOP 327
#define _INT 328
#define _FLOAT 329
#define _STRING 330
#define _LABEL 331

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 19 "syntax.y" /* yacc.c:1909  */

    int i;
    float f;
    GString* s;

#line 212 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
