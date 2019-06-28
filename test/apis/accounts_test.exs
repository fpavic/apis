defmodule Apis.AccountsTest do
  use Apis.DataCase

  alias Apis.{Accounts, Auth}
  alias Apis.Accounts.User

  describe "create user" do
    @tag :integration
    test "should succeed with valid data" do
      assert {:ok, %User{} = user} = Accounts.create_user(build(:user))

      assert user.username == "testname"
      assert user.email == "test@test.com"
    end

    @test :integration
    test "should hash password" do
      assert {:ok, %User{} = user} = Accounts.create_user(build(:user))

      assert Auth.validate_password("testpass", user.password_hash)
    end

    @tag :integration
    test "should fail with empty data and return changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(%{email: "", password: "", username: ""})
      assert "can't be blank" in errors_on(changeset).password
      assert "can't be blank" in errors_on(changeset).username
      assert "can't be blank" in errors_on(changeset).email
    end

    @tag :integration
    test "should fail when email taken" do
      assert {:ok, %User{} = user} = Accounts.create_user(build(:user))
      assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(build(:user, username: "username2"))

      assert "has already been taken" in errors_on(changeset).email
    end

    @tag :integration
    test "should fail when invalid email format" do
      assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(build(:user, email: "@email.com"))

      assert "has invalid format" in errors_on(changeset).email
    end

    @tag :integration
    test "should fail when username taken" do
      assert {:ok, %User{} = user} = Accounts.create_user(build(:user))
      assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(build(:user, email: "test2@test.com"))

      assert "has already been taken" in errors_on(changeset).username
    end
  end
end
