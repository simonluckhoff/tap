import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { postId: Number, liked: Boolean }; // Add liked value to track state

  connect() {
    console.log("connected");
    this.updateHeartIcon(this.likedValue); // Initialize the heart icon based on the initial state
  }

  get csrfToken() {
    return document.querySelector('meta[name="csrf-token"]').getAttribute("content");
  }

  toggleLike() {
    if (this.likedValue) {
      this.unlike();
    } else {
      this.like();
    }
  }

  like() {
    fetch(`/posts/${this.postIdValue}/like`, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "X-CSRF-Token": this.csrfToken,
      },
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => {
      console.log(data);
      if (data.liked) {
        this.likedValue = true; // Update the liked state
        this.updateHeartIcon(true);
      }
    })
    .catch((error) => console.error("Error liking the post:", error));
  }

  unlike() {
    fetch(`/posts/${this.postIdValue}/like`, {
      method: "DELETE",
      headers: {
        "Accept": "application/json",
        "X-CSRF-Token": this.csrfToken,
      },
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => {
      console.log(data);
      if (!data.liked) {
        this.likedValue = false; // Update the liked state
        this.updateHeartIcon(false);
      }
    })
    .catch((error) => console.error("Error unliking the post:", error));
  }

  updateHeartIcon(isLiked) {
    const heartIcon = this.element.querySelector('i');
    if (isLiked) {
      heartIcon.classList.add('liked', 'text-danger');
      heartIcon.classList.remove('text-muted');
    } else {
      heartIcon.classList.remove('liked', 'text-danger');
      heartIcon.classList.add('text-muted');
    }
  }
}
