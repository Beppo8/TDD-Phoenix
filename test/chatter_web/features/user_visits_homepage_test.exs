defmodule ChatterWeb.UserVisitsHomepageTest do
  use ChatterWeb.FeatureCase, async: true

  test "user can visit homepage", %{session: session} do
    user = insert(:user)

    session
    |> visit("/")
    |> sign_in(as: user)
    |> assert_has(Query.css(".title", text: "Welcome to Chatter!"))
  end

  defp rooms_index, do: Routes.chat_room_path(@endpoint, :index)

  defp room_name(room) do
    Query.data("role", "room", text: room.name)
  end
end
