use Mix.Config
defmodule CLI do
    require Logger

    def main(args) do
       args
       |> parse_args 
    end

    defp do_help() do
        IO.puts """
        Usage:
        .ffmpeg_proc <input videos directory> <output music directory>

        Also,
        Please use legally obtained videos. 

        """
    end

    defp parse_args(args) do
        if length(args) < 2 do
            do_help()
        else
            SUPERVISOR.go(Enum.at(args, 0), Enum.at(args, 1))
        end
    end
end