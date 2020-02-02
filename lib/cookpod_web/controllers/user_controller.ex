defmodule CookpodWeb.UserController do
  use CookpodWeb, :controller

  require Logger

  def new(conn, _params) do
    changeset = Cookpod.User.new_changeset()
    render(conn, "new.html", csrf_token: get_csrf_token(), changeset: changeset)
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
        render(conn, "new.html", csrf_token: get_csrf_token(), changeset: changeset)
    end
  end
end
