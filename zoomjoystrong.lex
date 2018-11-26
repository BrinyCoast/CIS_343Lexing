%{
    #include <stdio.h>
    #include "zoomjoystrong.tab.h"

%}
%option yylineno 
%%

(END)       				{ return END;}
[;]         				{ return END_STATEMENT;}
(POINT)					{ return POINT;}
(LINE)					{ return LINE;}
(CIRCLE)				{ return CIRCLE;}
(RECTANGLE)				{ return RECTANGLE;}
(SET_COLOR)				{ return SET_COLOR;}
[0-9]+					{ return INT;}
[0-9]+?\.[0-9]+				{ return FLOAT;}
\ |\n|\t        			; // Ignore these chars!
.					{ printf("%s is not a token on line %u\n",yytext, yylineno );}
 
%%
 
//int main(int argc, char** argv){

  //yylex();    // Start lexing!
//}
