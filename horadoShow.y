%{
#include "stringlist.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int yylex();	
void yyerror(char *c);
extern FILE *yyin; 
extern int yyparse();
FILE *output;
%}
 
%union {
	StringList* listVal;
    int intval;
    char* strval;
}

 
%token AQUIACABOU
	EQ
	RECEBA
	DEVOLVA
	HORADOSHOW
	ENQUANTO
	FACA
	FIMENQUANTO
	VIRGULA
	GT
	LT
	GE
	LE
	ABREPAR
	FECHAPAR
	ZERA
	SE
	ENTAO
	SENAO
	MULT
	SOMA
	EXECUTE
	FIMSE
%token <strval> VARNAME NUMBER 
%type <listVal> varlist cmds exp   
%type <strval> cmd   
%left VARNAME  

%%

program:
	RECEBA varlist DEVOLVA varlist HORADOSHOW cmds AQUIACABOU
	{
		fprintf(output,"#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\nint main(int argc,char** argv){\n");
		StringList*	node = $2;
		StringList* nodeD = $4;
		int contVars = 1;

		while(node != NULL){
 			fprintf(output,"int %s=atoi(argv[%d]);\n",node->string,contVars);
			node = node->next;
			contVars++;
		}

		while(nodeD != NULL){
 			fprintf(output,"int %s=atoi(argv[%d]);\n",nodeD->string,contVars);
			nodeD = nodeD->next;
			contVars++;
		}

		node = $6;
		while(node != NULL){
 			fprintf(output,"%s",node->string);
			fprintf(output,";\n");

			node = node->next;
		}

		node = $4;
		while(node != NULL){
 			fprintf(output,"printf(\"%%d\",%s);\n",node->string);
			node = node->next;
		}

		fprintf(output,"}");
		printf("FIM DO PROGRAMA!\n");
	}

varlist:
	VARNAME VIRGULA varlist 
	{
		StringList *node = (StringList*) malloc(sizeof(StringList));
		node->string = $1;
		node->next = $3;
		$$ = node;
		printf("int %s; \n ",($1));
	}
	
	| VARNAME 
	{
		StringList *node = (StringList*) malloc(sizeof(StringList));
		node->string = $1;
		node->next = NULL;
		$$ = node;
	}

cmds:
	cmd cmds 
	{
		StringList *node = (StringList*) malloc(sizeof(StringList));
		node->string = $1;
		node->next = $2;
		$$ = node;
	}
	
	| cmd
	{
		StringList *node = (StringList*) malloc(sizeof(StringList));
		node->string = $1;
		node->next = NULL;
		$$ = node;
	}
exp:
	cmd{
	StringList *node = (StringList*) malloc(sizeof(StringList));
		node->string = $1;
		node->next = NULL;
		$$ = node;

	}
	|VARNAME{
		StringList *node = (StringList*) malloc(sizeof(StringList));
		node->string = $1;
		node->next = NULL;
		$$ = node;
	}
	|NUMBER{
		StringList *node = (StringList*) malloc(sizeof(StringList));
		node->string = $1;
		node->next = NULL;
		$$ = node;
	}
cmd: 
	ENQUANTO exp FACA cmds FIMENQUANTO
	{
		StringList *node = (StringList*) malloc(sizeof(StringList));
		int sizeComandos = 0;

		node = $4;
		while(node != NULL){
			sizeComandos += strlen(node->string);
			node = node->next;
		}

   		char *buf = (char*) malloc(sizeof(char) * sizeComandos + 100 );
		strcat(buf,"while(");
		strcat(buf, $2->string);
		strcat(buf,"){\n");
		node = $4;
		while(node != NULL){
			strcat(buf,node->string);
			strcat(buf,";\n");

			node= node->next;
		}
		strcat(buf,"}\n");
		$$ = strdup(buf);
	}

		
	| VARNAME EQ exp
	{
		char buf[500];
		sprintf(buf,"%s = %s",$1,$3->string);
		$$ = strdup(buf);
	} 

	| ZERA ABREPAR VARNAME FECHAPAR 
	{
		char buf[500];
		sprintf(buf,"%s = 0",$3);
    	$$ = strdup(buf);
	} 
	
	| SE exp ENTAO cmds FIMSE
	{
		StringList *node = (StringList*) malloc(sizeof(StringList));
		int sizeComandos = 0;
		
		node = $4;
		while(node != NULL){
			sizeComandos += strlen(node->string);
			node = node->next;
		}

   		char *buf = (char*) malloc(sizeof(char) * sizeComandos + 100 );
		strcat(buf,"if(");
		strcat(buf, $2->string);
		strcat(buf,"){\n");
		
		node = $4;
		while(node != NULL){
			strcat(buf,node->string);
			strcat(buf,";\n");

			node= node->next;
		}
		
		strcat(buf,"}\n");
		$$ = strdup(buf);
	}	 
	
	| SE exp ENTAO cmds SENAO cmds FIMSE
	{
		StringList *node = (StringList*) malloc(sizeof(StringList));
		int sizeComandosIf = 0;
		int sizeComandosElse = 0;
		node = $4;
		while(node != NULL){
			sizeComandosIf += strlen(node->string);
			node = node->next;
		}
		node = $6;
		while(node != NULL){
			sizeComandosElse += strlen(node->string);
			node = node->next;
		}

		char *buf = (char*) malloc(sizeof(char)*sizeComandosIf + sizeof(char) * sizeComandosElse+ 100 );
		strcat(buf,"if(");
		strcat(buf, $2->string);
		strcat(buf,"){\n");
		
		node = $4;
		while(node != NULL){
			strcat(buf,node->string);
			strcat(buf,";\n");

			node = node->next;
		}
		
		strcat(buf,"}\n");
		strcat(buf,"else{\n");
		
		node = $6;
		while(node != NULL){
			strcat(buf,node->string);
			strcat(buf,";\n");
			node = node->next;
		}
		
		strcat(buf,"}\n");
		$$ = strdup(buf);
	}
	| EXECUTE ABREPAR exp VIRGULA cmds FECHAPAR 
	{
		StringList *node = (StringList*) malloc(sizeof(StringList));
		int sizeComandos = 0;
		node = $5;
		while(node != NULL){
			sizeComandos += strlen(node->string);
			node = node->next;
		}
		char *buf = (char*) malloc(sizeof(char)*sizeComandos + 100 );
		strcat(buf,"for(int cont=0;cont<");
		strcat(buf,$3->string);
		strcat(buf,";cont++){\n");	
		node = $5;
		while(node != NULL){
			strcat(buf,node->string);
			node = node->next;
			strcat(buf,";\n");

		}	
		strcat(buf,"}\n");
		$$ = strdup(buf);
	}
	
	| GT ABREPAR exp VIRGULA exp FECHAPAR 
	{
		char buf[500];
		sprintf(buf,"%s > %s", $3->string,$5->string);
    	$$ = strdup(buf);
	} 
	
	| LT ABREPAR exp VIRGULA exp FECHAPAR 
	{
		char buf[500];
		sprintf(buf,"%s < %s" ,$3->string,$5->string);
    	$$ = strdup(buf);
	} 
	
	| GE ABREPAR exp VIRGULA exp FECHAPAR 
	{
		char buf[500];
		sprintf(buf,"%s >= %s" ,$3->string,$5->string);
    	$$ = strdup(buf);
	}

	| LE ABREPAR exp VIRGULA exp FECHAPAR 
	{
		char buf[500];
		sprintf(buf,"%s <= %s", $3->string,$5->string);
    	$$ = strdup(buf);
	} 

	| MULT ABREPAR exp VIRGULA exp FECHAPAR
	{
		char buf[500];
		sprintf(buf, "%s * %s", $3->string,$5->string);
		$$ = strdup(buf);
	}

	| SOMA ABREPAR exp VIRGULA exp FECHAPAR
	{
		char buf[500];
		sprintf(buf, "%s + %s", $3->string,$5->string);
		$$ = strdup (buf);
	}
 
%%

void yyerror(char *c)
{
	printf("ERROR: %s",c);
}

int main(int argc, char* argv[]){
    
    if(argc !=3){
        printf("ERRO: QUANTIDADE DE PARAMETROS INVALIDA, FAVOR INSERIR COMO NO EXEMPLO ABAIXO:\n");
        printf("=>   ./<nome_do_executavel> entrada.txt saida.txt \n");
        return 0;
    }

    /*
	argv[0] -->	nome do executavel
    argv[1] --> entrada.txt
    argv[2] --> saida.txt
    */

    printf("Realizando abertura do arquivo de entrada...");
    
    FILE *input = fopen(argv[1],"r");
    output = fopen(argv[2],"w");
	
    if(input == NULL){
        printf(" ERRO\n");
        exit(1);
    }else printf(" OK!\n");
    
    printf("Realizando abertura do arquivo de saida...");
    
    if(output == NULL){
        printf(" ERRO\n");
        exit(1);
    }else printf(" OK!\n");

    yyin = input;
    yyparse();

    fclose(input);
    fclose(output);

    return 0;
}