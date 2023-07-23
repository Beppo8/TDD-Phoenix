defmodule Chatter.RoomTest do
  use Chatter.DataCase, async: true

  alias Chatter.Chat.Room

  describe "changeset/2" do
    test "validates that a name is provided" do
      changeset = Room.changeset(%Room{}, %{})

      assert "can't be blank" in errors_on(changeset).name
    end

    test "validates that name is unique" do
      insert(:chat_room, name: "elixir")
      params = params_for(:chat_room, name: "elixir")

      {:error, changeset} =
        %Room{}
        |> Room.changeset(params)
        |> Repo.insert()

      assert "has already been taken" in errors_on(changeset).name
    end
  end
end
