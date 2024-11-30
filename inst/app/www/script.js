$(document).ready(function () {
  const filterBar = document.getElementById("filter-bar");
  const toggleButton = document.getElementById("toggle-filter-bar");
  const body = document.body;

  toggleButton.addEventListener("click", function () {
    const isHidden = filterBar.classList.toggle("hidden");
    body.classList.toggle("filter-hidden", isHidden);
  });
});
