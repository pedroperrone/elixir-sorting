[![Codacy Badge](https://api.codacy.com/project/badge/Grade/fc5fc473d7ce4eafa09211e97d898d66)](https://app.codacy.com/app/pedroperrone/elixir-sorting?utm_source=github.com&utm_medium=referral&utm_content=pedroperrone/elixir-sorting&utm_campaign=badger)
[![Build Status](https://semaphoreci.com/api/v1/pedroperrone/elixir-sorting/branches/master/badge.svg)](https://semaphoreci.com/pedroperrone/elixir-sorting)

# ExSorting

## Dependencies
* Elixir 1.6.4

## The project

The content in this repository was made with the intent of practice the use of the Elixir language and explore its parallelization capacity.

To use it, clone this repo, navigate to its directory and run `iex -S mix`. There you will have access to two sorting algorithms (MergeSort and QuickSort) with their sequential and parallel versions. You can use them following this exemple:
```
list = [4, 7, 2, 9, 0]
MergeSort.parallel(list)
```
The project also has a `Benchmark` module to assist you in the performance tests. If you want to test how much time it takes to sort a randomic list with 10 million elements, you can use the `Benchmark.random_list_with_size/1` and `Benchmark.measure/1` functions.

```
list = Benchmark.random_list_with_size(10_000_000)
Benchmark.measure(fn -> MergeSort.parallel(list, 3) end)
```
