require! fs: {readdirSync, readFileSync} tape: test,\
\babel-types : types, \babel-core : {transform}, \
\../lib/index : {func-name}: transform-inline-elements
babel-options = plugins: [\transform-react-jsx, transform-inline-elements]

function pragma-names t
  desc = 'identify callee of call expressions'
  expected = 'h React.createElement'
  items =
    types.identifier \h
    types.memberExpression (types.identifier \React), types.identifier \createElement
  result = items.map func-name .join ' '
  t.equal result, expected, desc

function compare t, desc, options=babel-options, source, expected
  {code} = transform source, options
  t.equal code, expected, desc

function preact-object-element t
  desc = 'convert preact.h calls to objects'
  options = plugins:
    [\transform-react-jsx pragma: \h]
    [transform-inline-elements, preset: \preact]
  compare t, desc, options, ...<[sample.jsx sample.preact.js]>map ->
    readFileSync "test/#it" .toString!

function main t
  pragma-names t
  readdirSync \test .forEach (name) ->
    desc = name.replace /-/g ' '
    try compare t, desc,, ...<[actual expected]>map ->
      readFileSync "test/#name/#it.js" .toString!
  preact-object-element t

  t.end!

test \Plugin main if require.main == module
