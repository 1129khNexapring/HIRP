if ( !window.RichTextEditor ) 
{
	throw new Error("RichTextEditor is not defined !!");
}

if ( !RichTextEditor.Highlight ) 
{
	throw new Error("RichTextEditor.Highlight is not defined !!");
}

if (!RichTextEditor.Highlight.ParseJava)
{
    RichTextEditor.Highlight.ParseJava = {
        /**
         * Java parser for codemirror
         *
         * @author Patrick Wied
         */

        init: function ()
        {
        	var highlight = arguments[0];
            var indentUnit = highlight.indentUnit;
            var tokenizeJava = highlight.tokenizeJava;

            // Token types that can be considered to be atoms.
            var atomicTypes = {
                "atom": true,
                "number": true,
                "string": true,
                "regexp": true
            };
            // Setting that can be used to have JSON data indent properly.
            var json = false;
            // Constructor for the lexical context objects.
            function JavaLexical(indented, column, type, align, prev, info)
            {
                // indentation at start of this line
                this.indented = indented;
                // column at which this scope was opened
                this.column = column;
                // type of scope ( 'stat' (statement), 'form' (special form), '[', '{', or '(')
                this.type = type;
                // '[', '{', or '(' blocks that have any text after their opening
                // character are said to be 'aligned' -- any lines below are
                // indented all the way to the opening character.
                if (align != null)
                    this.align = align;
                // Parent scope, if any.
                this.prev = prev;
                this.info = info;
            }

            // java indentation rules.
            function indentJava(lexical)
            {
                return function (firstChars)
                {
                    var firstChar = firstChars && firstChars.charAt(0),
                        type = lexical.type;
                    var closing = firstChar == type;
                    if (type == "form" && firstChar == "{")
                        return lexical.indented;
                    else if (type == "stat" || type == "form")
                        return lexical.indented + indentUnit;
                    else if (lexical.info == "switch" && !closing)
                        return lexical.indented + (/^(?:case|default)\b/.test(firstChars) ? indentUnit : 2 * indentUnit);
                    else if (lexical.align)
                        return lexical.column - (closing ? 1 : 0);
                    else
                        return lexical.indented + (closing ? 0 : indentUnit);
                };
            }

            // The parser-iterator-producing function itself.
            function parseJava(input, basecolumn)
            {
                // Wrap the input in a token stream
                var tokens = tokenizeJava(input);
                // The parser state. cc is a stack of actions that have to be
                // performed to finish the current statement. For example we might
                // know that we still need to find a closing parenthesis and a
                // semicolon. Actions at the end of the stack go first. It is
                // initialized with an infinitely looping action that consumes
                // whole statements.
                var cc = [statements];
                // The lexical scope, used mostly for indentation.
                var lexical = new JavaLexical(basecolumn || 0, 0, "block", false);
                // Current column, and the indentation at the start of the current
                // line. Used to create lexical scope objects.
                var column = 0;
                var indented = 0;
                // Variables which are used by the mark, cont, and pass functions
                // below to communicate with the driver loop in the 'next'
                // function.
                var consume, marked;

                // The iterator object.
                var parser = {
                    next: next,
                    copy: copy
                };

                function next()
                {
                    // Start by performing any 'lexical' actions (adjusting the
                    // lexical variable), or the operations below will be working
                    // with the wrong lexical state.
                    while (cc[cc.length - 1].lex)
                        cc.pop()();

                    // Fetch a token.
                    var token = tokens.next();

                    // Adjust column and indented.
                    if (token.type == "whitespace" && column == 0)
                        indented = token.value.length;
                    column += token.value.length;
                    if (token.content == "\n")
                    {
                        indented = column = 0;
                        // If the lexical scope's align property is still undefined at
                        // the end of the line, it is an un-aligned scope.
                        if (!("align" in lexical))
                            lexical.align = false;
                        // Newline tokens get an indentation function associated with
                        // them.
                        token.indentation = indentJava(lexical);

                    }
                    // No more processing for meaningless tokens.
                    if (token.type == "whitespace" || token.type == "comment" || token.type == "javadoc" || token.type == "annotation")
                        return token;

                    // When a meaningful token is found and the lexical scope's
                    // align is undefined, it is an aligned scope.
                    if (!("align" in lexical))
                        lexical.align = true;

                    // Execute actions until one 'consumes' the token and we can
                    // return it.
                    while (true)
                    {
                        consume = marked = false;
                        // Take and execute the topmost action.
                        cc.pop()(token.type, token.content);
                        if (consume)
                        {
                            // Marked is used to change the style of the current token.
                            if (marked)
                                token.style = marked;
                            return token;
                        }
                    }
                }

                // This makes a copy of the parser state. It stores all the
                // stateful variables in a closure, and returns a function that
                // will restore them when called with a new input stream. Note
                // that the cc array has to be copied, because it is contantly
                // being modified. Lexical objects are not mutated, and context
                // objects are not mutated in a harmful way, so they can be shared
                // between runs of the parser.
                function copy()
                {
                    var _lexical = lexical,
                        _cc = cc.concat([]),
                        _tokenState = tokens.state;

                    return function copyParser(input)
                    {
                        lexical = _lexical;
                        cc = _cc.concat([]); // copies the array
                        column = indented = 0;
                        tokens = tokenizeJava(input, _tokenState);
                        return parser;
                    };
                }

                // Helper function for pushing a number of actions onto the cc
                // stack in reverse order.
                function push(fs)
                {
                    for (var i = fs.length - 1; i >= 0; i--)
                        cc.push(fs[i]);
                }
                
                // cont and pass are used by the action functions to add other
                // actions to the stack. cont will cause the current token to be
                // consumed, pass will leave it for the next action.
                function cont()
                {
                    push(arguments);
                    consume = true;
                }

                function pass()
                {
                    push(arguments);
                    consume = false;
                }
                
                // Used to change the style of the current token.
                function mark(style)
                {
                    marked = style;
                }

                // Push a new lexical context of the given type.
                function pushlex(type, info)
                {
                    var result = function ()
                    {
                        lexical = new JavaLexical(indented, column, type, null, lexical, info)
                    };
                    result.lex = true;
                    return result;
                }
                
                // Pop off the current lexical context.
                function poplex()
                {
                    lexical = lexical.prev;
                }
                poplex.lex = true;
                // The 'lex' flag on these actions is used by the 'next' function
                // to know they can (and have to) be ran before moving on to the
                // next token.

                // Creates an action that discards tokens until it finds one of
                // the given type.
                function expect(wanted)
                {
                    return function expecting(type)
                    {
                        if (type == wanted) cont();
                        else cont(arguments.callee);
                    };
                }

                // Looks for a statement, and then calls itself.
                function statements(type)
                {
                    return pass(statement, statements);
                }
                
                // Dispatches various types of statements based on the type of the
                // current token.
                function statement(type)
                {
                    if (type == "keyword a") cont(pushlex("form"), expression, statement, poplex);
                    else if (type == "keyword b") cont(pushlex("form"), statement, poplex);
                    else if (type == "{") cont(pushlex("}"), block, poplex);
                    else if (type == "for") cont(pushlex("form"), expect("("), pushlex(")"), forspec1, expect(")"), poplex, statement, poplex);
                    else if (type == "variable") cont(pushlex("stat"), maybelabel);
                    else if (type == "switch") cont(pushlex("form"), expression, pushlex("}", "switch"), expect("{"), block, poplex, poplex);
                    else if (type == "case") cont(expression, expect(":"));
                    else if (type == "default") cont(expect(":"));
                    else if (type == "catch") cont(pushlex("form"), expect("("), function () {}, expect(")"), statement, poplex);
                    else if (type == "class") cont();
                    else if (type == "interface") cont();
                    else if (type == "keyword c") cont(statement);
                    else pass(pushlex("stat"), expression, expect(";"), poplex);
                }
                
                // Dispatch expression types.
                function expression(type)
                {
                    if (atomicTypes.hasOwnProperty(type)) cont(maybeoperator);
                    //else if (type == "function") cont(functiondef);
                    else if (type == "keyword c") cont(expression);
                    else if (type == "(") cont(pushlex(")"), expression, expect(")"), poplex, maybeoperator);
                    else if (type == "operator") cont(expression);
                    else if (type == "[") cont(pushlex("]"), commasep(expression, "]"), poplex, maybeoperator);
                }
                
                // Called for places where operators, function calls, or
                // subscripts are valid. Will skip on to the next action if none
                // is found.
                function maybeoperator(type)
                {
                    if (type == "operator") cont(expression);
                    else if (type == "(") cont(pushlex(")"), expression, commasep(expression, ")"), poplex, maybeoperator);
                    else if (type == "[") cont(pushlex("]"), expression, expect("]"), poplex, maybeoperator);
                }
                
                // When a statement starts with a variable name, it might be a
                // label. If no colon follows, it's a regular statement.
                function maybelabel(type)
                {
                    if (type == "(") cont(commasep(function () {}, ")"), poplex, statement); // method definition
                    else if (type == "{") cont(poplex, pushlex("}"), block, poplex); // property definition
                    else pass(maybeoperator, expect(";"), poplex);
                }

                // Parses a comma-separated list of the things that are recognized
                // by the 'what' argument.
                function commasep(what, end)
                {
                    function proceed(type)
                    {
                        if (type == ",") cont(what, proceed);
                        else if (type == end) cont();
                        else cont(expect(end));
                    };
                    return function commaSeparated(type)
                    {
                        if (type == end) cont();
                        else pass(what, proceed);
                    };
                }
                
                // Look for statements until a closing brace is found.
                function block(type)
                {
                    if (type == "}") cont();
                    else pass(statement, block);
                }

                // For loops.
                function forspec1(type)
                {
                    if (type == ";") pass(forspec2);
                    else pass(forspec2);
                }

                function formaybein(type, value)
                {
                    if (value == "in") cont(expression);
                    else cont(maybeoperator, forspec2);
                }

                function forspec2(type, value)
                {
                    if (type == ";") cont(forspec3);
                    else if (value == "in") cont(expression);
                    else cont(expression, expect(";"), forspec3);
                }

                function forspec3(type)
                {
                    if (type == ")") pass();
                    else cont(expression);
                }

                return parser;
            }

            return {
                make: parseJava,
                electricChars: "{}:",
                configure: function (obj)
                {
                    if (obj.json != null) json = obj.json;
                }
            };
        }
    };
}