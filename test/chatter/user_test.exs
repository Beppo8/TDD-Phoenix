defmodule Chatter.UserTest do
  use Chatter.DataCase, async: true

  alias Chatter.User

  describe "changeset/2" do
    test "validates that an email must be present" do
      params = %{}
      changeset = User.changeset(%User{}, params)
      assert "can't be blank" in errors_on(changeset).email
    end

    test "validates that a password must be present" do
      params = %{}

      changeset = User.changeset(%User{}, params)

      assert "can't be blank" in errors_on(changeset).password
    end

    test "creates a hashed_password" do
      params = %{email: "random@example.com", password: "password"}

      changeset = User.changeset(%User{}, params)

      assert changeset.changes.hashed_password
    end

    test "validates that email is unique" do
      insert(:user, email: "taken@example.com")
      params = %{email: "taken@example.com", password: "valid"}

      {:error, changeset} = %User{} |> User.changeset(params) |> Repo.insert()

      assert "has already been taken" in errors_on(changeset).email
    end
  end
end
