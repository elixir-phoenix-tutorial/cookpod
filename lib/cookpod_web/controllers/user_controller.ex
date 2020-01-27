defmodule CookpodWeb.UserController do
  use CookpodWeb, :controller

  require Logger

  def new(conn, _params) do
    render(conn, "new.html", csrf_token: get_csrf_token(), user: %Cookpod.User{}, errors: [])
  end

  def create(conn, %{"user" => user_params}) do
    result =
      %Cookpod.User{}
      |> Cookpod.User.changeset(user_params)
      |> Cookpod.Repo.insert()

    case result do
      {:ok, user} ->
        redirect(conn, to: "/")
      {:error, changeset} ->
        Logger.debug("changeset: #{inspect(changeset)}")
        Logger.debug("errors: #{inspect(changeset.errors)}")
        render(conn, "new.html", csrf_token: get_csrf_token(), user: changeset.data, errors: changeset.errors)
    end
  end
end
