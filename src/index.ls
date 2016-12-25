export function func-name => switch it.type
  | \MemberExpression => "#{func-name it.object}.#{func-name it.property}"
  | _ => it.name

function property t, key, value
  t.objectProperty (t.identifier key), value

function object t, properties
  t.objectExpression properties.map ([key, value]) ->
    property t, key, value

function with-children t, props, children
  properties = props.properties?slice! || []
  properties.push property t, \children children
  t.objectExpression properties

function inline t, scope, create-element, [type, props, ...rest]
  children = t.arrayExpression rest
  if type.type == \StringLiteral && !scope.hasBinding type.value
    return object t, create-element t, type.value, props, children

  callee = t.identifier type.value
  t.callExpression callee, [with-children t, props, children]
    .._prettyCall = true

function preact-create-element t, name, props, children => properties =
  [\nodeName t.stringLiteral name]
  [\attributes props] [\children children]

function react-create-element t, name, props, children => properties =
  [\type t.stringLiteral name]
  [\props with-children t, props, children]
  [\key t.nullLiteral!]
  [\ref t.nullLiteral!]

presets =
  react:
    pragma: \React.createElement
    createElement: react-create-element
  preact:
    pragma: \h
    createElement: preact-create-element

function plugin types: t => visitor:
  CallExpression: exit: ({node, scope}: path, state) !->
    return unless (func-name node.callee) == state.get \pragma
    path.replaceWith inline t, scope,
    (state.get \createElement), node.arguments

  Program: (, state) !->
    preset = presets[state.opts.preset] || presets.react
    <[pragma createElement]>forEach ->
      state.set it, state.opts[it] || preset[it]

module.exports = plugin <<< exports
