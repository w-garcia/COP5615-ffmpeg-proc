use Mix.Config
defmodule CLI do
    require Logger

    def main(args) do
       args
       |> parse_args 
    end

    defp parse_args(args) do
        SUPERVISOR.go(args)
    end
end