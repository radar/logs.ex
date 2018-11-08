defmodule LogsWeb.PersonController do
  use LogsWeb, :controller

  alias Logs.People
  alias Logs.People.Person

  def show(conn, %{"nick" => nick, "page" => page}) do
    person = People.by_nick(nick)
    page = People.visible_messages(person, page: page)
    render conn, "show.html",
      person: person, messages: page.entries,
      page_number: page.page_number, total_pages: page.total_pages
  end

  def show(conn, %{"nick" => nick}) do
    show(conn, %{"nick" => nick, "page" => 1})
  end

  def activity(conn, %{"nick" => nick}) do
    person = People.by_nick(nick)
    case person do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(LogsWeb.ErrorView)
        |> render(:"404")
      person ->
        oldest_year = person |> People.year_of_first_message
        most_recent_year = person |> People.year_of_most_recent_message

        render conn, "activity.html",
          person: person,
          oldest_year: oldest_year,
          most_recent_year: most_recent_year
    end
  end
end
