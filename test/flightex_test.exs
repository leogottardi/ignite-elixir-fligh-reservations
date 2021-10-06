defmodule FlightexTest do
  use ExUnit.Case

  alias Flightex.Bookings.Agent, as: BookingsAgent

  import Flightex.Factory

  describe "start_agents/0" do
    test "when call, start bookings and users agents" do
      response = Flightex.start_agents()

      assert {:ok, _pid} = response
    end
  end

  describe "generate_report/2" do
    setup do
      BookingsAgent.start_link()
      :ok
    end

    test "when period exist, create a csv with reports" do
      build_list(2, :booking)
      |> Enum.each(&BookingsAgent.save/1)

      Flightex.generate_report(~D[2000-01-01], ~D[2050-01-01])

      response = File.read("report.csv")

      expected_response =
        {:ok,
         "12345678900,Brasilia,Bananeiras,2001-05-07 03:05:00\n12345678900,Brasilia,Bananeiras,2001-05-07 03:05:00\n"}

      assert response == expected_response
    end
  end
end
