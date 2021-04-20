/*
Autores: Gina Ozimisa, Hernan Diaz
*/
%{
#include<stdio.h>
#include "y.tab.h"
extern int yylval;
%}
%%
[0,1]+ {
          yylval=atoi(yytext);
          return NUMBER;
       }
[2-9] {printf("Error. Numero no binario.");}
[\t] ;
[\n] return 0;
. return yytext[0];
%%

int yywrap()
{
return 1;
}
