defmodule SequentialTicker do
  @interval 2000
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(clients) do
    receive do
      { :register, pid } ->
        IO.puts("registering #{ inspect pid }")
        generator([pid | clients])
      after
        @interval ->
          IO.puts("tick")
          send(hd(clients), { :tick })
          generator(Enum.reverse([hd(clients) | Enum.reverse(tl(clients))]))
    end
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    SequentialTicker.register(pid)
  end

  def receiver do
    receive do
      { :tick } ->
        IO.puts("tock in client")
        receiver()
    end
  end
end
