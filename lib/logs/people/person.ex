defmodule Logs.People.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field :nick

    has_many :messages, Logs.Channels.Message
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
