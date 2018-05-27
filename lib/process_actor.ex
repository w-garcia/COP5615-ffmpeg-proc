defmodule Processor do
    use GenServer

    def start_link({indir, outdir}) do
        GenServer.start_link(__MODULE__, {indir, outdir})
    end

    def init({indir, outdir}) do
        {:ok, {indir, outdir}}
    end

    def do_vid(me, file) do
        GenServer.cast(me, {:do_vid, file})
    end

    def handle_cast({:do_vid, file}, currentstate) do
        {indir, outdir} = currentstate
        base = Util.get_base(file)

        if !File.dir?(outdir) do
            _res = File.mkdir(outdir)
        end
        
        in_path = Path.join([indir, file])

        outfile = Enum.join([base, ".mp3"])
        out_path = Path.join([outdir, outfile])

        args = ["-y", "-i", in_path, "-b:a", "320K", "-vn", out_path]
        ffmpeg_bin = Application.get_env(:ffmpeg_proc, :bin_path)
        # IO.inspect(args)
        {logtext, status} = System.cmd(ffmpeg_bin, args, [stderr_to_stdout: true])

        if status != 0 do
            logfile = Enum.join([base, ".txt"])    
            logpath = Path.join([outdir, logfile])
            File.write(logpath, logtext)
            IO.puts(["There was an error. Check ", logpath, " for details."])
        else
            IO.puts(["Done. Wrote to ", out_path]) 
        end
        
        {:noreply, currentstate}
    end
    
end