#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc,char** argv){
int X=atoi(argv[1]);
int T=atoi(argv[2]);
int R=atoi(argv[3]);
int Z=atoi(argv[4]);
int A=atoi(argv[5]);
NUM = 0;
RESULT = 1;
while(X > NUM){
NUM = NUM + 1;
RESULT = RESULT * NUM;
Z = RESULT;
}
;
printf("%d",Z);
printf("%d",A);
}