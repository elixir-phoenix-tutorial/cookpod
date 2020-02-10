defmodule CookpodWeb.RecipeChannel do
  use Phoenix.Channel

  def join("recipe:" <> _channel_id, _params, socket) do
    {:ok, %{ success: true }, socket}
  end
end
