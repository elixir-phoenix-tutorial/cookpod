defmodule CookpodWeb.ViewHelpers do
  import Plug.Conn, only: [get_session: 2]

  def logged_in?(conn) do
    not is_nil(get_session(conn, :user))
  end

  def username(conn) do
    case get_session(conn, :user) do
      nil ->
        "anonymous"
      user ->
        user
    end
  end
end
