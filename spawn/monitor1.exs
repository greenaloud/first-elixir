defmodule Monitor1 do
  import :timer, only: [ sleep: 1 ]
  def sad_function do
    sleep(500)
    exit(:boom)
  end

  def run do
    res = spawn_monitor(Monitor1, :sad_function, [])
    IO.puts(inspect(res))
    receive do
      msg ->
        IO.puts("Message: #{inspect(msg)}")
      after 1000 ->
        IO.puts("Nothing has happened as far as I an concerened")
    end
    IO.puts("Finished!!")
  end
end

Monitor1.run
