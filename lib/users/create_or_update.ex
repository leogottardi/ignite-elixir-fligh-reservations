defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def call(%{cpf: cpf, email: _email, name: _name}) when not is_bitstring(cpf),
    do: {:error, "Cpf must be a String"}

  def(call(%{cpf: cpf, email: email, name: name})) do
    {:ok, user} = User.build(name, email, cpf)

    user
    |> UserAgent.save()
  end
end
