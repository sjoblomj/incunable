
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
    resizeIframe(iframes[i]);
  }
});


function resizeIframe(iframe) {
  iframe.width  = "71px";
  iframe.height = "71px";
}
