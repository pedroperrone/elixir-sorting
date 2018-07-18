defmodule MergeSort.Parallel do
  import MergeSort.Helper
  alias MergeSort.Linear, as: Linear

  def perform([]), do: []

  def perform([single_element | []]), do: [single_element]

  def perform(list) do
    list
    |> divide_list
    |> merge_sublists
  end

  defp merge_sublists({first_list, second_list}) do
    Parallel.task(fn -> Linear.perform(first_list) end, :first_list)
    Parallel.task(fn -> Linear.perform(second_list) end, :second_list)

    merge(
      Parallel.capture_task(:first_list),
      Parallel.capture_task(:second_list)
    )
  end
end
