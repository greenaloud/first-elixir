defmodule Test2 do
  def echo do
    receive do
      {sender, token} ->
        send(sender, {:ok, token})
    end
  end

  def send_tokens do
    first = spawn(Test, :echo, [])
    second = spawn(Test, :echo, [])

    send(first, {self(), "Token for First"})
    receive do
      {:ok, message} ->
        IO.inspect(message)
    end

    send(second, {self(), "Token for Second"})
    receive do
      {:ok, message} ->
        IO.inspect(message)
    end

  end
end

Test2.send_tokens()
