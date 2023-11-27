#ifndef _yy_defines_h_
#define _yy_defines_h_

#define AQUIACABOU 257
#define EQ 258
#define RECEBA 259
#define DEVOLVA 260
#define HORADOSHOW 261
#define ENQUANTO 262
#define FACA 263
#define FIMENQUANTO 264
#define VIRGULA 265
#define GT 266
#define LT 267
#define GE 268
#define LE 269
#define ABREPAR 270
#define FECHAPAR 271
#define ZERA 272
#define SE 273
#define ENTAO 274
#define SENAO 275
#define MULT 276
#define SOMA 277
#define EXECUTE 278
#define FIMSE 279
#define VARNAME 280
#define NUMBER 281
#ifdef YYSTYPE
#undef  YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#endif
#ifndef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
typedef union YYSTYPE {
	StringList* listVal;
    int intval;
    char* strval;
} YYSTYPE;
#endif /* !YYSTYPE_IS_DECLARED */
extern YYSTYPE yylval;

#endif /* _yy_defines_h_ */
