defmodule MergeSort.Helper do
  def merge([], []), do: []

  def merge(not_empty_list, []), do: not_empty_list

  def merge([], not_empty_list), do: not_empty_list

  def merge([head | tail], second_list) when head <= hd(second_list) do
    [head | merge(tail, second_list)]
  end

  def merge(first_list, [head | tail]), do: [head | merge(first_list, tail)]

  def divide_list(list) do
    Enum.split(list, trunc(length(list) / 2))
  end
end
