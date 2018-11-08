defmodule LogsWeb.API.PersonController do
  use LogsWeb, :controller

  alias Logs.People

  def activity(conn, %{"nick" => nick}) do
    person = People.by_nick(nick)
    messages = person |> People.message_count_grouped_by_day

    render conn, activity: messages
  end
end
