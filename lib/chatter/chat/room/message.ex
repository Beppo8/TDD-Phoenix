defmodule Chatter.Chat.Room.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @valid_fields [:author, :body, :chat_room_id]

  @derive {Jason.Encoder, only: [:author, :body, :chat_room_id]}
  schema "chat_room_messages" do
    field :author, :string
    field :body, :string
    belongs_to :chat_room, Chatter.Chat.Room

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, @valid_fields)
    |> validate_required(@valid_fields)
  end
end
