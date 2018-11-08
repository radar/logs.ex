defmodule LogsWeb.PageController do
  use LogsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
