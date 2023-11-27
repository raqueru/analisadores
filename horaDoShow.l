%{
#include "stringlist.h"
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
void yyerror(char* c);
%}


%%


RECEBA {return RECEBA;}
DEVOLVA {return DEVOLVA;}
HORADOSHOW {return HORADOSHOW;}
SE {return SE;}
ENTAO {return ENTAO;} 
SENAO {return SENAO;}
ENQUANTO {return ENQUANTO;}
\( {return ABREPAR;}
\) {return FECHAPAR;}
FACA {return FACA;}
FIMENQUANTO {return FIMENQUANTO;}
, {return VIRGULA;}
GT {return GT;}
LT {return LT;}
ZERA { return ZERA;}
GE {return GE;}
FIMSE {return FIMSE;}
LE {return LE;}
AQUIACABOU {return AQUIACABOU;}
MULT {return MULT;}
SOMA {return SOMA;}
EXECUTE {return EXECUTE;}
= {return EQ;}

[a-zA-Z]([a-zA-Z0-9])* {
	yylval.strval = strdup(yytext);
	return VARNAME;
	
	}
[0-9]+ {
    yylval.strval = strdup(yytext);
    return NUMBER; 
}	
%%
 
int yywrap()
{
	return 1;
}