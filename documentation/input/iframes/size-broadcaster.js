const bsize = {"id": "blue",   "width": "150px", "height": "150px"};
const ysize = {"id": "yellow", "width": "200px", "height": "200px"};
window.parent.postMessage(bsize, "*");
window.parent.postMessage(ysize, "*");
