defmodule ChatterWeb.GuestSignsUpTest do
  use ChatterWeb.FeatureCase, async: true

  test "guest signs up with email and password", %{session: session} do
    room = insert(:chat_room)
    attrs = params_for(:user)

    session
    |> visit("/")
    |> click(Query.link("Create an account"))
    |> fill_in(Query.text_field("Email"), with: attrs[:email])
    |> fill_in(Query.text_field("Password"), with: attrs[:password])
    |> click(Query.button("Sign up"))
    |> assert_has(Query.data("role", "room", text: room.name))
  end
end
