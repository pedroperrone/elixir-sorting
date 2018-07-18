defmodule MergeSortTest do
  use ExUnit.Case
  doctest ExSorting
  require IEx

  describe "linear sorting" do
    test "sorts an empty list" do
      assert MergeSort.linear([]) == []
    end

    test "sorts a list with only one element" do
      assert MergeSort.linear([1]) == [1]
    end

    test "sorts a list that is already ordered" do
      ordered_list = [1, 2, 3, 4, 5, 6]
      assert MergeSort.linear(ordered_list) == ordered_list
    end

    test "sorts a random list" do
      list = [3, 6, 1, 8, 2, 9, 4]
      assert MergeSort.linear(list) == [1, 2, 3, 4, 6, 8, 9]
    end

    test "sorts a list reverse ordered" do
      list = [9, 8, 6, 4, 3, 2]
      assert MergeSort.linear(list) == [2, 3, 4, 6, 8, 9]
    end

    test "sorts a list with negative numbers" do
      list = [2, -1, 4, 6, -7, -9]
      assert MergeSort.linear(list) == [-9, -7, -1, 2, 4, 6]
    end

    test "sorts a list with repeated elements" do
      list = [1, 4, 7, 3, 8, 1, 3, 8]
      assert MergeSort.linear(list) == [1, 1, 3, 3, 4, 7, 8, 8]
    end
  end

  describe "parallel sorting without parallelism level parameter" do
    test "sorts an empty list" do
      assert MergeSort.parallel([]) == []
    end

    test "sorts a list with only one element" do
      assert MergeSort.parallel([1]) == [1]
    end

    test "sorts a list that is already ordered" do
      ordered_list = [1, 2, 3, 4, 5, 6]
      assert MergeSort.parallel(ordered_list) == ordered_list
    end

    test "sorts a random list" do
      list = [3, 6, 1, 8, 2, 9, 4]
      assert MergeSort.parallel(list) == [1, 2, 3, 4, 6, 8, 9]
    end

    test "sorts a list reverse ordered" do
      list = [9, 8, 6, 4, 3, 2]
      assert MergeSort.parallel(list) == [2, 3, 4, 6, 8, 9]
    end

    test "sorts a list with negative numbers" do
      list = [2, -1, 4, 6, -7, -9]
      assert MergeSort.parallel(list) == [-9, -7, -1, 2, 4, 6]
    end

    test "sorts a list with repeated elements" do
      list = [1, 4, 7, 3, 8, 1, 3, 8]
      assert MergeSort.parallel(list) == [1, 1, 3, 3, 4, 7, 8, 8]
    end
  end

  describe "parallel sorting with parallelism level parameter" do
    test "sorts an empty list" do
      assert MergeSort.parallel([], 2) == []
    end

    test "sorts a list with only one element" do
      assert MergeSort.parallel([1], 1) == [1]
    end

    test "sorts a list that is already ordered" do
      ordered_list = [1, 2, 3, 4, 5, 6]
      assert MergeSort.parallel(ordered_list, 3) == ordered_list
    end

    test "sorts a random list" do
      list = [3, 6, 1, 8, 2, 9, 4]
      assert MergeSort.parallel(list, 4) == [1, 2, 3, 4, 6, 8, 9]
    end

    test "sorts a list reverse ordered" do
      list = [9, 8, 6, 4, 3, 2]
      assert MergeSort.parallel(list, 2) == [2, 3, 4, 6, 8, 9]
    end

    test "sorts a list with negative numbers" do
      list = [2, -1, 4, 6, -7, -9]
      assert MergeSort.parallel(list, 1) == [-9, -7, -1, 2, 4, 6]
    end

    test "sorts a list with repeated elements" do
      list = [1, 4, 7, 3, 8, 1, 3, 8]
      assert MergeSort.parallel(list, 3) == [1, 1, 3, 3, 4, 7, 8, 8]
    end
  end
end
