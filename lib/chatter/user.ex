defmodule Chatter.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Doorman.Auth.Bcrypt, only: [hash_password: 1]

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
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> hash_password()
    |> unique_constraint(:email)
  end
end
