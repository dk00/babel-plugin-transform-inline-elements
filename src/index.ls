export function func-name => switch it.type
  | \MemberExpression => "#{func-name it.object}.#{func-name it.property}"
  | _ => it.name

function property t, key, value
  t.objectProperty (t.identifier key), value

function inline t, scope, create-element, [type, props, ...rest]
  children = t.arrayExpression rest
  if type.type == \StringLiteral && !scope.hasBinding type.value
    return create-element? t, type.value, props, children

  properties = props.properties?slice! || []
  properties.push property t, \children children
  callee = t.identifier type.value
  t.callExpression callee, [t.objectExpression properties]
    .._prettyCall = true

function preact-create-element t, name, props, children
  t.objectExpression properties =
    property t, \nodeName t.stringLiteral name
    property t, \attributes props
    property t, \children children

presets =
  react:
    pragma: \React.createElement
  preact:
    pragma: \h
    createElement: preact-create-element

function plugin types: t => visitor:
  CallExpression: exit: ({node, scope}: path, state) !->
    return unless (func-name node.callee) == state.get \pragma
    path.replaceWith that if inline t, scope,
    (state.get \createElement), node.arguments

  Program: (, state) !->
    preset = presets[state.opts.preset] || presets.react
    <[pragma createElement]>forEach ->
      state.set it, preset[it] || state.opts[it]

module.exports = plugin <<< exports
