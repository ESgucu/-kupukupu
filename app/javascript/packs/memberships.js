document.addEventListener("DOMContentLoaded", () => {
  const addTravelerButton = document.getElementById("add-traveler-button");
  const membershipFormsContainer = document.getElementById("membership-forms");

  addTravelerButton.addEventListener("click", (e) => {
    e.preventDefault();

    const newForm = document.createElement("div");
    newForm.classList.add("form-inputs", "membership-form");

    newForm.innerHTML = `
      <div class="form-inputs">
        <div class="form-group">
          <label for="membership_name">Name</label>
          <input type="text" name="membership[name]" id="membership_name" class="form-control" />
        </div>
        <div class="form-group">
          <label for="membership_travel_date">Travel Date</label>
          <input type="date" name="membership[travel_date]" id="membership_travel_date" class="form-control" />
        </div>
        <div class="form-group">
          <label for="membership_return_date">Return Date</label>
          <input type="date" name="membership[return_date]" id="membership_return_date" class="form-control" />
        </div>
        <div class="form-group">
          <label for="membership_departure">Departure</label>
          <input type="text" name="membership[departure]" id="membership_departure" class="form-control" />
        </div>
      </div>
      <a href="#" class="modify-form-button">Modify</a>
    `;

    membershipFormsContainer.appendChild(newForm);
  });

  document.addEventListener("click", (e) => {
    if (e.target && e.target.classList.contains("modify-form-button")) {
      e.preventDefault();
      const form = e.target.closest(".membership-form");
      const inputs = form.querySelectorAll("input");

      inputs.forEach((input) => {
        input.removeAttribute("readonly");
      });
    }
  });
});
