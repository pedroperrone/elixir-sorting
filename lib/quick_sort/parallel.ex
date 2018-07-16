defmodule QuickSort.Parallel do
  alias QuickSort.Linear, as: Linear
  def perform([]), do: []

  def perform([pivot | []]), do: [pivot]

  def perform([pivot | rest]) do
    me = self()
    {smaller_or_equal, greater} = partitionate_list(pivot, rest)
    spawn_sort(smaller_or_equal, :smallers, me)
    spawn_sort(greater, :greaters, me)
    capture_sorted_list(:smallers) ++ [pivot] ++ capture_sorted_list(:greaters)
  end

  defp partitionate_list(pivot, list) do
    Enum.split_with(list, fn elem -> elem <= pivot end)
  end

  defp spawn_sort(list, identifier, parent_process) do
    spawn_link(fn ->
      sort_and_send_to_parent_process(list, identifier, parent_process)
    end)
  end

  defp sort_and_send_to_parent_process(list, identifier, parent_process) do
    send(parent_process, {identifier, Linear.perform(list)})
  end

  defp capture_sorted_list(identifier) do
    receive do
      {^identifier, sorted_list} -> sorted_list
    end
  end
end
