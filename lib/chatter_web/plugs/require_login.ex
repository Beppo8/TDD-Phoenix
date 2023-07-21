defmodule ChatterWeb.Plugs.RequireLogin do
  import Plug.Conn

  alias ChatterWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, _opts) do
    if Doorman.logged_in?(conn) do
      conn
    else
      conn
      |> Phoenix.Controller.redirect(to: Routes.session_path(conn, :new))
      |> halt()
    end
  end
end
