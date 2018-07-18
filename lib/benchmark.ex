# The definition of this module was taken from https://stackoverflow.com/questions/29668635/how-can-we-easily-time-function-calls-in-elixir

defmodule Benchmark do
  def measure(function) do
    function
    |> :timer.tc()
    |> elem(0)
    |> Kernel./(1_000_000)
  end

  def random_list_with_size(size) do
    Enum.map(0..size, fn x -> Enum.random(0..size) end)
  end
end
