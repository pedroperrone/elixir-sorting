# The definition of this module was taken from https://stackoverflow.com/questions/29668635/how-can-we-easily-time-function-calls-in-elixir

defmodule Benchmark do
  def measure(function) do
    function
    |> :timer.tc()
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end
