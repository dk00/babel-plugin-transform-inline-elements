import \rollup-plugin-babel : babel

options =
  entry: \./src/index.ls
  targets:
    * dest: \lib/index.js format: \cjs
    ...
  plugins: [babel require \./.babelrc]
  module-name: require \./package.json .name
  source-map: true use-strict: false

export default: options
