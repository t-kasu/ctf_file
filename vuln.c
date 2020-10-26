#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]){

	char *a;
	a = argv[1];

	setreuid(1002,1002);

	foo(a);
	return 0;
}

int foo(char *b){

	char c[64];

	strcpy(c,b);
	printf("arg = %s\n",c);
	printf("arg address = %p\n",c);
	return 0;
}

void secretFunction(){

	FILE *fp;
	char fname[] = "flag1.txt";
	char str[20];

	fp = fopen(fname,"r");
	if(fp == NULL){
		printf("%s file not open!\n", fname);
		exit(0);
	}

	while(fgets(str, 20, fp)!=NULL){
		printf("%s", str);
	}

	fclose(fp);
}

