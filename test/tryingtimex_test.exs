defmodule TryingtimexTest do
  use ExUnit.Case
  doctest Tryingtimex
  use Timex

  test "getting week ranges is 7 days apart" do
    {monday, sunday} = Tryingtimex.get_todays_week_range
    assert Timex.diff(monday, sunday, :days) == -6
  end

  test "figure out how to group" do
    jan = Timex.from_iso_triplet({2015, 1, 1})
    feb = Timex.from_iso_triplet({2015, 5, 1})
    jan_range = Tryingtimex.get_week_range(jan)
    feb_range = Tryingtimex.get_week_range(feb)

    records = [ make_record('trent', jan), make_record('trent', feb), make_record('bob', feb), make_record('bob', feb), make_record('steve', feb) ]

    with_ranges = Enum.map(records, fn r -> %{ name: r.name, range: Tryingtimex.get_week_range(r.when) } end)

    # { range1 => [ group of hits ], range2 => [ group of hits ], ... }
    grouped_by_range = Enum.group_by(with_ranges, fn r -> r.range end)
    with_hits = Enum.map(grouped_by_range, fn { range, hits } -> { range, extract_counts(hits) } end) |> Enum.into(%{})
    assert with_hits[jan_range]['trent'] == 1
    assert with_hits[feb_range]['trent'] == 1
    assert with_hits[feb_range]['bob'] == 2
  end

  def extract_counts(hits_for_range) do
    # [ %{ name, when }, %{ name, when }, %{ name, when }, %{ name, when }, ... ]
    Enum.map(hits_for_range, fn c -> c.name end) # just names
      |> Enum.group_by(fn nom -> nom end) # group by the names
      |> Enum.map(fn {name, occurrences} -> {name, length(occurrences)} end) # convert groups into counts
      |> Enum.into(%{}) # put it all in a nice map
  end

  def make_record(name, date) do
    # todo: random date?
    %{name: name, when: date}
  end
end
