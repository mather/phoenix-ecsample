defmodule Ecsample.User do
  use Ecsample.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :crypted_password, :string
    field :password, :string, virtual: true
    field :address, :string

    timestamps
  end

  # crypted_password will be generated on create.
  @required_fields ~w(name email password address)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:email)
  end

  def create(changeset, repo) do
    changeset
    |> put_change(:crypted_password, hashed_password(changeset.params["password"]))
    |> IO.inspect
    |> repo.insert
  end

  defp hashed_password(raw_password) do
    Comeonin.Bcrypt.hashpwsalt(raw_password)
  end
end
