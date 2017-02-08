defmodule Tryingtimex do
  @moduledoc """
  Documentation for Tryingtimex.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Tryingtimex.hello
      :world

  """
  def hello do
    :world
  end

  def get_week_range(date) do
    triplet = date |> Timex.iso_triplet
    # the week starts on monday in erlang land, i guess
    start_week = triplet |> fn({year, week, _}) -> {year, week, 1} end.() |> Timex.from_iso_triplet
    end_week = triplet |> fn({year, week, _}) -> {year, week, 7} end.() |> Timex.from_iso_triplet
    # return it so everyone is happy
    { start_week, end_week }
  end

  def get_todays_week_range do
    get_week_range Timex.now
  end
end
