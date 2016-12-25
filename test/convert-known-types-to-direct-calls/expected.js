const functionalComponent = ({ children }) => ({
  type: "span",
  props: {
    children: [children]
  },
  key: null,
  ref: null
});
functionalComponent(
  { name: "t", children: ["sample text"]
  }
);