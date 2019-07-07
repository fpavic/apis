defmodule Apis.Factory do
  use ExMachina

  def user_factory do
    %{
      email: "test@test.com",
      username: "testname",
      password: "testpass"
    }
  end

  def apiary_factory do
    %{
      name: "apiaryname",
      lng: 19.8846,
      lat: 44.3573
    }
  end
end
