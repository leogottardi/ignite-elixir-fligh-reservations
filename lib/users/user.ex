defmodule Flightex.Users.User do
  @keys [:name, :email, :cpf, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(_name, _email, cpf) when not is_bitstring(cpf), do: {:error, "Cpf must be a String"}

  def build(name, email, cpf) do
    uuid = UUID.uuid4()
    {:ok, %__MODULE__{id: uuid, name: name, email: email, cpf: cpf}}
  end

  def build(_name, _email, _cpf), do: {:error, "Invalid params"}
end
