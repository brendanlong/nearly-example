# Parser example

This is an example of parsing a language that looks like:

```
(some.attribute = "asdlkmf" and other.attribute = "blah") or x = "z"
```

Using a parser generator called Nearley:

<https://nearley.js.org/>

## Setup

```bash
# Install dependencies
yarn install

# Compile the grammar file
yarn nearleyc grammar.ne -o grammar.js
```

## Test parsing

See what the parser parses this input into:

```bash
yarn nearleyc grammar.ne -o grammar.js && yarn nearley-test --start main grammar.js --input '(some.attribute = "asdlkmf" and other.attribute = "blah") or x = "z"'
```

## How you could use this

You could import this into a real problem and have a parsed data structure, like:

```javascript
const { Grammar, Parser } = require("nearley");
const grammar = require("./grammar.js");

const parser = new Parser(Grammar.fromCompiled(grammar));

parser.feed(inputFromUser);

// Note that our example grammar is ambigious if the user inputs 'or'  and 'and' expressions without parenthesis,
// so pick the first possible parse result
// This could be improved by making the grammar non-ambigious
const result = parser.results[0];

/* Now 'result is a data structure like this that you can work with instead of a string:
const result = new Or(
    new And(
        new Equals("some.attribute", "asdlkmf"),
        new Equals("other.attribute", "blah"),
    ),
    new Equals("x", "z"),
);
*/
```

<https://nearley.js.org/docs/parser>

## Advantages

This format lets you describe the input and it handles a lot of things automatically, like the mandatory and optional whitespace, optional parens, and nesting of different expressions.

## Complexities

The grammar I provided is ambigious and I'm not sure if it will parse the way you're wanting for missing parens. It's possible to make it unambigious in this case but I'm not an expert on how to do it.

<https://nearley.js.org/docs/parser#a-note-on-ambiguity>

<https://nearley.js.org/docs/how-to-grammar-good#operator-precedence-is-not-black-magic>