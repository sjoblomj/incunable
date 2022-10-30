window.addEventListener('DOMContentLoaded', (event) => {
  const width = document.body.clientWidth;
  const size = {"id": "orange", "width": width + "px", "height": width + "px"};
  window.parent.postMessage(size, "*");
});
