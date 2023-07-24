defmodule ChatterWeb.Plugs.PutUserEmail do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    if current_user = conn.assigns[:current_user] do
      assign(conn, :email, current_user.email)
    else
      conn
    end
  end
end
