defmodule LogsWeb.ChannelController do
  use LogsWeb, :controller

  alias Logs.Channels

  def index(conn, _params) do
    render conn, "index.html", channels: Channels.visible
  end

  def show(conn, %{"name" => name, "date" => date}) do
    conn
    |> show_messages(Channels.by_name(name), date |> Date.from_iso8601!)
  end

  def show(conn, %{"name" => name}) do
    channel = Channels.by_name(name)
    date = DateTime.utc_now |> DateTime.to_date
    conn |> show_messages(channel, date)
  end

  defp show_messages(conn, channel, date) do
    messages = Channels.messages(channel, date)
    future_messages = Channels.future_messages?(channel, date)
    past_messages = Channels.past_messages?(channel, date)

    render conn, "show.html",
      channel: channel,
      messages: messages,
      date: date,
      future_messages: future_messages,
      past_messages: past_messages
  end
end
