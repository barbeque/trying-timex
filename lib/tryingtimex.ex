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

  def get_todays_week_range do
    today = Timex.now
      |> Timex.iso_triplet
    # starts on monday i guess
    start_week = today |> fn({year, week, _}) -> {year, week, 1} end.() |> Timex.from_iso_triplet
    end_week = today |> fn({year, week, _}) -> {year, week, 7} end.() |> Timex.from_iso_triplet
    # return it so everyone is happy
    { start_week, end_week }
  end
end
