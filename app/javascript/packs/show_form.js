document.addEventListener("DOMContentLoaded", function () {
  const showFormButton = document.getElementById("show-membership-form");
  const formContainer = document.getElementById("membership-form-container");

  showFormButton.addEventListener("click", function (event) {
    event.preventDefault();
    formContainer.style.display = "block";
    if (showFormButton.style.display == "block")
      showFormButton.style.display = "none";
    else showFormButton.style.display = "block";
  });
});
