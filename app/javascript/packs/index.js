document.addEventListener("DOMContentLoaded", () => {
  const redirectToHome = () => {
    window.location.href = "/home";
  };

  // Set the timeout to redirect after 3 seconds
  const timeoutId = setTimeout(redirectToHome, 5000);

  // Set up the click event to redirect immediately and clear the timeout
  document.getElementById("get-started").addEventListener("click", () => {
    clearTimeout(timeoutId);
    redirectToHome();
  });
});
