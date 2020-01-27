defmodule Cookpod.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :password_confirmation])
    |> validate_confirmation(:password)
    |> hash_password()
    |> validate_required([:name, :email, :password_hash])
    |> unique_constraint(:email)
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    changeset
    |> change(Bcrypt.add_hash(password))
  end

  defp hash_password(changeset), do: changeset
end
