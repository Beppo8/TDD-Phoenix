defmodule Chatter.Repo.Migrations.CreateChatRoomMessages do
  use Ecto.Migration

  def change do
    create table(:chat_room_messages) do
      add :chat_room_id, references(:chat_rooms), null: false
      add :body, :text, null: false
      add :author, :string, null: false

      timestamps()
    end

  end
end
