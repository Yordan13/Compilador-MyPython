import java.util.ArrayList;
import scanner.BooleanToken;
import scanner.EOFToken;
import scanner.ErrorToken;
import scanner.FloatToken;
import scanner.IdentifierToken;
import scanner.IntegerToken;
import scanner.NullToken;
import scanner.OperatorToken;
import scanner.ReservedWordToken;
import scanner.StringToken;
import scanner.Token;
%%
%public
%class MyPythonScanner

%unicode

%line
%column


%{
  StringBuffer string = new StringBuffer();
    
  private ArrayList<Token> _TokenList=new ArrayList<>();
  private long parseLong(int start, int end, int radix) {
    long result = 0;
    long digit;

    for (int i = start; i < end; i++) {
      digit  = Character.digit(yycharat(i),radix);
      result*= radix;
      result+= digit;
    }

    return result;
  }
%}

/* main character classes */
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]

WhiteSpace = {LineTerminator} | [ \f]

/* comments */
Comment = {BlockComment} | {EndOfLineComment} 

BlockComment = "\"\"\"" [^\"\"\"] ~"\"\"\"" 
EndOfLineComment = "#" {InputCharacter}* {LineTerminator}?

/* identifiers */
Identifier = [:jletter:][:jletterdigit:]*

/* integer literals */
DecIntegerLiteral = 0 | [1-9][0-9]*

HexIntegerLiteral = 0 [xX] 0* {HexDigit} {1,8}
HexDigit          = [0-9a-fA-F]

OctIntegerLiteral = 0+ [1-3]? {OctDigit} {1,15}
OctDigit          = [0-7]
    
/* floating point literals */        
FloatLiteral  = ({FLit1}|{FLit2}|{FLit3}) {Exponent}? [fF]

FLit1    = [0-9]+ \. [0-9]* 
FLit2    = \. [0-9]+ 
FLit3    = [0-9]+ 
Exponent = [eE] [+-]? [0-9]+

/* string and character literals */
StringCharacter = [^\r\n\"\\]
SingleCharacter = [^\r\n\'\\]

%state STRING, CHARLITERAL

%%

<YYINITIAL> {

  /* keywords */
  "and"                     { return new ReservedWordToken("and",yyline); }
  "assert"                  { return new ReservedWordToken("assert",yyline); }
  "break"                   { return new ReservedWordToken("break",yyline); }
  "class"                   { return new ReservedWordToken("class",yyline); }
  "continue"                { return new ReservedWordToken("continue",yyline); }
  "def"                     { return new ReservedWordToken("def",yyline); }
  "del"                     { return new ReservedWordToken("del",yyline); }
  "elif"                    { return new ReservedWordToken("elif",yyline); }
  "else"                    { return new ReservedWordToken("else",yyline); }
  "except"                  { return new ReservedWordToken("except",yyline); }
  "exec"                    { return new ReservedWordToken("exec",yyline); }
  "finally"                 { return new ReservedWordToken("finally",yyline); }
  "for"                     { return new ReservedWordToken("for",yyline); }
  "from"                    { return new ReservedWordToken("from",yyline); }
  "global"                  { return new ReservedWordToken("global",yyline); }
  "if"                      { return new ReservedWordToken("if",yyline); }
  "import"                  { return new ReservedWordToken("import",yyline); }
  "in"                      { return new ReservedWordToken("in",yyline); }
  "is"                      { return new ReservedWordToken("is",yyline); }
  "lambda"                  { return new ReservedWordToken("lambda",yyline); }
  "not"                     { return new ReservedWordToken("not",yyline); }
  "or"                      { return new ReservedWordToken("or",yyline); }
  "pass"                    { return new ReservedWordToken("pass",yyline); }
  "print"                   { return new ReservedWordToken("print",yyline); }
  "raise"                   { return new ReservedWordToken("raise",yyline); }
  "return"                  { return new ReservedWordToken("return",yyline); }
  "try"                     { return new ReservedWordToken("try",yyline); }
  "while"                   { return new ReservedWordToken("while",yyline); }
  
  /* boolean literals */
  "true"                         { return new BooleanToken("true",yyline); }
  "false"                        { return new BooleanToken("false",yyline); }
  
  /* null literal */
  "null"                         { return new NullToken("null",yyline); }
  
  
  /* separators */
  "("                            { return new ReservedWordToken("(",yyline); }
  ")"                            { return new ReservedWordToken(")",yyline); }
  "["                            { return new ReservedWordToken("[",yyline); }
  "]"                            { return new ReservedWordToken("]",yyline); }
  ","                            { return new ReservedWordToken(",",yyline); }
  "."                            { return new ReservedWordToken(".",yyline); }
  
  /* operators */
  "+"                            { return new OperatorToken("+",yyline); }
  "-"                            { return new OperatorToken("-",yyline); }
  "*"                            { return new OperatorToken("*",yyline); }
  "/"                            { return new OperatorToken("/",yyline); }
  "//"                           { return new OperatorToken("//",yyline); }
  "%"                            { return new OperatorToken("%",yyline); }
  "**"                           { return new OperatorToken("**",yyline); }
  "="                            { return new OperatorToken("=",yyline); }
  "=="                           { return new OperatorToken("==",yyline); }
  "!="                           { return new OperatorToken("!=",yyline); }
  "<>"                           { return new OperatorToken("<>",yyline); }
  ">"                            { return new OperatorToken(">",yyline); }
  "<"                            { return new OperatorToken("<",yyline); }
  ">="                           { return new OperatorToken(">=",yyline); }
  "<="                           { return new OperatorToken("<=",yyline); }
  "+="                           { return new OperatorToken("+=",yyline); }
  "-="                           { return new OperatorToken("-=",yyline); }
  "*="                           { return new OperatorToken("*=",yyline); }
  "/="                           { return new OperatorToken("/=",yyline); }
  "**="                          { return new OperatorToken("**=",yyline); }
  "//="                          { return new OperatorToken("//=",yyline); }
  "("                            { return new OperatorToken("(",yyline); }
  ")"                            { return new OperatorToken(")",yyline); }
  ","                            { return new OperatorToken(",",yyline); }
  "."                            { return new OperatorToken(".",yyline); }
  ">>"                           { return new OperatorToken(">>",yyline); }
  "<<"                           { return new OperatorToken("<<",yyline); }
  "AND"                          { return new OperatorToken("AND",yyline); }
  "OR"                           { return new OperatorToken("OR",yyline); }
  "NOT"                          { return new OperatorToken("NOT",yyline); }
  "|"                            { return new OperatorToken("|",yyline); }
  "^"                            { return new OperatorToken("^",yyline); }
  "~"                            { return new OperatorToken("~",yyline); }
  
  /* string literal */
  \"                             { yybegin(STRING); string.setLength(0); }

  /* character literal */
  \'                             { yybegin(CHARLITERAL); string.setLength(0); }

  /* numeric literals */
  
  {DecIntegerLiteral}            { return new IntegerToken(yytext(),yyline); }
  
  {HexIntegerLiteral}            { return new IntegerToken(parseLong(2, yylength(), 16),yyline); }
 
  {OctIntegerLiteral}            { return new IntegerToken(parseLong(2, yylength(), 16),yyline); }  
  
  {FloatLiteral}                 { return new FloatToken(yytext().substring(0,yylength()-1),yyline); }
  
  /* comments */
  {Comment}                      { /* ignore */ }

  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }

  /* identifiers */ 
  {Identifier}                   { return new IdentifierToken(yytext(),yyline); }
}

<STRING> {
  \"                             { yybegin(YYINITIAL); return new StringToken("\""+string.toString()+"\"",yyline); }
  
  {StringCharacter}+             { string.append( yytext() ); }
  
  /* escape sequences */
  "\\b"                          { string.append( '\b' ); }
  "\\t"                          { string.append( '\t' ); }
  "\\n"                          { string.append( '\n' ); }
  "\\f"                          { string.append( '\f' ); }
  "\\r"                          { string.append( '\r' ); }
  "\\\""                         { string.append( '\"' ); }
  "\\'"                          { string.append( '\'' ); }
  "\\\\"                         { string.append( '\\' ); }
  \\[0-3]?{OctDigit}?{OctDigit}  { char val = (char) Integer.parseInt(yytext().substring(1),8);
                        				   string.append( val ); }
  
  /* error cases */
  {LineTerminator}               { return new ErrorToken(yytext(),yyline); }
}

<CHARLITERAL> {
  {SingleCharacter}\'            { yybegin(YYINITIAL); return new symbol(CHARACTER_LITERAL, yytext().charAt(0)); }
  
  /* escape sequences */
  "\\b"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\b');}
  "\\t"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\t');}
  "\\n"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\n');}
  "\\f"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\f');}
  "\\r"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\r');}
  "\\\""\'                       { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\"');}
  "\\'"\'                        { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\'');}
  "\\\\"\'                       { yybegin(YYINITIAL); return symbol(CHARACTER_LITERAL, '\\'); }
  \\[0-3]?{OctDigit}?{OctDigit}\' { yybegin(YYINITIAL); 
			                              int val = Integer.parseInt(yytext().substring(1,yylength()-1),8);
			                            return symbol(CHARACTER_LITERAL, (char)val); }
  
  /* error cases */
  {LineTerminator}               { return new ErrorToken(yytext(),yyline); }
}


/* error fallback */
[^]                              { return new ErrorToken(yytext(),yyline); }
<<EOF>>                          { return new EOFToken("EOF",yyline); }