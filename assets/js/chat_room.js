import socket from "./socket"

let chatRoomTitle = document.getElementById("chat-room-title")

if (chatRoomTitle) {
  let chatRoomName = chatRoomTitle.dataset.chatRoomName
  let channel = socket.channel(`chat_room:${chatRoomName}`, {})

  let messageform = document.getElementById("new-message-form")
  let messageInput = document.getElementById("message")
  let messagesContainer = document.querySelector("[data-role='messages']")

  messageform.addEventListener("submit", event => {
    event.preventDefault()
    channel.push("new_message", {body: messageInput.value})
    event.target.reset()
  })

 const addMessage = (author, body) => {
  let messageItem = document.createElement("li")
    messageItem.dataset.role = "message"
    messageItem.innerText = `${author}: ${body}`
    messagesContainer.appendChild(messageItem)
 }

  channel.on("new_message", payload => {
    addMessage(payload.author, payload.body)
  })

  channel.join()
   .receive("ok", resp => {
      let messages = resp.messages
      messages.map(({ author, body }) => {
        addMessage(author, body)
      });
    })
}
