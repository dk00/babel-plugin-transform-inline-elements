import
  fs: {read-file-sync}
  tape: test
  \babel-core : {transform}
  \../src/index : inline-element
  \../src/helpers : {ensure-functional}

function test-all t, cases, options
  Object.keys cases .for-each (name) ->
    [code, expected] = <[actual expected]>map (which) ->
      read-file-sync "test/#name/#which.jsx" .to-string!trim!
    actual = transform code, options .code
    t.equal actual, expected, cases[name]
  t.end!

function direct-calls t
  options = plugins:
    * \transform-react-jsx use-built-ins: true
    inline-element
  cases =
    \direct-call-no-argument : 'turn elements with attributes into direct calls'
    \direct-call-arguments : 'convert direct call arguments'
    \direct-call-children : 'merge children with direct call arguments'
    \merge-1-argument : 'merge children with props objects'
    \merge-many-arguments : 'merge children with last props objects'
    \add-children-property : 'add children as last property'
    \add-children-object : 'add children as last object'
    \kebab-cased-type-name : 'support kebab cased type names'

  test-all t, cases, options

function test-functional t
  h = (type, props) -> {type, props.value}
  fn = ->
  actual = ensure-functional h, fn
  expected = fn
  t.equal actual, expected, 'return original function'

  actual = ensure-functional h, \a <| value: \fallback
  expected = type: \a value: \fallback
  t.deep-equal actual, expected, 'use create element'

  options = plugins:
    * \transform-react-jsx use-built-ins: true
    * inline-element, ensure-functional: true
  cases =
    \ensure-functional : 'call components directly only if they are functions'
    \component-factory : 'wrap components passed function parameters'

  test-all t, cases, options

function main
  test 'Direct calls' direct-calls
  test 'Ensure callable' test-functional

main!
