defmodule ChatterWeb.ChatRoomChannelTest do
  use ChatterWeb.ChannelCase, async: true

  describe "new_message event" do
    test "broadcasts message to all users" do
      {:ok, _, socket} = join_channel("chat_room:general")
      payload = %{"body" => "hello world!"}

      push(socket, "new_message", payload)

      assert_broadcast "new_message", ^payload
    end

    defp join_channel(topic) do
      ChatterWeb.UserSocket
      |> socket("", %{})
      |> subscribe_and_join(ChatterWeb.ChatRoomChannel, topic)
    end
  end
end
