%{
    #include <stdio.h>
    #include "zoomjoystrong.tab.h"

%}
%option yylineno 
%%

(end)       				{ return END;}
[;]         				{ return END_STATEMENT;}
(point)					{ return POINT;}
(line)					{ return LINE;}
(circle)				{ return CIRCLE;}
(rectangle)				{ return RECTANGLE;}
(set_color)				{ return SET_COLOR;}
[0-9]+					{ yylval.ival = atoi(yytext); return INT; }
[0-9]+?\.[0-9]+				{ return FLOAT;}
[\ |\n|\t|\r] 	     			; // Ignore these chars!
.					{ printf("%s is not a token on line %u\n",yytext, yylineno );}
 
%%
 
/*int main(int argc, char** argv){

  yylex();    // Start lexing!
}*/
int yywrap() { return 1; }