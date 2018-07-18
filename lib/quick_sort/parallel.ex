defmodule QuickSort.Parallel do
  alias QuickSort.Linear, as: Linear
  def perform([]), do: []

  def perform([pivot | []]), do: [pivot]

  def perform([pivot | rest]) do
    me = self()
    {smaller_or_equal, greaters} = partitionate_list(pivot, rest)
    Parallel.task(fn -> Linear.perform(smaller_or_equal) end, :smallers)
    Parallel.task(fn -> Linear.perform(greaters) end, :greaters)

    Parallel.capture_task(:smallers) ++
      [pivot] ++ Parallel.capture_task(:greaters)
  end

  defp partitionate_list(pivot, list) do
    Enum.split_with(list, fn elem -> elem <= pivot end)
  end
end
