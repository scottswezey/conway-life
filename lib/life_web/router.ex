defmodule LifeWeb.Router do
  use LifeWeb, :router

  import Plug.BasicAuth
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LifeWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin_only do
    plug :basic_auth,
      username: "scott",
      password: Application.get_env(:life, LifeWeb.Dashboard)[:admin_pass]
  end

  scope "/", LifeWeb do
    pipe_through :browser

    live "/", GameLive, :index
  end

  scope "/", LifeWeb do
    pipe_through [:browser, :admin_only]

    live_dashboard "/dashboard", metrics: LifeWeb.Telemetry
  end
end
