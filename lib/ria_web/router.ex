defmodule RiaWeb.Router do
  use RiaWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {RiaWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RiaWeb do
    pipe_through :browser

    get "/", PostController, :index
    resources "/posts", PostController
  end

  scope "/api", RiaWeb do
    pipe_through :api

    get "/posts", ApiPostController, :list
    get "/posts/:id", ApiPostController, :getById
    post "/posts", ApiPostController, :create
    put "/posts/:id", ApiPostController, :update
    delete "/posts/:id", ApiPostController, :delete
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:ria, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RiaWeb.Telemetry
    end
  end
end
