defmodule ChatterWeb.UserControllerTest do
  use ChatterWeb.ConnCase, async: true

  describe "create/2" do
    test "renders page with errors when data is invalid", %{conn: conn} do
      user = insert(:user, email: "taken@example.com")
      params = string_params_for(:user, email: user.email)

      response =
        conn
        |> post(Routes.user_path(conn, :create, %{"user" => params}))
        |> html_response(200)

      assert response =~ "has already been taken"
    end
  end
end
