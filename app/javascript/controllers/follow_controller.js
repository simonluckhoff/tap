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
    // button.textContent = "Following";
    button.innerHTML = '<i class="fa-solid fa-user-check"></i>';
    button.dataset.action = "click->follow#unfollow";
  }

  // updateButtonToFollowing() {
  //   const button = this.buttonTarget;
  //   // Create a new image element
  //   const image = document.createElement('img');
  //   // Set the image source to the asset path (adjust for your specific image location)
  //   // image.src = "/images/notfollowing.svg";
  //   image.src = "<%= asset_path('notfollowing.svg') %>";
  //   image.alt = "Following"; // Add an alt text for accessibility
  //   image.style.width = "40px"; // Optional: Adjust the image size
  //   image.style.height = "40px"; // Optional: Adjust the image size

  //   // Clear existing button content and append the image
  //   button.textContent = ''; // Clear existing text content (if any)
  //   button.appendChild(image);

  //   // Set the button's data-action for toggling state
  //   button.dataset.action = "click->follow#unfollow";
  // }


  updateButtonToFollow() {
    const button = this.buttonTarget;
    // button.textContent = "Follow";
    button.innerHTML = '<i class="fa-solid fa-user-plus"></i>';
    button.dataset.action = "click->follow#follow";
  }

  // updateButtonToFollow() {
  //   const button = this.buttonTarget;

  //   // Create a new image element
  //   const image = document.createElement('img');
  //   // Set the image source to the asset path (adjust for your specific image location)
  //   // image.src = "/images/follow.svg";
  //   image.src = "<%= asset_path('follow.svg') %>";
  //   image.alt = "Follow"; // Add an alt text for accessibility

  //   // Optionally set image size, if needed
  //   image.style.width = "40px";  // Change size if necessary
  //   image.style.height = "40px"; // Change size if necessary

  //   // Clear the current content and append the image
  //   button.textContent = ''; // Clear existing text
  //   button.appendChild(image); // Append the image to the button

  //   // Set the button's data-action attribute for functionality
  //   button.dataset.action = "click->follow#follow";
  // }


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
