defmodule MergeSort.Parallel do
  import MergeSort.Helper
  alias MergeSort.Linear, as: Linear

  def perform(list, parallelism_level \\ 1)

  def perform([], _), do: []
  def perform(list = [_], _), do: list
  def perform(list, parallelism_level), do: perform(list, parallelism_level, 1)

  defp perform([], _, _), do: []
  defp perform(list = [_], _, _), do: list

  defp perform(list, parallelism_level, current_level) do
    list
    |> divide_list
    |> merge_sublists(parallelism_level, current_level + 1)
  end

  defp merge_sublists(
         {first_list, second_list},
         parallelism_level,
         current_level
       )
       when parallelism_level < current_level do
    Parallel.task(fn -> Linear.perform(first_list) end, :first_list)
    Parallel.task(fn -> Linear.perform(second_list) end, :second_list)

    merge(
      Parallel.capture_task(:first_list),
      Parallel.capture_task(:second_list)
    )
  end

  defp merge_sublists(
         {first_list, second_list},
         parallelism_level,
         current_level
       ) do
    Parallel.task(
      fn -> perform(first_list, parallelism_level, current_level) end,
      :first_list
    )

    Parallel.task(
      fn -> perform(second_list, parallelism_level, current_level) end,
      :second_list
    )

    merge(
      Parallel.capture_task(:first_list),
      Parallel.capture_task(:second_list)
    )
  end
end
