defmodule ChatterWeb.UserController do
  use ChatterWeb, :controller

  alias Doorman.Login.Session
  alias Chatter.User
  alias Chatter.Accounts

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, params) do
    case Accounts.create_user(params) do
      {:ok, user} ->
        conn
        |> Session.login(user)
        |> redirect(to: "/")

      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end
end
