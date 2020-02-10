defmodule CookpodWeb.Recipe.ResizeController do
  use CookpodWeb, :controller
  alias Cookpod.Recipes
  alias CookpodWeb.Endpoint

  require Logger

  def create(conn, %{"recipe_id" => recipe_id}) do
    # recipe = Recipes.get_recipe!(recipe_id)
    channel_id = generate_uid()
    Recipes.resize_picture(recipe_id, fn() ->
      Logger.info("Done!")
      Endpoint.broadcast("recipe:#{channel_id}", "resize_finished", %{ status: "success" })
    end)
    redirect(conn, to: Routes.recipe_path(conn, :show, recipe_id, %{channel_id: channel_id}))
  end

  def generate_uid() do
    10
    |> :crypto.strong_rand_bytes()
    |> Base.encode16(case: :lower)
  end
end
