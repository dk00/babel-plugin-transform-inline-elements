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
  t.call-expression type, [arg]

function declare-alias pass, [, {_alias}]: args
  helper = add-helper pass
  alias = t.variable-declarator _alias, t.call-expression helper, args
  t.variable-declaration \const [alias]

function insert-alias path, declareation
  wrap = path.find -> it.is-statement! || it.is-function!
  if wrap.is-statement! then wrap.insert-after declareation
  else
    wrap.node.body = t.to-block wrap.node.body, wrap.node
    wrap.node.body.body.unshift declareation

function ensure-functional {scope, node}: path, pass
  {callee, arguments: [object: {name}]} = node
  {identifier, path: origin} = binding = scope.get-binding name
  if !identifier._alias
    identifier._alias = binding.scope.generate-uid-identifier identifier.name
    insert-alias origin, declare-alias pass, [callee, identifier]
  identifier._alias

function camelCase => it.replace /-([A-z])/g (, head) -> head.to-upper-case!
!function rewrite-element {scope, {opening-element: {name}}: node}
  if scope.has-binding type-name = camelCase name.name
    name.name = type-name
    node.opening-element.name = t.JSX-member-expression name, name
    node._direct-call = true

!function rewrite-call {node}: path, {opts}: state
  if node._direct-call
    [{object} ...args] = node.arguments
    node._direct-call = false
    type = if opts.ensure-functional then ensure-functional path, @ else object
    path.replace-with t.inherits (direct-call type, ...args), node

helper-source = \babel-plugin-transform-inline-elements/es/helpers.js
function add-helper
  it.add-import helper-source, \ensureFunctional

function plugin
  t := it.types
  visitor:
    JSXElement: rewrite-element
    CallExpression: rewrite-call

export default: plugin
