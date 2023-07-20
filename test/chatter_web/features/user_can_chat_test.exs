defmodule ChatterWeb.UserCanChatTest do
  use ChatterWeb.FeatureCase, async:
   @moduledoc """
    We create two user sessions, and they each join the same chat room. One user comments first.
    The second user sees the message and responds. The first user then sees the response.
   """

  test "user can chat with other succesfully", %{metadata: metadata} do
    room = insert(:chat_room)

    user =
      metadata
      |> new_user()
      |> visit(rooms_index())
      |> join_room(room.name)

    other_user =
      metadata
      |> new_user()
      |> visit(rooms_index())
      |> join_room(room.name)

    user
    |> add_message("Hi everyone")

    other_user
    |> assert_has(message("Hi everyone"))
    |> add_message("Hi, welcome to #{room.name}")

    user
    |> assert_has(message("Hi, welcome to #{room.name}"))
  end

  defp new_user(metadata) do
    {:ok, user} = Wallaby.start_session(metadata: metadata)
    user
  end

  defp rooms_index, do: Routes.chat_room_path(@endpoint, :index)

  defp join_room(session, name) do
    session |> click(Query.link(name))
  end

  defp add_message(session, message) do
    session
    |> fill_in(Query.text_field("New Message"), with: message)
    |> click(Query.button("Send"))
  end

  def message(text) do
    Query.data("role", "message", text: text)
  end
end
