defmodule CookpodWeb.Router do
  use CookpodWeb, :router
  use Plug.ErrorHandler

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CookpodWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/privacy", PageController, :privacy
    get "/login", PageController, :login
    resources "/sessions", SessionController, only: [:create, :delete], singleton: true
  end

  # Other scopes may use custom stacks.
  # scope "/api", CookpodWeb do
  #   pipe_through :api
  # end

  defp handle_errors(conn, %{reason: %Phoenix.ActionClauseError{}}) do
    conn
    |> put_status(:unprocessable_entity)
    |> json(%{})
  end

  defp handle_errors(conn, _error), do: conn
end
