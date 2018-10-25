defmodule QuickSort do
  @moduledoc """
    Implement both sequential and parallel versions of the Quick Sort Algorithm
  """

  @doc """
    Sequential version of the Quick Sort algorithm.
  """
  def sequential([]), do: []

  def sequential([pivot | []]), do: [pivot]

  def sequential([pivot | rest]) do
    {smaller_or_equal, greater} = partitionate_list(pivot, rest)
    sequential(smaller_or_equal) ++ [pivot] ++ sequential(greater)
  end

  @doc """
    Parallel version of the Quick Sort algorithm. The current thread spawns two
    new threads that run parallely.
  """
  def parallel([]), do: []

  def parallel([pivot | []]), do: [pivot]

  def parallel([pivot | rest]) do
    {smaller_or_equal, greaters} = partitionate_list(pivot, rest)
    Parallel.task(fn -> sequential(smaller_or_equal) end, :smallers)
    Parallel.task(fn -> sequential(greaters) end, :greaters)

    Parallel.capture_task(:smallers) ++
      [pivot] ++ Parallel.capture_task(:greaters)
  end

  defp partitionate_list(pivot, list) do
    Enum.split_with(list, fn elem -> elem <= pivot end)
  end
end
