defmodule Chatter.Chat do
  alias Chatter.{Chat, Repo}

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
end
