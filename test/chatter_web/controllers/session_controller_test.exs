defmodule ChatterWeb.SessionControllerTest do
  use ChatterWeb.ConnCase, async: true

  describe "create/2" do
    test "renders error when email/password combination is invalid", %{conn: conn} do
      user = insert(:user)

      response =
        conn
        |> post(Routes.session_path(conn, :create), %{
          "email" => user.email,
          "password" => "invalid password"
        })
        |> html_response(200)

      assert response =~ "Invalid email or password"
    end
  end
end
