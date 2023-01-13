import { Controller } from "stimulus";
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { id: Number };

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "HousesFromUserChannel", user_id: this.idValue },
      { received: (data) => this.renderPartial(data) }
    );
  }

  renderPartial(data) {
    const { house, user, index_data } = data;
    const houseIndex = document.querySelector(`#houseIndex_user_${user.id}`);
    if (houseIndex && index_data) { houseIndex.outerHTML = index_data; }
  }

  disconnect() {
    this.channel.unsubscribe();
  }
}
