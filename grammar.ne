@{%
const { And, Equals, Or } = require("./types.js");
%}

# Allow whitespace around expressions
main -> _ expression _ {% function(d) { return d[1]; } %}

expression ->
    attribute _ "=" _ value {% function(d) { return new Equals(d[0], d[4]); } %}
  | expression __ "or" __ expression {% function(d) { return new Or(d[0], d[4]); } %}
  | expression __ "and" __ expression {% function(d) { return new And(d[0], d[4]); } %}
  | "(" _ expression _ ")" {% function(d) { return d[2]; } %}

# Attributes are lowercase alphabetic or periods
attribute -> [a-z.]:+ {% function(d) { return d[0].join(''); } %}

# Strings are whatever is between two quotes
string -> ["] [^"]:+ ["] {% function(d) { return d[1].join(''); } %}

int -> [0-9]:+      {% function(d) { return parseInt(d[0].join("")); } %}
float -> int "." int       {% function(d) { return parseFloat(d[0] + d[1] + d[2])} %}

number -> int {% id %} | float {% id %}

value ->
    string {% id %}
  | number {% id %}

# Optional whitespace
_ -> [\s]:* {% function(d) {return null; } %}

# Mandatory whitespace
__ -> [\s]:+ {% function(d) {return null; } %}