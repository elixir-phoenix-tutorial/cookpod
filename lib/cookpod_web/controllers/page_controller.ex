defmodule CookpodWeb.PageController do
  use CookpodWeb, :controller

  plug CookpodWeb.AuthPlug when not (action in [:index, :login])

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def privacy(conn, _params) do
    render(conn, "privacy.html")
  end

  def login(conn, _params) do
    render(conn, "login.html", csrf_token: get_csrf_token())
  end
end
