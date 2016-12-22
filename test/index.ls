require! fs: {readdirSync, readFileSync} tape: test,\
\babel-types : types, \babel-core : {transform}, \
\../lib/index : {func-name}: transform-inline-elements

function pragma-names t
  desc = 'identify callee of call expressions'
  expected = 'h React.createElement'
  items =
    types.identifier \h
    types.memberExpression (types.identifier \React), types.identifier \createElement
  result = items.map func-name .join ' '
  t.equal result, expected, desc

function main t
  pragma-names t
  options = plugins: [\transform-react-jsx, transform-inline-elements]
  readdirSync \test .forEach (name) ->
    try
      [source, expected] = <[actual expected]>map ->
        readFileSync "test/#name/#it.js" .toString!
      {code} = transform source, options
      t.equal code, expected, name.replace /-/g ' '

  t.end!

test \Plugin main if require.main == module
