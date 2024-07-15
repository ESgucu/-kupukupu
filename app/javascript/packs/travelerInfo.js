document.addEventListener("DOMContentLoaded", function () {
  // Save button click event
  const saveButton = document.getElementById("saveTravelerInfoBtn");
  // const signInButton = document.getElementById("signInBtn");

  if (saveButton) {
    saveButton.addEventListener("click", function () {
      // Hide travelerInfoForm
      var travelerForm = document.querySelector(".travelerInfoForm");
      if (travelerForm) {
        travelerForm.style.display = "none";
      }

      // Show membershipInfoForm
      var membershipForm = document.querySelector(".membershipInfoForm");
      if (membershipForm) {
        membershipForm.style.display = "block";
      }
    });
  }

  // if (signInButton) {
  //   signInButton.addEventListener("click", function () {
  //     // Example redirection
  //     window.location.href = "/destinations";
  //   });
  // }
});
