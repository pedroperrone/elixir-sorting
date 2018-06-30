defmodule MergeSort.Parallel do
  import MergeSort.Helper
  alias MergeSort.Linear, as: Linear

  def perform([]), do: []

  def perform([single_element | []]), do: [single_element]

  def perform(list) do
    divide_list(list)
    |> merge_sublists
  end

  defp merge_sublists({first_list, second_list}) do
    me = self()
    spawn_sort(first_list, :first_list, me)
    spawn_sort(second_list, :second_list, me)
    merge(capture_sorted_list(:first_list), capture_sorted_list(:second_list))
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
