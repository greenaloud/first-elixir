defmodule Test3 do
  import :timer, only: [sleep: 1]

  def receive_message_loop do
    receive do
      {:ok, message} ->
        IO.puts(message)
    end
    receive_message_loop()
  end

  def for_child(parent_pid) do
    send(parent_pid, {:ok, "Hello from child: #{inspect self()}"})
    # throw("Intentional Throw")
  end

  def run do
    spawn_link(Test3, :for_child, [self()])

    sleep(500)
    receive_message_loop()
  end
end

Test3.run()
