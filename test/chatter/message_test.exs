defmodule Chatter.Chat.Room.MessageTest do
  use Chatter.DataCase, async: true

  alias Chatter.Chat.Room.Message

  describe "changeset/2" do
    test "validates that an author and body are provided" do
      changes = %{}

      changeset = Message.changeset(%Message{}, changes)

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).body
      assert "can't be blank" in errors_on(changeset).author
    end

    test "validates that record is associated to a chat room" do
      changes = %{"body" => "hello world", "author" => "person@example.com"}

      changeset = Message.changeset(%Message{}, changes)

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).chat_room_id
    end

  end
end
