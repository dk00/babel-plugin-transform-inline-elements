const custom = () => ({
  nodeName: "span",
  attributes: { data: "test" },
  children: []
});

({
  nodeName: "div",
  attributes: null,
  children: [custom(
    {
      children: [{
        nodeName: "span",
        attributes: { id: "t" },
        children: []
      }, custom(
        {
          children: []
        }
      )]
    }
  ), {
    nodeName: "div",
    attributes: { styles: styles },
    children: []
  }]
});