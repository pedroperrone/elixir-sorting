defmodule MergeSort do
  @moduledoc """
    Implement both linear and parallel versions of the Merge Sort Algorithm
  """

  @doc """
    Linear version of the Merge Sort algorithm.
  """
  def linear([]), do: []
  def linear(list = [_]), do: list

  def linear(list) do
    list
    |> divide_list
    |> sort_sublists_linearly_and_merge
  end

  @doc """
    Parallel version of Merge Sort algirithm. Receives a list and a number wich
    represents the amount of levels in the recurtion tree that will spawn new
    threads. The default value is 1.
  """
  def parallel(list, parallelism_level \\ 1)

  def parallel([], _), do: []
  def parallel(list = [_], _), do: list

  def parallel(list, parallelism_level),
    do: parallel(list, parallelism_level, 1)

  defp parallel([], _, _), do: []
  defp parallel(list = [_], _, _), do: list

  defp parallel(list, parallelism_level, current_level) do
    list
    |> divide_list
    |> sort_sublists_and_merge(parallelism_level, current_level + 1)
  end

  defp sort_sublists_linearly_and_merge({first_list, second_list}) do
    merge(linear(first_list), linear(second_list))
  end

  defp merge([], []), do: []
  defp merge(not_empty_list, []), do: not_empty_list
  defp merge([], not_empty_list), do: not_empty_list

  defp merge([head | tail], second_list) when head <= hd(second_list) do
    [head | merge(tail, second_list)]
  end

  defp merge(first_list, [head | tail]), do: [head | merge(first_list, tail)]

  defp divide_list(list) do
    Enum.split(list, trunc(length(list) / 2))
  end

  defp sort_sublists_and_merge(
         {first_list, second_list},
         parallelism_level,
         current_level
       )
       when parallelism_level < current_level do
    Parallel.task(fn -> linear(first_list) end, :first_list)
    Parallel.task(fn -> linear(second_list) end, :second_list)

    capture_sorted_lists_and_merge()
  end

  defp sort_sublists_and_merge(
         {first_list, second_list},
         parallelism_level,
         current_level
       ) do
    Parallel.task(
      fn -> parallel(first_list, parallelism_level, current_level) end,
      :first_list
    )

    Parallel.task(
      fn -> parallel(second_list, parallelism_level, current_level) end,
      :second_list
    )

    capture_sorted_lists_and_merge()
  end

  defp capture_sorted_lists_and_merge do
    merge(
      Parallel.capture_task(:first_list),
      Parallel.capture_task(:second_list)
    )
  end
end
