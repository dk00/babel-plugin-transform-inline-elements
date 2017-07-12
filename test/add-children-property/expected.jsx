import FunctionalComponent from './functional-component';

export default (props => React.createElement(
  'div',
  null,
  FunctionalComponent(
    Object.assign({ styles: props.styles }, props.attrs, {
      children: [React.createElement(
        'div',
        null,
        props.text
      )]
    })
  )
));
