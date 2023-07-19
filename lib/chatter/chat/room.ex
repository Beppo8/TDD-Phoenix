defmodule Chatter.Chat.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chat_rooms" do
    field :name, :string

    timestamps()
  end

  def changeset(struct, attrs) do
    struct
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
