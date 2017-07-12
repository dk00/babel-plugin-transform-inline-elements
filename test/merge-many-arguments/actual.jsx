import FunctionalComponent from './functional-component'

export default props =>
<div>
  <FunctionalComponent {...props.attrs} styles={props.styles}>
    <div>{props.text}</div>
  </FunctionalComponent>
</div>
