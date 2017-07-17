import { ensureFunctional as _ensureFunctional } from "babel-plugin-transform-inline-elements/es/helpers.js";
const factory = Type => {
  const _Type = _ensureFunctional(React.createElement, Type);

  return props => _Type(props);
};
