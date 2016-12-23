const custom = () => <span data="test"></span>;

<div>
  <custom>
    <span id="t"></span>
    <custom />
  </custom>
  <div styles={styles}></div>
</div>
