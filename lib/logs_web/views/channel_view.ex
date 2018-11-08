defmodule LogsWeb.ChannelView do
  use LogsWeb, :view

  def yesterday(date) do
    {:ok, date} = date |> Calendar.Date.advance(-1)
    date
  end

  def tomorrow(date) do
    {:ok, date} = date |> Calendar.Date.advance(1)
    date
  end

  def pretty_date(date) do
    date |> Calendar.Strftime.strftime!("%Y-%m-%d")
  end
end
