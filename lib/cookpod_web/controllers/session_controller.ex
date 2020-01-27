defmodule CookpodWeb.SessionController do
  use CookpodWeb, :controller

  def create(conn, %{"username" => username, "password" => password}) do
    if auth?(username, password) do
      conn
      |> put_session(:user, username)
      |> put_flash(:info, "Welcome, #{username}!")
      |> redirect(to: "/")
    else
      conn
      |> put_flash(:error, "Incorrect username and/or password")
      |> redirect(to: "/login")
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user)
    |> put_flash(:info, "You've been successfully logged out")
    |> redirect(to: "/")
  end

  defp auth?(username, password) do
    String.length(password) > 0 && password == String.reverse(username)
  end
end
