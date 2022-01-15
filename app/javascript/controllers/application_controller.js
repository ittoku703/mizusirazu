import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['userBtn', 'userList'];

  headerUserToggle() {
    const userBtn = this.userBtnTarget;
    const userList = this.userListTarget

    userList.classList.toggle('hidden');
  }
}