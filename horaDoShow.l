%{
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
void yyerror(char* c);
%}


%%


RECEBA {return RECEBA;}
DEVOLVA {return DEVOLVA;}
HORADOSHOW {return HORADOSHOW;}
ENQUANTO {return ENQUANTO;}
FACA {return FACA;}
FIM {return FIM;}
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