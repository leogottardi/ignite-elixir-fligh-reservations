defmodule Flightex.Users.Agent do
  use Agent

  alias Flightex.Users.User

  def start_link(params \\ %{}) do
    Agent.start_link(fn -> params end, name: __MODULE__)
  end

  def save(user), do: Agent.update(__MODULE__, &save_user(&1, user))

  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  defp get_user(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp save_user(state, %User{cpf: cpf} = user), do: Map.put(state, cpf, user)
end
