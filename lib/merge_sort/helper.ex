defmodule MergeSort.Helper do
  def merge([], []), do: []

  def merge(not_empty_list, []), do: not_empty_list

  def merge([], not_empty_list), do: not_empty_list

  def merge([first_head | first_tail], [second_head | second_tail]) do
    if first_head <= second_head do
      [first_head] ++ merge(first_tail, [second_head | second_tail])
    else
      [second_head] ++ merge([first_head | first_tail], second_tail)
    end
  end

  def divide_list(list) do
    Enum.split(list, trunc(length(list) / 2))
  end
end
