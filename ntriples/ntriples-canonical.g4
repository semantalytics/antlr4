grammar ntriples;

ntriplesDoc
	: triple? (EOL triple)* EOL?
        ;

triple
	: subject predicate object '.'
        ;

subject
	: IRIREF
        | BLANK_NODE_LABEL
        ;

predicate
	: IRIREF;

object
	: IRIREF
        | BLANK_NODE_LABEL
        | literal
        ;

literal
	: STRING_LITERAL_QUOTE ('^^' IRIREF | LANGTAG)?
        ;

LANGTAG
	: '@' [a-zA-Z]+ ('-' [a-zA-Z0-9]+)*
        ;

EOL
	: [#xD#xA]+
        ;

IRIREF
	: '<' ([^#x00-#x20<>"{}|^`\] | UCHAR)* '>'
        ;

STRING_LITERAL_QUOTE
	: '"' ([^#x22#x5C#xA#xD] | ECHAR | UCHAR)* '"'
        ;

BLANK_NODE_LABEL
	: '_:' (PN_CHARS_U | [0-9]) ((PN_CHARS | '.')* PN_CHARS)?
        ;

UCHAR
	: '\u' HEX HEX HEX HEX
        | '\U' HEX HEX HEX HEX HEX HEX HEX HEX
        ;

ECHAR
	: '\' [tbnrf"'\];

PN_CHARS_BASE
	: [A-Z]
        | [a-z]
        | [#x00C0-#x00D6]
        | [#x00D8-#x00F6]
        | [#x00F8-#x02FF]
        | [#x0370-#x037D]
        | [#x037F-#x1FFF]
        | [#x200C-#x200D]
        | [#x2070-#x218F]
        | [#x2C00-#x2FEF]
        | [#x3001-#xD7FF]
        | [#xF900-#xFDCF]
        | [#xFDF0-#xFFFD]
        | [#x10000-#xEFFFF]
        ;

PN_CHARS_U
	: PN_CHARS_BASE
        | '_'
        | ':'
        ;

PN_CHARS
        : PN_CHARS_U
        | '-'
        | [0-9]
        | #x00B7
        | [#x0300-#x036F]
        | [#x203F-#x2040]
        ;

HEX
	: [0-9]
        | [A-F]
        | [a-f]
        ;
