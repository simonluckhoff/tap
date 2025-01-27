import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

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
      })
      .catch((error) => {
        console.error("Error during Unfollow:", error);
      });
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
