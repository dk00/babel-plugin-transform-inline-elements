import FunctionalComponent from './functional-component';

export default (props => React.createElement(
  'div',
  null,
  FunctionalComponent(
    {
      children: ['begin', props.head, 'should be concatenated', props.body, 'end']
    }
  )
));
