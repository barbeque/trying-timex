defmodule TryingtimexTest do
  use ExUnit.Case
  doctest Tryingtimex
  use Timex

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "getting week ranges is 7 days apart" do
    range = Tryingtimex.get_todays_week_range
    assert Timex.diff(elem(range, 0), elem(range, 1), :days) == -6
  end
end
