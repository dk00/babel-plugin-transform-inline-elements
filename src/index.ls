export function func-name => switch it.type
  | \MemberExpression => "#{func-name it.object}.#{func-name it.property}"
  | _ => it.name

default-options = pragma: \React.createElement

function inline t, [type, props, ...children] scope
  return if type.type == \StringLiteral && !scope.hasBinding type.value

  callee = t.identifier type.value
  properties = props.properties.slice!
  properties.push t.objectProperty (t.identifier \children),
  t.arrayExpression children

  t.callExpression callee, [t.objectExpression properties]
    .._prettyCall = true

function plugin types: t => visitor:
  CallExpression: exit: ({node, scope}: path, state) !->
    return unless (func-name node.callee) == state.get \pragma
    path.replaceWith that if inline t, node.arguments, scope

  Program: (, state) !->
    Object.keys default-options .forEach (key) ->
      state.set key, state.opts[key] || default-options[key]

module.exports = plugin <<< exports
