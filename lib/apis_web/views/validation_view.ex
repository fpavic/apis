defmodule ApisWeb.ValidationView do
  use ApisWeb, :view

  def render("error.json", %{errors: errors}) do
    %{errors: errors}
  end
end
