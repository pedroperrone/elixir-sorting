defmodule MergeSort.Linear do
  import MergeSort.Helper

  def perform([]), do: []

  def perform([single_element | []]), do: [single_element]

  def perform(list) do
    divide_list(list)
    |> merge_sublists
  end

  defp divide_list(list) do
    Enum.split(list, trunc(length(list) / 2))
  end

  defp merge_sublists({ first_list, second_list }) do
    merge(perform(first_list), perform(second_list))
  end
end
