defmodule Parallel do
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

  def task(task, identifier) do
    me = self()
    spawn_link(fn -> send(me, {identifier, task.()}) end)
  end

  def capture_task(identifier) do
    receive do
      {^identifier, result} -> result
    end
  end
end
