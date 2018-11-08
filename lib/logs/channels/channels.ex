defmodule Logs.Channels do
  @moduledoc """
  The Channels context.
  """

  import Ecto.Query, warn: false
  alias Logs.Repo

  alias Logs.Channels.Channel
  alias Logs.Channels.Message

  def visible do
    visible_channels() |> Repo.all
  end

  def by_name(name) do
    visible_channels() |> where(name: ^name) |> Repo.one
  end

  def messages(channel, date) do
    channel
    |> messages_by_channel(date)
    |> preload(:person)
    |> Repo.all
  end

  def future_messages?(channel, date) do
    next_day = date |> Calendar.Date.advance!(1)

    count = channel
    |> messages_by_channel(next_day)
    |> Repo.aggregate(:count, :id)

    count > 0
  end

  def past_messages?(channel, date) do
    previous_day = date |> Calendar.Date.subtract!(1)

    count = channel
    |> messages_by_channel(previous_day)
    |> Repo.aggregate(:count, :id)

    count > 0
  end

  defp messages_by_channel(channel, date) do
    time = ~T[00:00:00]
    {:ok, until} = date |> Calendar.Date.advance!(1) |> NaiveDateTime.new(time)
    {:ok, from} = NaiveDateTime.new(date, time)

    Message
    |> where(channel_id: ^channel.id)
    |> order_by(asc: :created_at)
    |> where([m], m.created_at >= ^from and m.created_at < ^until)
  end

  defp visible_channels do
    Channel
    |> where(hidden: false)
    |> order_by(asc: :name)
  end
end
