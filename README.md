# babel-plugin-transform-inline-elements

Turn `creactElement` calls to direct function calls or objects.

Work in progress

[![build status](https://travis-ci.org/dk00/babel-plugin-transform-inline-elements.svg)](https://travis-ci.org/dk00/babel-plugin-transform-inline-elements)
[![coverage](https://codecov.io/gh/dk00/babel-plugin-transform-inline-elements/branch/master/graph/badge.svg)](https://codecov.io/gh/dk00/babel-plugin-transform-inline-elements)
[![dependencies](https://david-dm.org/dk00/babel-plugin-transform-inline-elements/status.svg)](https://david-dm.org/dk00/babel-plugin-transform-inline-elements)

## Example

Source:
```jsx
const functionalComponent = ({children}) => <span>{children}</span>;
<functionalComponent name="t">sample text</functionalComponent>
```

`babel` setup:
```js
babel.transform(code, {
  plugins: ['transform-react-jsx', transformInlineElements]
})
```

Transformed:
```js
const functionalComponent = ({ children }) => React.createElement(
  "span",
  null,
  children
);
functionalComponent(
  { name: "t", children: ["sample text"]
  }
);
```
