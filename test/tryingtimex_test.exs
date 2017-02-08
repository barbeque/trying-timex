defmodule TryingtimexTest do
  use ExUnit.Case
  doctest Tryingtimex
  use Timex

  test "getting week ranges is 7 days apart" do
    {monday, sunday} = Tryingtimex.get_todays_week_range
    assert Timex.diff(monday, sunday, :days) == -6
  end
end
