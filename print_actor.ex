defmodule Printer do
    use GenServer

    # The only purpose of this actor is to print things... ¯\_(ツ)_/¯

    def start_link do
        GenServer.start_link(__MODULE__, :ok)
    end

    def print(pid, str) do
        GenServer.cast(pid, {:print, str})
    end

    def init(:ok) do
        # :ok passed from 2nd argument of start_link
        # [] is initial state of the server
        {:ok, []}
    end

    def handle_cast({:print, string}, currentstate) do
        IO.puts(string)        
        {:noreply, currentstate}
    end

end