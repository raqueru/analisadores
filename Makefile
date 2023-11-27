show: horadoShow.y horaDoShow.l lex.yy.c y.tab.c y.tab.h
	yacc -dy horadoShow.y
	lex horaDoShow.l
	gcc -o horadoshow.exe lex.yy.c y.tab.c

runshow:
	./horadoshow.exe entrada.txt saida.c

saida: saida.c
	gcc -o resultado.exe saida.c

runsaida:
	./resultado.exe 1 2 3