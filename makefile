all: Driver.class NanoLispLexer.class
Driver.class NanoLispLexer.class: NanoLispLexer.java Driver.java
	javac -encoding utf8 Driver.java NanoLispLexer.java
NanoLispLexer.java: NanoLispLexer.jflex
	java -jar jflex-full-1.9.1.jar NanoLispLexer.jflex
clean:
	rm -Rf *~ NanoLispLexer.java *.class *.mexe *.masm
lexer.mexe: lexer.morpho
	java -jar morpho.jar -c lexer.morpho
compiler.mexe: compiler.morpho
	java -jar morpho.jar -c compiler.morpho
test:  Driver.class NanoLispLexer.class test.s fact.s
	java Driver test.s
	java Driver fact.s
testlexer: lexer.mexe NanoLispLexer.class
	java -cp ".:morpho.jar" is.hi.cs.morpho.Morpho lexer fact.s
	java -cp ".:morpho.jar" is.hi.cs.morpho.Morpho lexer test.s
testcompiler: compiler.mexe NanoLispLexer.class
	java -cp ".:morpho.jar" is.hi.cs.morpho.Morpho compiler fact.s > fact.masm
	java -cp ".:morpho.jar" is.hi.cs.morpho.Morpho compiler test.s > test.masm
	java -jar morpho.jar -c fact.masm
	java -jar morpho.jar -c test.masm
	java -jar morpho.jar fact
	java -jar morpho.jar test
