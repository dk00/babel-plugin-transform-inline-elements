import FunctionalComponent from './functional-component'

export default props =>
<div>
  <FunctionalComponent>
    begin
    {props.head}
    should
    be
    concatenated
    {props.body}
    end
  </FunctionalComponent>
</div>
