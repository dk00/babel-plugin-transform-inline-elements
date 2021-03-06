# babel-plugin-transform-inline-elements

Turn JSX elements into direct function calls or objects.

[![build status](https://travis-ci.org/dk00/babel-plugin-transform-inline-elements.svg)](https://travis-ci.org/dk00/babel-plugin-transform-inline-elements)
[![coverage](https://codecov.io/gh/dk00/babel-plugin-transform-inline-elements/branch/master/graph/badge.svg)](https://codecov.io/gh/dk00/babel-plugin-transform-inline-elements)
[![npm](https://img.shields.io/npm/v/babel-plugin-transform-inline-elements.svg)](https://npm.im/babel-plugin-transform-inline-elements)
[![dependencies](https://david-dm.org/dk00/babel-plugin-transform-inline-elements/status.svg)](https://david-dm.org/dk00/babel-plugin-transform-inline-elements)

## Why?

See this: [45% Faster React Functional Components, Now](//medium.com/missive-app/45-faster-react-functional-components-now-3509a668e69f)

## Example

*In*

```jsx
const Avatar = ({url}) =>
<div class="avatar">
  <img src={url} />
</div>

const element = <Avatar url={avatarUrl} />
```

*Out*

```diff
 const Avatar = ({ url }) => React.createElement(
   "div",
   { "class": "avatar" },
   React.createElement("img", { src: url })
 );

-const element = React.createElement(Avatar, { url: avatarUrl });
+const element = Avatar({ url: avatarUrl });
```

## Caveats

Works with stateless functional components(render functions) only.

Enable `ensureFunctional` option if there are stateful(classful) components in the app.

### `shouldComponentUpdate`(sCU)

There's no `sCU` for stateless functional components.

If a component is expensive to update, consider using `pure` HOC, `pureComponent` or classful components with custom `sCU` for it.

### Higher-order components(HOC)

HOCs can be used if the result component is not warpped with `class`. These HOCs doesn't wrap components with `class`:

- `branch()`
- `defaultProps()`
- `flattenProp()`
- `getContext()`
- `hoistStatics()`
- `mapProps()`
- `next()`
- `renameProp()`
- `renameProps()`
- `renderComponent()`
- `setDisplayName()`
- `setPropTypes()`
- `setStatic()`
- `withProps()`
- `wrapDisplayName()`

### React Developer Tools

Developer tools won't show inlined components.

### `context`, `key`, `ref`

React internals are required to use these.

### `defaultProps`, `propTypes`

```js
import PropTypes from 'prop-types'

const handleProps = component => props => {
  const mergedProps = Object.assign({}, component.defaultProps, props)
  PropTypes.checkPropTypes(component.propTypes, mergedProps, 'prop', component.displayName)
  return component(mergedProps)
}
```

## Installation

```
npm i --save-dev babel-plugin-transform-react-jsx babel-plugin-transform-inline-elements
```

## Usage

*.babelrc.js*

```js
module.exports = {
  plugins: ['transform-react-jsx', 'transform-inline-elements']
}
```

### Via CLI

```
babel --plugins transform-react-jsx transform-inline-elements script.js
```

### Via Node API

```js
require('babel-core').transform('code', {
  plugins: ['transform-react-jsx', 'transform-inline-elements']
});
```

## Options

### `ensureFunctional`

`boolean`, defaults to `false`.

Call components directly only if they are functions.

Enable this when using stateful components.

**In**

```jsx
import Avatar from './avatar'

const element = <Avatar url={avatarUrl} />
```

**Out**

```js
import { ensureFunctional as _ensureFunctional } from 'babel-plugin-transform-inline-elements/es/helpers.js';
import Avatar from './avatar';

const _Avatar = _ensureFunctional(React.createElement, Avatar);

const element = _Avatar({ url: avatarUrl });
```
