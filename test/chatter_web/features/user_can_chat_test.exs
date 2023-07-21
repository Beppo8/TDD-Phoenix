defmodule ChatterWeb.UserCanChatTest do
  use ChatterWeb.FeatureCase, async:
   @moduledoc """
    We create two user sessions, and they each join the same chat room. One user comments first.
    The second user sees the message and responds. The first user then sees the response.
   """

  test "user can chat with other succesfully", %{metadata: metadata} do
    room = insert(:chat_room)
    user1 = build(:user) |> set_password("password") |> insert()
    user2 = build(:user) |> set_password("password") |> insert()

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
    |> assert_has(message("Hi everyone"))
    |> add_message("Hi, welcome to #{room.name}")

    session1
    |> assert_has(message("Hi, welcome to #{room.name}"))
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

  def message(text) do
    Query.data("role", "message", text: text)
  end
end
