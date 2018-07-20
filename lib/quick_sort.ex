defmodule QuickSort do
  @moduledoc """
    Implement both linear and parallel versions of the Quick Sort Algorithm
  """

  @doc """
    Linear version of the Quick Sort algorithm.
  """
  def linear([]), do: []

  def linear([pivot | []]), do: [pivot]

  def linear([pivot | rest]) do
    {smaller_or_equal, greater} = partitionate_list(pivot, rest)
    linear(smaller_or_equal) ++ [pivot] ++ linear(greater)
  end

  @doc """
    Parallel version of the Quick Sort algorithm. The current thread spawns two
    new threads that run parallely.
  """
  def parallel([]), do: []

  def parallel([pivot | []]), do: [pivot]

  def parallel([pivot | rest]) do
    {smaller_or_equal, greaters} = partitionate_list(pivot, rest)
    Parallel.task(fn -> linear(smaller_or_equal) end, :smallers)
    Parallel.task(fn -> linear(greaters) end, :greaters)

    Parallel.capture_task(:smallers) ++
      [pivot] ++ Parallel.capture_task(:greaters)
  end

  defp partitionate_list(pivot, list) do
    Enum.split_with(list, fn elem -> elem <= pivot end)
  end
end
