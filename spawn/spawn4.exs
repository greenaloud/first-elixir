defmodule Spawn4 do
  def greet do
    receive do
      {sender, msg} ->
        send(sender, { :ok, "Hello, #{msg}" })
        greet()
    end
  end
end

pid = spawn(Spawn4, :greet, [])

send pid, {self(), "World!"}
receive do
  {:ok, message} ->
    IO.puts(message)
  end

send pid, {self(), "WONWOO!"}
receive do
  {:ok, message} ->
    IO.puts(message)
  after 500 ->
    IO.puts("Greeter gone")
end
