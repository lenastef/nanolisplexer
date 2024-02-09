/*
 * Bison driver for NanoLisp lexer.
 * Author: Snorri Agnarsson, 2024.
 */

%language "Java"
%define parse.error verbose
%define api.parser.class {NanoLisp}
%define api.parser.public

%code imports {
	import java.util.*;
	import java.io.*;
}

%code {
	static private NanoLispLexer l;
	
	public static void main( String args[] )
	  	throws IOException
	{
		l = new NanoLispLexer(new FileReader(args[0]));
		NanoLisp p = new NanoLisp(l);
		p.parse();
	}	
}

%token <String> LITERAL NAME IF DEFINE '(' ')'
%token YYERRCODE
%type <String> token

%%

program
	:	token program
	|	%empty
	;

token
	:	LITERAL	{ l.show("LITERAL",$LITERAL); 	}
	|	NAME	{ l.show("NAME",$NAME); 		}
	|	IF		{ l.show("IF",$IF); 			}
	|	ELSEIF	{ l.show("ELSEIF",$ELSEIF); 	}
	| 	ELSE	{ l.show("ELSE",$ELSE);			}	
	| 	WHILE	{ l.show("WHILE",$WHILE);		}
	|	FOR		{ l.show("FOR",$FOR); 			}
	|	BREAK	{ l.show("BREAK",$BREAK); 		}
	|	RETURN	{ l.show("RETURN",$RETURN);		}
	|	DEFINE	{ l.show("DEFINE",$DEFINE); 	}
	|	'('		{ l.show("'('",$1); 			}
	|	')'		{ l.show("')'",$1); 			}
	|	'+'		{ l.show("'+'",$1); 			}
	|	'-'		{ l.show("'-'",$1); 			}
	|	'*'		{ l.show("'*'",$1); 			}
	|	'/'		{ l.show("'/'",$1); 			}
	|	'{'		{ l.show("'{'",$1); 			}
	|	'}'		{ l.show("'}'",$1); 			}
	|	'['		{ l.show("'['",$1); 			}
	|	']'		{ l.show("']'",$1); 			}
	;

%%
