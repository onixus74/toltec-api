defmodule Toltec.Accounts do
  import Ecto.Query, warn: false
  alias Toltec.Repo

  alias Toltec.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    result =
      %User{}
      |> User.registration_changeset(attrs)
      |> Repo.insert()

    case result do
      {:ok, user} -> {:ok, %User{user | password: nil}}
      _ -> result
    end
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
