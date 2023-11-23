%{
#include <stdio.h>
void yyerror(char*c);
int yylex();
%}

%union {
    int intval;
    char* strval;
}
%token AQUIACABOU EQ RECEBA DEVOLVA HORADOSHOW ENQUANTO FACA FIM
%token <strval> VARNAME
%left VARNAME
%%
program:
	RECEBA varlist DEVOLVA varlist HORADOSHOW cmds AQUIACABOU
	{
		printf("PROGRAMA!");
	}

varlist:
	VARNAME varlist | VARNAME 
	{
		printf("var: %s",($1));
	}


cmds:
	cmd cmds | cmd

cmd: ENQUANTO VARNAME FACA cmds FIM | VARNAME EQ VARNAME
%%

void yyerror(char *c)
{
	printf("ERROR: %s",c);
}

int main()
{
	yyparse();
	return 0;
}