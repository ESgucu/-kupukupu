import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share"
export default class extends Controller {
  static values = {
    title: String,
    text: String,
    url: String
  }

  connect() {
    console.log('connected')
  }

  share() {
    let shareData = {
      title: this.titleValue,
      text: this.textValue,
      url: this.urlValue,
    };
    if (navigator.share) {
      try {
        navigator.share(shareData);
        alert(`Thanks for Inviting!`);
      } catch (err) {
        alert(`Couldn't share ${err}`);
      }
    } else {
      alert(`Not supported !!`);
    }
  }
}
