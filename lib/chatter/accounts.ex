defmodule Chatter.Accounts do
  alias Chatter.{Repo, User}
  alias Doorman.Auth.Secret

  def change_user(user) do
    User.changeset(user, %{})
  end

  def create_user(params) do
    IO.inspect(params, label: "paramsAccounts")
    %User{}
    |> User.changeset(params)
    |> IO.inspect(label: "changeset ---->")
    |> Secret.put_session_secret()
    |> Repo.insert()
  end
end
