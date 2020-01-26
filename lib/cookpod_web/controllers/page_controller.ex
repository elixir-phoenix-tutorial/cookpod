defmodule CookpodWeb.PageController do
  use CookpodWeb, :controller

  def index(conn, _params) do
    conn
      |> put_flash(:info, "Hello")
      |> put_flash(:error, "Error")
      |> render("index.html")
  end

  def privacy(conn, _params) do
    render(conn, "privacy.html")
  end
end
