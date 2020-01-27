defmodule CookpodWeb.UserView do
  use CookpodWeb, :view

  def render_error({message, _options}), do: message
end
