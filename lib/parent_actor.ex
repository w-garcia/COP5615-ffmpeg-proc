defmodule Parent do
    use GenServer

    def start_link(workers) do
        GenServer.start_link(__MODULE__, workers)
    end

    def init(workers) do
        {:ok, workers}
    end

    def update_work_todo(me, new_work) do
        GenServer.cast(me, {:update_work, new_work})
    end

    def read(me) do
        GenServer.call(me, {:read})
    end
    
    def delegate_work(work, workers, count) do
        if length(work) != 0 do
            count = rem(count, length(workers))
            {task, new_work} = Util.pop(work)
    
            worker_rr = Enum.at(workers, count)
            Processor.do_vid(worker_rr, task)
    
            delegate_work(new_work, workers, count + 1)
        end
    end

    def handle_cast({:update_work, new_work}, currentstate) do
        delegate_work(new_work, currentstate, 0)
        {:noreply, currentstate}
    end

    def handle_call({:read}, _frompid, currentstate) do
        IO.inspect(currentstate)
        {:reply, currentstate}
    end
end