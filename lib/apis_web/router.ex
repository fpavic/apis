defmodule ApisWeb.Router do
  use ApisWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApisWeb do
    pipe_through :api
  end
end
