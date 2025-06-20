import consumer from "channels/consumer";
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    initialize() {
      const roomId = document.getElementById('message-box').dataset.roomId;
      const userId = document.getElementById('message-box').dataset.userId;
      const messageListElement = document.getElementById(`messages-list-${roomId}`);
      messageListElement.scrollTo(0, messageListElement.scrollHeight);
      const roomChannelPresent = consumer.subscriptions.subscriptions.some(
        (sub) => {
          const subObj = JSON.parse(sub.identifier);
          return subObj.channel === 'RoomsChannel' && subObj.room === roomId
        }
      );
      if(!roomChannelPresent) {
        consumer.subscriptions.create({ channel: "RoomsChannel", room: roomId}, {
          received(data) {
            const messageObj = JSON.parse(data.message)
            const roomId = document.getElementById('message-box').dataset.roomId;

            const lastMessageTab = document.getElementById(`room-${messageObj.room_id}-last-message`);
            lastMessageTab.innerHTML = messageObj.target_text;

            const messageInputField = document.getElementById('message_source_text')
            messageInputField.value = ""

            if(userId == data.sender_id) {
              $(`#messages-room-${roomId}`).append($.parseHTML( data.sender));
            } else {
              // play chime
              $(`#messages-room-${roomId}`).append($.parseHTML( data.receiver));
            }
            const container = document.getElementById(`messages-list-${roomId}`);
            console.log(`Scrolling to ${messageObj.id} with offset ${$(`#message-${messageObj.id}`).offset().top + container.scrollTop}`);
            container.scrollTo(0, $(`#message-${messageObj.id}`).offset().top + container.scrollTop);
            // Called when there's incoming data on the websocket for this channel
            // console.log('Received data', data);
            // $("#notifications").prepend(data.html);
          },
          disconnected() {
            // Called when the subscription has been terminated by the server
            console.log("RoomChannel disconnected");
            // this.uninstall();
          }
        });
      }
    }
    remove() {
      this.element.remove();
    }
    disconnect()	{
      // console.log("Room disconnected")
    }
};
