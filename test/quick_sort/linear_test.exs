defmodule QuickSort.LinearTest do
  use ExUnit.Case
  doctest ExSorting
  require IEx

  test "sorts an empty list" do
    assert QuickSort.Linear.perform([]) == []
  end

  test "sorts a list with only one element" do
    assert QuickSort.Linear.perform([1]) == [1]
  end

  test "sorts a list that is already ordered" do
    ordered_list = [1, 2, 3, 4, 5, 6]
    assert QuickSort.Linear.perform(ordered_list) == ordered_list
  end

  test "sorts a random list" do
    list = [3, 6, 1, 8, 2, 9, 4]
    assert QuickSort.Linear.perform(list) == [1, 2, 3, 4, 6, 8, 9]
  end

  test "sorts a list reverse ordered" do
    list = [9, 8, 6, 4, 3, 2]
    assert QuickSort.Linear.perform(list) == [2, 3, 4, 6, 8, 9]
  end

  test "sorts a list with negative numbers" do
    list = [2, -1, 4, 6, -7, -9]
    assert QuickSort.Linear.perform(list) == [-9, -7, -1, 2, 4, 6]
  end

  test "sorts a list with repeated elements" do
    list = [1, 4, 7, 3, 8, 1, 3, 8]
    assert QuickSort.Linear.perform(list) == [1, 1, 3, 3, 4, 7, 8, 8]
  end
end