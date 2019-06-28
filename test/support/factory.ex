defmodule Apis.Factory do
  use ExMachina

  def user_factory do
    %{
      email: "test@test.com",
      username: "testname",
      password: "testpass"
    }
  end
end
