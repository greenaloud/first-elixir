defmodule Exercise.Stack do
  use GenServer

  def init(initial_list) do
    { :ok, initial_list }
  end

  def handle_call(:pop, _from, stack) do
    case stack do
      [head | tail] ->
        { :reply, hd(stack), tail }
      [] ->
        { :reply, :empty, [] }
    end
  end

  def handle_cast({:push, val}, stack) do
    { :noreply, [val | stack] }
  end
end
