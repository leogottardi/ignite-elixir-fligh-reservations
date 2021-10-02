defmodule Flightex.Users.User do
  @keys [:name, :email, :cpf, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(%{name: name, email: email, cpf: cpf}) do
    uuid = UUID.uuid4()
    {:ok, %__MODULE__{id: uuid, name: name, email: email, cpf: cpf}}
  end

  def build(_params), do: {:error, "Invalid params"}
end
