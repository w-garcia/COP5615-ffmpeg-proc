defmodule Input do
    use GenServer

    def start_link do
        GenServer.start_link(__MODULE__, :ok)
    end

    def init(:ok) do
        # :ok passed from 2nd argument of start_link
        # [] is initial state of the server
        {:ok, []}
    end

    def start_watching(selfpid) do
        str = String.trim(IO.gets("> "))

        case str do
            _ -> IO.puts(str)
        end

        start_watching(selfpid)
    end
end