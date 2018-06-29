defmodule QuickSort.Linear do
  def perform([]), do: []

  def perform([pivot | []]), do: [pivot]

  def perform([pivot | rest]) do
    { smaller_or_equal, greater } = partitionate_list(pivot, rest)
    perform(smaller_or_equal) ++ [pivot] ++ perform(greater)
  end

  defp partitionate_list(pivot, list) do
    Enum.split_with(list, fn elem -> elem <= pivot end)
  end
end
