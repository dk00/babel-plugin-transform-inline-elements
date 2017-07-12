import FunctionalComponent from './functional-component';

export default (props => React.createElement(
  "div",
  null,
  FunctionalComponent(Object.assign({ a: b }, spread, { c: "d \n e \n f", g: "h" }))
));
