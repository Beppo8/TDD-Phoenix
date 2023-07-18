defmodule Chatter.Chat.Room do
  use Ecto.Schema

  schema "chat_rooms" do
    field :name, :string

    timestamps()
  end
end
