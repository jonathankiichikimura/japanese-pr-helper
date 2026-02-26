import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spin"
export default class extends Controller {
  start(event) {
    event.preventDefault();
    const icon = '<div class="btn btn-primary disabled"><i class="fa-solid fa-stroopwafel fa-spin"></i></div>';
    const div = this.element;
    div.insertAdjacentHTML("beforeend", icon);
    event.currentTarget.remove();
    this.element.requestSubmit();
  }
}
