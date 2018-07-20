defmodule Parallel do
  @moduledoc """
    Module to run parallel functions.
  """

  @doc """
    Works like `Enum.map/2`, but opens a new thread for each function
    application.
  """
  def map(collectable, function) do
    me = self()

    Enum.map(collectable, fn elem ->
      spawn_link(fn -> send(me, {self(), function.(elem)}) end)
    end)
    |> Enum.map(fn pid ->
      receive do
        {^pid, result} -> result
      end
    end)
  end

  @doc """
    Opens a new thread for a given function with an identifier. The result of
    this function can be captured with `Parallel.capture_task/1` function using
    the same identifier as parameter.
  """
  def task(task, identifier) do
    me = self()
    spawn_link(fn -> send(me, {identifier, task.()}) end)
  end

  @doc """
    Receives the result of a function that run in another thread spawned by
    `Parallel.task/2`. Uses the identifier to know wich response to take.
  """
  def capture_task(identifier) do
    receive do
      {^identifier, result} -> result
    end
  end
end
