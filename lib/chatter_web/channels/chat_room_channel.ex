defmodule ChatterWeb.ChatRoomChannel do
  use ChatterWeb, :channel

  alias Chatter.Chat

  def join("chat_room:" <> room_name, _msg, socket) do
    room = Chat.find_room_by_name(room_name)
    messages = Chat.room_messages(room)

    {:ok, %{messages: messages}, assign(socket, :room, room)}
  end

  def handle_in("new_message", payload, socket) do
    %{email: author} = socket.assigns
    outgoing_payload = Map.put(payload, "author", author)
    send(self(), {:store_new_message, outgoing_payload})

    broadcast(socket, "new_message",outgoing_payload)
    {:noreply, socket}
  end

  def handle_info({:store_new_message, payload}, socket) do
    %{room: room} = socket.assigns
    Chat.new_message(room, payload)

    {:noreply, socket}
  end
end
