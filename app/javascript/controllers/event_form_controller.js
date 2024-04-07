
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["private", "invitees"]

    connect() {
        this.updateInviteesField()
    }

    updateInviteesField() {
        if (this.privateTarget.checked){
            this.inviteesTarget.style.display = "block"
        } else {
            this.inviteesTarget.style.display = "none"
        }
    }
}