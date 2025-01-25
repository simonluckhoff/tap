import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { postId: Number };

  get csrfToken() {
    return document.querySelector('meta[name="csrf-token"]').getAttribute("content");
  }

  like() {
    fetch(`/posts/${this.postIdValue}/like`, {
      method: "POST",
      headers: {
        "Accept": "text/vnd.turbo-stream.html",
        "X-CSRF-Token": this.csrfToken,
      },
    }).catch((error) => console.error("Error liking the post:", error));
  }

  unlike() {
    fetch(`/posts/${this.postIdValue}/like`, {
      method: "DELETE",
      headers: {
        "Accept": "text/vnd.turbo-stream.html",
        "X-CSRF-Token": this.csrfToken,
      },
    }).catch((error) => console.error("Error unliking the post:", error));
  }
}


// export default class extends Controller {
//   static values = {
//     postId: Number
//   }

//   like() {
//     fetch(`/posts/${this.postIdValue}/like`, {
//       method: 'POST',
//       headers: {
//         'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
//         'Content-Type': 'application/json'
//       }
//     })
//     .then(response => {
//       if (response.ok) {
//         return response.json();
//       }
//       throw new Error('Network response was not ok.');
//     })
//     .then(data => {
//       this.updateLikeIcon(true); // Update the UI to show the post is liked
//     })
//     .catch(error => {
//       console.error('There was a problem with the fetch operation:', error);
//     });
//   }

//   unlike() {
//     fetch(`/posts/${this.postIdValue}/unlike`, {
//       method: 'DELETE',
//       headers: {
//         'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
//         'Content-Type': 'application/json'
//       }
//     })
//     .then(response => {
//       if (response.ok) {
//         return response.json();
//       }
//       throw new Error('Network response was not ok.');
//     })
//     .then(data => {
//       this.updateLikeIcon(false); // Update the UI to show the post is unliked
//     })
//     .catch(error => {
//       console.error('There was a problem with the fetch operation:', error);
//     });
//   }

//   updateLikeIcon(isLiked) {
//     const icon = this.element.querySelector('i');
//     if (isLiked) {
//       icon.classList.remove('fa-heart-o');
//       icon.classList.add('fa-heart', 'text-danger', 'liked');
//     } else {
//       icon.classList.remove('fa-heart', 'text-danger', 'liked');
//       icon.classList.add('fa-heart-o');
//     }
//   }
// }
