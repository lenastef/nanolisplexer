/*
	JFlex lexer for NanoLisp.
	Author: Snorri Agnarsson, 2014-2024

	This lexer can be compiled and run with
		java -jar jflex-full-1.9.1.jar NanoLispLexer.jflex
		javac Driver.java NanoLispLexer.java
		java Driver test.s
	To run it without doing nanolisp compilations, you can
	either use a driver generated by bison from NanoLisp.y,
	or you can use a hand-written driver in the file Driver.java.
	If you use the bison-generated driver you will need to
	modify the %implements line below and use the following
	commands to compile and run
		bison NanoLisp.y
		java -jar jflex-full-1.9.1.jar NanoLisp.jflex
		javac NanoLisp.java NanoLispLexer.java
		java NanoLisp test.s
	
 */

%%

%public
%class NanoLispLexer
%implements NanoLisp.Lexer	/* Use this if the bison driver is used */
//%implements Driver.Lexer		/* Use this if the hand-written driver is used */
%unicode
%line
%column
%byaccj

%{

	String yylval;

	public String getLVal()
	{
		return yylval;
	}

	public void yyerror( String error )
	{
		System.err.println("Error:  "+error);
		System.err.println("Lexeme: "+yylval);
		System.err.println("Line:   "+(yyline+1));
		System.err.println("Column: "+(yycolumn+1));
		System.exit(1);
	}

	public void show( String token, String lexeme )
	{
		System.out.print("Token: "+token);
		System.out.print(", Lexeme: "+lexeme);
		System.out.print(", Line: "+(yyline+1));
		System.out.println(", Column: "+(yycolumn+1));
	}

	public String getTokenName( int token )
	{
		switch( token )
		{
		case LITERAL:	return "LITERAL";
		case NAME:		return "NAME";
		case IF:		return "IF";
		case ELSEIF:	return "ELSEIF";
		case ELSE:      return "ELSE";
    	case WHILE:     return "WHILE";
		case FOR:		return "FOR";
		case BREAK:		return "BREAK";
		case RETURN:	return "RETURN";
		case YYERRCODE:	return "YYERRCODE";
		case '(':		return "'('";
		case ')':		return "')'";
		case '+':       return "'+'";
   		case '-':       return "'-'";
    	case '*':       return "'*'";
    	case '/':       return "'/'";
		case '{':       return "'{'";
    	case '}':       return "'}'";
    	case '[':       return "'['";
    	case ']':       return "']'";
		}
		return "unknown";
	}
	
	public int getLine() { return yyline+1; }
	public int getColumn() { return yycolumn+1; }
%}

  /* Reglulegar skilgreiningar */

  /* Regular definitions */

_DIGIT=[0-9]
_FLOAT={_DIGIT}+\.{_DIGIT}+([eE][+-]?{_DIGIT}+)?
_INT={_DIGIT}+
_STRING=\"([^\"\\]|\\b|\\t|\\n|\\f|\\r|\\\"|\\\'|\\\\|(\\[0-3][0-7][0-7])|\\[0-7][0-7]|\\[0-7])*\"
_CHAR=\'([^\'\\]|\\b|\\t|\\n|\\f|\\r|\\\"|\\\'|\\\\|(\\[0-3][0-7][0-7])|(\\[0-7][0-7])|(\\[0-7]))\'
_DELIM=[()]
_NAME=([:letter:]|[\+\-*/!%&=><\:\^\~&|?]|{_DIGIT})+

%%

{_DELIM} {
	yylval = yytext();
	return yycharat(0);
}

{_STRING} | {_FLOAT} | {_CHAR} | {_INT} | null | true | false {
	yylval = yytext();
	return LITERAL;
}

"if" {
	yylval = yytext();
	return IF;
}

"ELSEIF"{
	yylval = yytext();
	return ELSEIF;
}
"ELSE"{
	yylval = yytext();
	return ELSE;
}
"WHILE"{
	yylval = yytext();
	return WHILE;
}
"FOR"{
	yylval = yytext();
	return FOR;
}
"BREAK" {
	yylval = yytext();
	return BREAK;
}
"RETURN" {
	yylval = yytext();
	return RETURN;
}
"define" {
	yylval = yytext();
	return DEFINE;
}

{_NAME} {
	yylval = yytext();
	return NAME;
}

";".*$ {
}

[ \t\r\n\f] {
}

. {
	yylval = yytext();
	return YYERRCODE;
}
