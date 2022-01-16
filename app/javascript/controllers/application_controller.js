import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['userBtn', 'userList', 'flashMessages'];

  pageClick() {
    const userList = this.userListTarget;
    userList.classList.add('hidden');
  }

  headerUserToggle() {
    const userList = this.userListTarget;
    setTimeout(function () {
      userList.classList.remove('hidden');
    }, 10);
  }

  flash_messages_close() {
    const flashMessages = this.flashMessagesTarget;
    flashMessages.classList.add('hidden');
  }
}