#include <stdio.h>

int main(int argc, char **argv[]){
        char masterpass[10] = "secret";
        char p[20];
        printf("Safe password manager\n");
        printf("Enter your password to unlock:\n");
        scanf("%s",&p);
   	while (strcmp(masterpass,p)!= 0){}
	printf("Logged in!\n");
return(0);
}
