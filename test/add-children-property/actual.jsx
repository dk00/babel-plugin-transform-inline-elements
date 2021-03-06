import FunctionalComponent from './functional-component'

export default props =>
<div>
  <FunctionalComponent styles={props.styles} {...props.attrs}>
    <div>{props.text}</div>
  </FunctionalComponent>
</div>
