defmodule ChatterWeb.UserCanChatTest do
  use ChatterWeb.FeatureCase, async: false

  test "user can chat with other succesfully", %{metadata: metadata} do
    room = insert(:chat_room)
    user1 = insert(:user)
    user2 = insert(:user)

    session1 =
      metadata
      |> new_session()
      |> visit(rooms_index())
      |> sign_in(as: user1)
      |> join_room(room.name)

    session2 =
      metadata
      |> new_session()
      |> visit(rooms_index())
      |> sign_in(as: user2)
      |> join_room(room.name)

    session1
    |> add_message("Hi everyone")

    session2
    |> assert_has(message("Hi everyone", author: user1))
    |> add_message("Hi, welcome to #{room.name}")

    session1
    |> assert_has(message("Hi, welcome to #{room.name}", author: user2))
  end

  test "new user can see previous messages in chat room", %{metadata: metadata} do
    room = insert(:chat_room)
    user1 = insert(:user)
    user2 = insert(:user)

    metadata
    |> new_session()
    |> visit(rooms_index())
    |> sign_in(as: user1)
    |> join_room(room.name)
    |> add_message("Welcome future users")

    metadata
    |> new_session()
    |> visit(rooms_index())
    |> sign_in(as: user2)
    |> join_room(room.name)
    |> assert_has(message("Welcome future users", author: user1))
  end


  defp new_session(metadata) do
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

  defp message(text, author: author) do
    message =  "#{author.email}: #{text}"
    Query.data("role", "message", text: message)
  end
end
