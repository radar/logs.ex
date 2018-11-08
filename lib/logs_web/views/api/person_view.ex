defmodule LogsWeb.API.PersonView do
  use LogsWeb, :view

  def render("activity.json", %{activity: activity}) do
    Enum.map(activity, fn({count, date}) ->
      %{count: count, date: date |> Date.to_iso8601}
    end)
  end
end
