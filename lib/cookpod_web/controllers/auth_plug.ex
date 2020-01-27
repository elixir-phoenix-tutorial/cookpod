defmodule CookpodWeb.AuthPlug do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    user = get_session(conn, :user)
    if is_nil(user) do
      conn
        |> put_flash(:error, "Please sign in first")
        |> redirect(to: "/login")
        |> halt()
    else
      conn
    end
  end
end
