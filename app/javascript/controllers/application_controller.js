import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['userBtn', 'userList'];

  pageClick() {
    const userList = this.userListTarget
    userList.classList.add('hidden');
  }

  headerUserToggle() {
    const userList = this.userListTarget
    setTimeout(function () {
      userList.classList.toggle('hidden');
    }, 10);
  }
}