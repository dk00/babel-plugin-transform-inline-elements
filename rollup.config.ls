import \rollup-plugin-babel : babel

function bundle-options name
  entry: "src/#name.ls"
  targets:
    * dest: "lib/#name.js" format: \cjs
    * dest: "es/#name.js" format: \es
  plugins: [babel require \./.babelrc]
  source-map: true use-strict: false

entries = <[index helpers]>map bundle-options

export default: entries
