import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "county"]

  connect() {
    // Initial setup can go here if needed
  }

  follow(event) {
    event.preventDefault()
    const userId = this.element.dataset.userId
    const url = `/users/${userId}/follow`

    this.performRequest(url, "POST")
      .then(() => {
        this.updateButtonToFollowing();
        this.updateCount();
      })
      .catch((error) => {
        console.error("Error during Follow:", error);
      });
  }

  unfollow(event) {
    event.preventDefault()
    const userId = this.element.dataset.userId
    const url = `/users/${userId}/unfollow`

    this.performRequest(url, "DELETE")
      .then(() => {
        this.updateButtonToFollow();
        this.minusCount();
      })
      .catch((error) => {
        console.error("Error during Unfollow:", error);
      });
  }

  updateCount() {
    const count = this.countyTarget;
    count.textContent = parseInt(count.textContent) + 1;
    // parseInt = converts string to integer to + 1
  }

  minusCount() {
    const count = this.countyTarget;
    count.textContent = parseInt(count.textContent) - 1;
    // parseInt = converts string to integer to + 1
  }

  updateButtonToFollowing() {
    const button = this.buttonTarget;
    button.textContent = "Following";
    button.dataset.action = "click->follow#unfollow";
  }

  updateButtonToFollow() {
    const button = this.buttonTarget;
    button.textContent = "Follow";
    button.dataset.action = "click->follow#follow";
  }

  async performRequest(url, method) {
    const response = await fetch(url, {
      method: method,
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        "Content-Type": "application/json",
      },
    });

    if (!response.ok) {
      throw new Error("Failed to perform action.");
    }

    return response.json();
  }
}
