defmodule Stack.Server do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(val) do
    GenServer.cast(__MODULE__, { :push, val })
  end

  def init(_) do
    { :ok, Stack.Stash.get() }
  end

  def handle_call(:pop, _from, stack) do
    [head | tail] = stack
    { :reply, head, tail }
  end

  def handle_cast({:push, val}, stack) do
    { :noreply, [val | stack] }
  end

  def terminate(_reason, state) do
    Stack.Stash.update(state)
  end
end
