defmodule LifeWeb.Router do
  use LifeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :live_views do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {LifeWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/", LifeWeb do
  #   pipe_through :browser

  #   get "/", PageController, :index
  #   # live "/game", GameLive
  # end

  scope "/", LifeWeb do
    pipe_through :live_views

    live "/", GameLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", LifeWeb do
  #   pipe_through :api
  # end
end
