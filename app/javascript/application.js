// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "@popperjs/core";
import "bootstrap";
import React from "react";
import ReactDOM from "react-dom";
import { Provider } from "react-redux";
import { createStore } from "redux";
import rootReducer from "../reducers";
import TripCreation from "../components/TripCreation";

document.addEventListener("DOMContentLoaded", () => {
  const store = createStore(rootReducer);

  ReactDOM.render(
    <Provider store={store}>
      <TripCreation />
    </Provider>,
    document.body.appendChild(document.createElement("div"))
  );
});
