defmodule ApisWeb.AuthenticateUser do
  use Guardian.Plug.Pipeline, otp_app: :apis,
    module: Apis.Guardian,
    error_handler: ApisWeb.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
