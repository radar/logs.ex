defmodule Logs.People do
  @moduledoc """
  The People context.
  """

  import Ecto.Query, warn: false
  alias Logs.Repo

  alias Logs.Channels.Message
  alias Logs.People.Person

  def by_nick(nick) do
    Person |> where(nick: ^nick) |> Repo.one
  end

  def visible_messages(person, page: page) do
    person
    |> messages_for_person
    |> order_by(desc: :created_at)
    |> preload(:channel)
    |> Repo.paginate(page: page, page_size: 250)
  end

  def year_of_first_message(person) do
    %DateTime{year: year} = person
    |> messages_for_person
    |> select([m], min(m.created_at))
    |> Repo.one

    year
  end

  def year_of_most_recent_message(person) do
    %DateTime{year: year} = person
    |> messages_for_person
    |> select([m], max(m.created_at))
    |> Repo.one

    year
  end

  def message_count_grouped_by_day(person) do
    person
    |> messages_for_person
    |> select({count(), fragment("created_at::DATE as date")})
    |> group_by(fragment("created_at::DATE"))
    |> Repo.all
  end

  defp messages_for_person(person) do
    Message
    |> where(person_id: ^person.id)
  end
end
