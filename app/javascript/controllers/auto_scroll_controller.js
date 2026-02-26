import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="auto-scroll"
export default class extends Controller {
  connect() {
    // console.log("hi from auto-scroll controller");
    this.element.scrollIntoView();
  }
}
