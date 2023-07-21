defmodule ChatterWeb.Features.UserVisitsRoomsPageTest do
  use ChatterWeb.FeatureCase, async: true

  test "user visits rooms page to see a list of rooms", %{session: session} do
    [room1, room2] = insert_pair(:chat_room)
    user = insert(:user)

    session
    |> visit(rooms_index())
    |> sign_in(as: user)
    |> assert_has(room_name(room1))
    |> assert_has(room_name(room2))
  end

  defp rooms_index, do: Routes.chat_room_path(@endpoint, :index)

  defp room_name(room) do
    Query.data("role", "room", text: room.name)
  end
end
