defmodule LogsWeb.Router do
  use LogsWeb, :router

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

  scope "/api", LogsWeb do
    pipe_through :api
    get "/p/:nick/activity", API.PersonController, :activity
  end

  scope "/", LogsWeb do
    pipe_through :browser
    get "/tips", TipController, :index

    get "/", ChannelController, :index
    get "/:name", ChannelController, :show

    get "/p/:nick", PersonController, :show
    get "/p/:nick/activity", PersonController, :activity
    get "/p/stats/most_active", PersonController, :most_active
  end
end
