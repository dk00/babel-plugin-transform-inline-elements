import FunctionalComponent from './functional-component';

export default (props => React.createElement(
  'div',
  null,
  FunctionalComponent(
    { styles: props.styles, children: [React.createElement(
        'div',
        null,
        props.text
      )]
    }
  )
));
