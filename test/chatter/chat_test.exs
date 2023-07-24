defmodule Chatter.ChatTest do
  use Chatter.DataCase, async: true

  alias Chatter.Chat

  describe "all_rooms/0" do
    test "returns all rooms available" do
      [room1, room2] = insert_pair(:chat_room)

      rooms = Chat.all_rooms()

      assert room1 in rooms
      assert room2 in rooms
    end
  end

  describe "new_chat_room/0" do
    test "prepares a changeset for a new chat room" do
      assert %Ecto.Changeset{} = Chat.new_chat_room()
    end
  end

  describe "create_chat_room/1" do
    test "creates a room with valid params" do
      params = string_params_for(:chat_room)

      {:ok, room} = Chat.create_chat_room(params)

      assert %Chat.Room{} = room
      assert room.name == params["name"]
    end

    test "returns an error tuple if params are invalid" do
      insert(:chat_room, name: "elixir")
      params = string_params_for(:chat_room, name: "elixir")

      {:error, changeset} = Chat.create_chat_room(params)

      refute changeset.valid?
      assert "has already been taken" in errors_on(changeset).name
    end
  end

  describe "find_room/1" do
    test "retrieves a room by id" do
      room = insert(:chat_room)

      found_room = Chatter.Chat.find_room(room.id)

      assert room == found_room
    end
  end

  describe "find_room_by_name/1" do
    test "retrieves a room by name" do
      room = insert(:chat_room)

      found_room = Chat.find_room_by_name(room.name)

      assert room == found_room
    end
  end

  describe "new_message/2" do
    test "inserts message associated to room" do
      room = insert(:chat_room)
      params = %{"body" => "Hello world", "author" => "random@example.com"}

      {:ok, message} = Chat.new_message(room, params)

      assert message.chat_room_id == room.id
      assert message.body == params["body"]
      assert message.author == params["author"]
      assert message.id
    end

    test "returns a changeset if insert fails" do
      room = insert(:chat_room)
      params = %{}

      {:error, changeset} = Chat.new_message(room, params)

      assert errors_on(changeset).body
    end
  end

  describe "room_messages/1" do
    test "returns all messages associated to given room" do
      room = insert(:chat_room)
      messages = insert_pair(:chat_room_message, chat_room: room)
      _different_room_message = insert(:chat_room_message)

      found_messages = Chat.room_messages(room)

      assert values_match(found_messages, messages, key: :id)
      assert values_match(found_messages, messages, key: :body)
      assert values_match(found_messages, messages, key: :author)
    end
  end

  defp values_match(found_messages, messages, key: key) do
    map_values(found_messages, key) == map_values(messages, key)
  end

  defp map_values(structs, key), do: Enum.map(structs, &Map.get(&1, key))
end
