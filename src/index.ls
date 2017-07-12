t = void

function merge-objects
  callee = t.member-expression (t.identifier \Object), t.identifier \assign
  t.call-expression callee, it

function last => it?slice -1 .0
function pack-object
  if it.arguments
    it.arguments.push t.object-expression [] if !last that .properties
    it
  else merge-objects [t.object-expression []; it, t.object-expression []]

function pack-children
  t.object-property (t.identifier \children), t.array-expression it

function merge props, children
  result = if props.properties then props else pack-object props
  (last result.arguments or result)properties.push pack-children children
  result

function direct-call type, attributes, ...children
  props = if t.is-null-literal attributes then t.object-expression []
  else attributes
  arg = if children.length == 0 then props else merge props, children
  t.call-expression type.object, [arg]

!function rewrite-element {scope, {opening-element: {name}}: node}: path
  type-name = name.name.replace /-([A-z])/g (, head) -> head.to-upper-case!
  if scope.has-binding type-name
    name.name = type-name
    node.opening-element.name = t.JSX-member-expression name, name
    node._direct-call = true

!function rewrite-call {node}: path
  if node._direct-call
    node._direct-call = false
    path.replace-with t.inherits (direct-call ...node.arguments), node

function plugin
  t := it.types
  visitor:
    JSXElement: rewrite-element
    CallExpression: rewrite-call

export default: plugin
