# The definition of this module was taken from https://stackoverflow.com/questions/29668635/how-can-we-easily-time-function-calls-in-elixir

defmodule Benchmark do
  @moduledoc """
    Module to help to measure the performance of the sorting functions.
  """

  @doc """
    Receives a function and measure, in seconds, how much time it takes to run.
  """
  def measure(function) do
    function
    |> :timer.tc()
    |> elem(0)
    |> Kernel./(1_000_000)
  end

  @doc """
    Generate a list of random numbers with the specified size.
  """
  def random_list_with_size(size) do
    Enum.map(0..size, fn x -> Enum.random(0..size) end)
  end
end
