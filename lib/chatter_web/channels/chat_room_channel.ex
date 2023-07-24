defmodule ChatterWeb.ChatRoomChannel do
  use ChatterWeb, :channel

  def join("chat_room:" <> _room_name, _msg, socket) do
    {:ok, socket}
  end

  def handle_in("new_message", payload, socket) do
    author = socket.assigns.email
    outgoing_payload = Map.put(payload, "author", author)
    broadcast(socket, "new_message",outgoing_payload)
    {:noreply, socket}
  end
end
