defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookingsAgent
  alias Flightex.Bookings.Report
  alias Flightex.Users.Agent, as: UsersAgent

  def start_agents do
    BookingsAgent.start_link()
    UsersAgent.start_link()
  end

  def generate_report(from_date, to_date) do
    from_date
    |> Report.call(to_date)
  end
end
