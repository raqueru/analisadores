/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    AQUIACABOU = 258,              /* AQUIACABOU  */
    EQ = 259,                      /* EQ  */
    RECEBA = 260,                  /* RECEBA  */
    DEVOLVA = 261,                 /* DEVOLVA  */
    HORADOSHOW = 262,              /* HORADOSHOW  */
    ENQUANTO = 263,                /* ENQUANTO  */
    FACA = 264,                    /* FACA  */
    FIM = 265,                     /* FIM  */
    VIRGULA = 266,                 /* VIRGULA  */
    GT = 267,                      /* GT  */
    LT = 268,                      /* LT  */
    GE = 269,                      /* GE  */
    LE = 270,                      /* LE  */
    ABREPAR = 271,                 /* ABREPAR  */
    FECHAPAR = 272,                /* FECHAPAR  */
    ZERA = 273,                    /* ZERA  */
    SE = 274,                      /* SE  */
    ENTAO = 275,                   /* ENTAO  */
    SENAO = 276,                   /* SENAO  */
    MULT = 277,                    /* MULT  */
    SOMA = 278,                    /* SOMA  */
    VARNAME = 279                  /* VARNAME  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define AQUIACABOU 258
#define EQ 259
#define RECEBA 260
#define DEVOLVA 261
#define HORADOSHOW 262
#define ENQUANTO 263
#define FACA 264
#define FIM 265
#define VIRGULA 266
#define GT 267
#define LT 268
#define GE 269
#define LE 270
#define ABREPAR 271
#define FECHAPAR 272
#define ZERA 273
#define SE 274
#define ENTAO 275
#define SENAO 276
#define MULT 277
#define SOMA 278
#define VARNAME 279

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 17 "horadoshow.y"

	StringList* listVal;
    int intval;
    char* strval;

#line 121 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
