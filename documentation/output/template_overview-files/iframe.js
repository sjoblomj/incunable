// If the user runs Javascript, then hide the fallback
// and show the iframe instead
document.addEventListener("DOMContentLoaded", function(event) {
  const fallbackElements = document.getElementsByClassName("fallback");
  const iframes = document.getElementsByClassName("iframe");
  for (var i = 0; i < fallbackElements.length; i++) {
    fallbackElements[i].style.display = "none";
  }
  for (var i = 0; i < iframes.length; i++) {
    iframes[i].style.display = "block";
  }
});


function resizeIframeToFitContent(iframe, size) {
  iframe.width  = size.width;
  iframe.height = size.height;
}

window.addEventListener("message", (event) => {
  const iframes = document.querySelectorAll("iframe")
  for (var i = 0; i < iframes.length; i++)
    if (event.data.id === iframes[i].id)
      resizeIframeToFitContent(iframes[i], event.data);
})

