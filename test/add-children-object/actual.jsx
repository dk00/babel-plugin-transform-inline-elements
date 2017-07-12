import FunctionalComponent from './functional-component'

export default props =>
<div>
  <FunctionalComponent {...props.attrs}>
    <div>{props.text}</div>
  </FunctionalComponent>
</div>
