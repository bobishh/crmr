defmodule CryptomirrorWeb.Router do
  use CryptomirrorWeb, :router

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

  scope "/", CryptomirrorWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", CryptomirrorWeb do
    pipe_through :api # Use api stack

    get "/calc", CalculatorController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", CryptomirrorWeb do
  #   pipe_through :api
  # end
end
