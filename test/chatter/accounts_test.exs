defmodule Chatter.AccountsTest do
  use Chatter.DataCase, async: true

  alias Chatter.{Accounts, User}

  describe "change_user/1" do
    test "prepares a changeset for a new user" do
      assert %Ecto.Changeset{} = Accounts.change_user(%User{})
    end
  end

  describe "create_user/1" do
    test "creates a user with email and password" do
      params = %{"email" => "random@example.com", "password" => "superpass"}

      {:ok, user} = Accounts.create_user(params)

      assert user.id
      assert user.hashed_password
      assert user.session_secret
      assert user.email == "random@example.com"
    end

    test "returns changeset if fails to create user" do
      params = %{"email" => "random@example.com", "password" => nil}

      {:error, changeset} = Accounts.create_user(params)

      assert "can't be blank" in errors_on(changeset).password
    end
  end
end
