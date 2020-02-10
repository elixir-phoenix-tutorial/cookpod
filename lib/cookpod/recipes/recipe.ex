defmodule Cookpod.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :description, :string
    field :name, :string
    field :picture, :string
    field :state, :string, default: "draft"

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name, :description, :picture])
    |> validate_required([:name, :description, :picture])
    |> unique_constraint(:name)
  end
end
