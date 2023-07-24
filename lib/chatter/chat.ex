defmodule Chatter.Chat do
  alias Chatter.{Chat, Repo}
  import Ecto.Query

  def all_rooms do
    Chat.Room |> Repo.all()
  end

  def new_chat_room() do
    %Chat.Room{}
    |> Chat.Room.changeset(%{})
  end

  def create_chat_room(params) do
    %Chat.Room{}
    |> Chat.Room.changeset(params)
    |> Repo.insert()
  end

  def find_room(id) do
    Chat.Room |> Repo.get!(id)
  end

  def find_room_by_name(name) do
    Chat.Room |> Repo.get_by!(name: name)
  end

  def new_message(room, params) do
    room
    |> Ecto.build_assoc(:messages)
    |> Chat.Room.Message.changeset(params)
    |> Repo.insert()
  end

  def room_messages(room) do
    Chat.Room.Message
    |> where([m], m.chat_room_id == ^room.id)
    |> Repo.all()
  end
end
