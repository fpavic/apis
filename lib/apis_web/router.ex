defmodule ApisWeb.Router do
  use ApisWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug ApisWeb.AuthenticateUser
    plug ApisWeb.SetUser
  end

  scope "/api", ApisWeb do
    pipe_through :api

    post "/users", UserController, :create
  end

  scope "/api", ApisWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/user", CurrentUserController, :show
    resources "/apiaries", ApiaryController, except: [:new, :edit]
  end

  scope "/api", ApisWeb do
    pipe_through [:api]

    post "/users/login", SessionController, :create
  end
end
