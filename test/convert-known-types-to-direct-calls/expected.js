const functionalComponent = ({ children }) => React.createElement(
  "span",
  null,
  children
);
functionalComponent(
  { name: "t", children: ["sample text"]
  }
);