function ensure-functional h, type
  if typeof type == \function then type else (props) ~> h type, props

export {ensure-functional}
