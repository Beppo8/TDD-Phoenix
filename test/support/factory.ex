defmodule Chatter.Factory do
  use ExMachina.Ecto, repo: Chatter.Repo

  def chat_room_factory do
    %Chatter.Chat.Room{
      name: sequence(:name, &"chat room #{&1}")
    }
  end

  def user_factory do
    %Chatter.User{email: sequence(:email, &"super#{&1}@example.com")}
    |> Ecto.Changeset.change(%{password: "password1"})
    |> Doorman.Auth.Bcrypt.hash_password()
    |> Doorman.Auth.Secret.put_session_secret()
    |> Ecto.Changeset.apply_changes()
  end

  def chat_room_message_factory do
    %Chatter.Chat.Room.Message{
      body: sequence(:body, &"hello there #{&1}"),
      author: sequence(:email, &"user#{&1}@example.com"),
      chat_room: build(:chat_room)
    }
  end
end
