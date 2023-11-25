show: horadoshow.y horadoshow.l lex.yy.c y.tab.c y.tab.h
	yacc -dy horadoshow.y
	lex horadoshow.l
	gcc -o horadoshow lex.yy.c y.tab.c

runshow:
	./horadoshow entrada.txt saida.c

saida: saida.c
	gcc -o resultado saida.c

runsaida:
	./resultado 1 2 3