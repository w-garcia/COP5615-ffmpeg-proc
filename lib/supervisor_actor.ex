defmodule SUPERVISOR do
    use Supervisor


    def start_link do
        Supervisor.start_link(__MODULE__, :ok)
    end

    def init(:ok) do
        children = []
        Supervisor.init(children, strategy: :one_for_one)
    end

    def go(indir, outdir) do
        {_sup_err, sup_pid} = SUPERVISOR.start_link

        n_workers = Util.get_nproc()
        
        workers = for i <- 1..n_workers, {_err, pid} = Supervisor.start_child(
            sup_pid, worker(Processor, [{indir, outdir}], [id: Integer.to_string(i)])
            ), do: pid

        parent_spec = worker(Parent, [workers], [id: "Parent"])
        {_p_err, parent_pid} = Supervisor.start_child(sup_pid, parent_spec)

        fw_spec = worker(Folder_Watch, [parent_pid, indir, outdir], [id: "FW"])
        {_fwatch_err, _fw_pid} = Supervisor.start_child(sup_pid, fw_spec)

        input_spec = worker(Input, [], [id: "Inputter"])
        {_err_in, input_pid} = Supervisor.start_child(sup_pid, input_spec)
        Input.start_watching(input_pid)
    end
end