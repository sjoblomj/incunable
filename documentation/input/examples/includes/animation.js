var direction = 1;
const max_pixels = 100;
const buffersize = 20;

function moveText() {
  const text = document.getElementById("textid");

  var margin = text.style.marginTop;
  if (margin === "")
    margin = buffersize;
  else
    margin = parseInt(margin.replace("px", ""));

  if (margin == buffersize)
    direction = 1;
  if (margin == max_pixels - buffersize)
    direction = -1;
  const top = margin + (2 * direction);
  text.style.marginTop    = top + "px";
  text.style.marginBottom = (max_pixels - top) + "px";
  setTimeout(moveText, 100);
}

document.addEventListener("DOMContentLoaded", (event) => {
  const tag = document.createElement("p");
  const text = document.createTextNode("Javascript animated text");
  tag.setAttribute("id", "textid");
  tag.appendChild(text);
  document.body.appendChild(tag);
  setTimeout(moveText, 100);
})
