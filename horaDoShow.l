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
FIM {return FIM;}
, {return VIRGULA;}
\> {return GT;}
\< {return LT;}
ZERA { return ZERA;}
\>= {return GE;}
\<= {return LE;}
AQUIACABOU {return AQUIACABOU;}
= {return EQ;}

[a-zA-Z]([a-zA-Z0-9])* {
	yylval.strval = strdup(yytext);
	return VARNAME;
	}

%%

int yywrap()
{
	return 1;
}