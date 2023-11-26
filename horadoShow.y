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
	FIM
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
%token <strval> VARNAME
%type <listVal> varlist cmds  
%type <strval> cmd
%left VARNAME

%%

program:
	RECEBA varlist DEVOLVA varlist HORADOSHOW cmds AQUIACABOU
	{
		fprintf(output,"#include <stdio.h>\n #include <stdlib.h>\n #include <string.h>\n  int main(int argc,char** argv){\n");
		StringList*	node = $2;
		int contVars = 1;
		
		while(node != NULL){
			printf("int %s; \n",node->string);
			fprintf(output,"int %s=atoi(argv[%d]); \n",node->string,contVars);
			node = node->next;
			contVars++;
		}

		node = $6;
		while(node != NULL){
			printf("%s \n",node->string);
			fprintf(output,"%s",node->string);
			
			node = node->next;
		}

		node = $4;
		while(node != NULL){
			printf("%s \n",node->string);
			fprintf(output,"printf(\"%%d\",%s);\n",node->string);
		
			node = node->next;
		}

		fprintf(output,"}");
		printf("PROGRAMA!");
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

cmd: 
	ENQUANTO VARNAME FACA cmds FIM
	{
		StringList *node = (StringList*) malloc(sizeof(StringList));
		int sizeComandos = 0;

		node = $4;
		printf("antes while\n");
		while(node != NULL){
			sizeComandos += strlen(node->string);
			node = node->next;
 		}

   		char *buf = (char*) malloc(sizeof(char) * sizeComandos + 100 );
		printf("%s dps do primeiro white \n",buf);
		strcat(buf,"while(");
		strcat(buf, $2);
		strcat(buf,"){\n");
 		
		node = $4;
		while(node != NULL){
			strcat(buf,node->string);
			node= node->next;
		}
		printf("%s dps do segundo while\n",buf);
		
		strcat(buf,"}\n");
		$$ = strdup(buf);
	}
	
	| ENQUANTO cmd FACA cmds FIM
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
		strcat(buf, $2);
		strcat(buf,"){\n");
		
		node = $4;
		while(node != NULL){
			strcat(buf,node->string);
			node= node->next;
		}
		
		strcat(buf,"}\n");
		$$ = strdup(buf);
	}
		
	| VARNAME EQ VARNAME
	{
		char buf[500];
    	sprintf(buf,"%s = %s;\n",$1,$3);
		$$ = strdup(buf);
	}
	
	| VARNAME EQ cmds
	{ 
		StringList *node = (StringList*) malloc(sizeof(StringList));
		int sizeComandos = 0;
		
		node = $3;
		while(node != NULL) {
			sizeComandos += strlen(node->string);
			node = node->next;
		}
		
		char *buf = (char*) malloc(sizeof(char) * sizeComandos + 100 );
		strcat (buf, $1);
		strcat (buf, "=");
		
		node = $3;
		while (node != NULL) {
			strcat (buf, node->string);
			node = node->next;
		}
		
		$$ = strdup (buf);
	}

	| ZERA ABREPAR VARNAME FECHAPAR 
	{
		char buf[500];
		sprintf(buf,"%s = 0",$3);
    	$$ = strdup(buf);
	} 
	
	| SE cmd ENTAO cmds
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
		strcat(buf, $2);
		strcat(buf,"){\n");
		
		node = $4;
		while(node != NULL){
			strcat(buf,node->string);
			node= node->next;
		}
		
		strcat(buf,"}\n");
		$$ = strdup(buf);
	}	 
	
	| SE cmd ENTAO cmds SENAO cmds
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
		strcat(buf, $2);
		strcat(buf,"){\n");
		
		node = $4;
		while(node != NULL){
			strcat(buf,node->string);
			node = node->next;
		}
		
		strcat(buf,"}\n");
		strcat(buf,"else{\n");
		
		node = $6;
		while(node != NULL){
			strcat(buf,node->string);
			node = node->next;
		}
		
		strcat(buf,"}\n");
		$$ = strdup(buf);
	}
	
	| EXECUTE ABREPAR VARNAME VIRGULA cmds FECHAPAR 
	{
		printf("ASASASASAS");

		StringList *node = (StringList*) malloc(sizeof(StringList));
		int sizeComandos = 0;
		
		node = $5;
		while(node != NULL){
			sizeComandos += strlen(node->string);
			node = node->next;
		}
   		
		char *buf = (char*) malloc(sizeof(char)*sizeComandos + 100 );
		printf("ASASASASAS");
		strcat(buf,"int cont=0;\n");
		strcat(buf,"while(cont<");
		strcat(buf,$3);
		strcat(buf,"){\n");
		
		node = $5;
		while(node != NULL){
			strcat(buf,node->string);
			node = node->next;
		}
		
		strcat(buf,"}\n");
		$$ = strdup(buf);
 	}
	
	| GT ABREPAR VARNAME VIRGULA VARNAME FECHAPAR 
	{
		char buf[500];
		sprintf(buf,"%s > 0",$3);
    	$$ = strdup(buf);
	} 
	
	| LT ABREPAR VARNAME VIRGULA VARNAME FECHAPAR 
	{
		char buf[500];
		sprintf(buf,"%s < 0",$3);
    	$$ = strdup(buf);
	} 
	
	| GE ABREPAR VARNAME VIRGULA VARNAME FECHAPAR 
	{
		char buf[500];
		sprintf(buf,"%s >= 0",$3);
    	$$ = strdup(buf);
	}
	 
	| LE ABREPAR VARNAME VIRGULA VARNAME FECHAPAR 
	{
		char buf[500];
		sprintf(buf,"%s <= 0",$3);
    	$$ = strdup(buf);
	} 

	| MULT ABREPAR VARNAME VIRGULA VARNAME FECHAPAR
	{
		char buf[500];
		sprintf(buf, "%s * %s;\n", $3,$5);
		$$ = strdup(buf);
	}

	| SOMA ABREPAR VARNAME VIRGULA VARNAME FECHAPAR
	{
		char buf[500];
		sprintf(buf, "%s + %s;\n", $3,$5);
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