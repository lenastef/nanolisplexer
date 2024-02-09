import java.io.*;

public class Driver
{
	// This interface describes how bison-generated
	// parsers using Java want a lexer to behave.
	public interface Lexer
	{
		// Token values
		public static final int EOF = 0;
		static final int LITERAL = 258;
		static final int NAME = 259;
		static final int IF = 260;
		static final int ELSEIF = 263;
		static final int ELSE = 264;
		static final int WHILE = 265;
		static final int FOR = 266;
		static final int BREAK = 267;
		static final int RETURN = 268;
		static final int DEFINE = 261;
		static final int YYERRCODE = 262;
		// In addition to the above token values
		// we may have additional one character
		// tokens such as '(' and ')'.
		Object getLVal();
		int yylex () throws java.io.IOException;
		void yyerror( String msg );
	}
	
	public String getTokenName( int token )
	{
		switch( token )
		{
		case Lexer.EOF:			return "end-of-file";
		case Lexer.LITERAL:		return "LITERAL";
		case Lexer.NAME:		return "NAME";
		case Lexer.IF:			return "IF";
		case Lexer.ELSEIF:		return "ELSEIF";
		case Lexer.ELSE:		return "ELSE";
		case Lexer.WHILE:		return "WHILE";
		case Lexer.FOR:			return "FOR";
		case Lexer.BREAK:		return "BREAK";
		case Lexer.RETURN:		return "RETURN";
		case Lexer.DEFINE:		return "DEFINE";
		case Lexer.YYERRCODE:	return "YYERRCODE";
		case '(':				return "'('";
		case ')':				return "')'";
		case '+':				return "'+'";
		case '-':				return "'-'";
		case '*':				return "'*'";
		case '/':				return "'/'";
		case '{':       		return "'{'";
    	case '}':       		return "'}'";
    	case '[':       		return "'['";
    	case ']':       		return "']'";
		}
		return "unknown";
	}

	public static void main( String[] args ) throws Exception
	{
		NanoLispLexer l = new NanoLispLexer(new FileReader(args[0]));
		try
		{
			int token = l.yylex();
			while( token != Lexer.EOF )
			{
				if( token == l.YYERRCODE ) l.yyerror("Invalid lexeme");
				l.show(l.getTokenName(token),(String)l.getLVal());
				token = l.yylex();
			}
		}
		catch( Exception e )
		{
			l.yyerror(e.getMessage());
		}
	}
}