%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	int yyerror(const char* err);
	int checkColor(int a, int b, int c);
	int xLocation(int x);
	int yLocation(int y);

%}
%union {int ival; 
	float fval;
	char* sval;
}
%token END
%token END_STATEMENT
%token LINE
%token POINT
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token <ival> INT
%token <ifal> FLOAT

%%

program:	statement_list END
	;

statement_list:	statement
	|	statement_list statement
	;
						     //Checks if the color is between 0-255
statement:	SET_COLOR INT INT INT END_STATEMENT { if(checkColor($2, $3, $4)) { set_color($2, $3, $4); } }

						     //Checks if circle bounds are within the limits
	|	CIRCLE  INT INT INT END_STATEMENT   { if(xLocation($2+$4) && yLocation($3+$4) && xLocation($2-$4) && xLocation($2-$4)) { 
								circle($2, $3, $4); 
							} else {
								printf("Circle not in bounds\n");
							}
						    }

						     //Checks if points of the lines are within the limits
 	|	LINE INT INT INT INT END_STATEMENT  { if(xLocation($2) && yLocation($3) && xLocation($4) && yLocation($5)){
						    		line($2, $3, $4, $5);
						    	} else {
								printf("Line not in bounds\n");
							}
						    }

						     //Checks if point is in bounds.
	|	POINT INT INT END_STATEMENT 	    { if(xLocation($2) && yLocation($3)) {
								point($2, $3);
							} else {
								printf("Point not in bounds\n");
							}
						    }


	|	RECTANGLE INT INT INT INT END_STATEMENT { if(xLocation($2) && yLocation($3) && xLocation($2+$4) && yLocation($3+$5)) {
								rectangle($2, $3, $4, $5);
							    } else {
								printf("Rectangle not in bounds\n");
							    }
						   	}
	|	END
	;

%%

int main(int argc, char** argv){
	setup();
	yyparse();
	finish();
}
int yyerror(const char* err){
	printf("%s\n", err);
}
//check if color is within 0-255
int checkColor(int a, int b, int c){
	if(a <= 255 && a >= 0 && b <= 255 && b >= 0 && c <= 255 && c >= 0){
		return 1;
	} else {
		printf("Not a valid color\n");
		return 0;
	}
}
//Checks if x is within the bounds, using width from zoomjoystrong.h
int xLocation(int x){
	if(x > 0 && x <= WIDTH){
		return 1;
	} else {
		printf("X BOUND IS OUT OF RANGE\n"); 
		return 0;
	}
}
//Checks if y is within the bounds, using height from zoomjoystrong.h
int yLocation(int y){
	if(y > 0 && y <= HEIGHT){
		return 1;
	} else {
		printf("Y BOUND IS OUT OF RANGE\n"); 
		return 0;	
	}
}

