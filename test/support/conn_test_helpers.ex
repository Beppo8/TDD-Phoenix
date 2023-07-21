defmodule ChatterWeb.ConnTestHelpers do
  import Chatter.Factory

  def sign_in(conn) do
    user = insert(:user)

    conn
    |> Plug.Test.init_test_session(%{})
    |> Doorman.Login.Session.login(user)
  end
end
