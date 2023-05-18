defmodule Stack.Stash do
  use GenServer

  @me __MODULE__

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: @me)
  end

  def get() do
    GenServer.call(@me, { :get })
  end

  def update(new_state) do
    GenServer.cast(@me, { :update, new_state })
  end

  def init(initial_state) do
    { :ok, initial_state }
  end

  def handle_call({ :get }, _from, state) do
    { :reply, state, state }
  end

  def handle_cast({ :update, new_state }, _state) do
    { :noreply, new_state }
  end
end
