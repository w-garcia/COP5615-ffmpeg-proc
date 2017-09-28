defmodule Folder_Watch do
    use GenServer

    def start_link(parent, inpath, outpath) do
        {err, me} = GenServer.start_link(__MODULE__, {parent, inpath, outpath})
        GenServer.cast(me, :start_watch)
        {err, me}
    end

    def init({parent, inpath, outpath}) do
        {:ok, {parent, inpath, outpath}}
    end

    def handle_cast(:start_watch, currentstate) do
        {parent, inpath, outpath} = currentstate
        start_watching_dir(inpath, outpath, parent, %{})
        {:noreply, currentstate}
    end

    def start_watching_dir(inpath, outpath, parent, vid_map) do
        {dir_str, _} = System.cmd("ls", [inpath])
        files = String.split(dir_str, "\n")
        {_, files} = List.pop_at(files, length(files) - 1) # Take out last empty item

        {vid_map, found_work} = perform_diff(files, vid_map, [])
        if length(found_work) > 0 do
            IO.puts(["Found new files in ", inpath])
            GenServer.cast(parent, {:update_work, found_work})            
        end

        :timer.sleep(Enum.random(500..3000))
        start_watching_dir(inpath, outpath, parent, vid_map)
    end

    def perform_diff(files, vid_map, found_work) do
        # End of recursion
        if length(files) == 0 do
            {vid_map, found_work}
        else
            {file, files} = Util.pop(files)
            
            res = Map.get(vid_map, file)
            case res do
                nil ->
                    # Not found in map, update
                    vid_map = Map.put(vid_map, file, 1)
                    found_work = [file] ++ found_work
                    perform_diff(files, vid_map, found_work)
                _ ->
                    # Found, pass
                    perform_diff(files, vid_map, found_work)                
            end

        end
    end
end