defmodule Chatter.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :session_secret, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :hashed_password, :session_secret])
    |> validate_required([:email, :hashed_password, :session_secret])
    |> unique_constraint(:email)
  end
end
