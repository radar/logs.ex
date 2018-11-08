defmodule Logs.Channels.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :text
    field :type
    belongs_to :person, Logs.People.Person
    belongs_to :channel, Logs.Channels.Channel
    field :hidden, :boolean
    field :created_at, :utc_datetime
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
