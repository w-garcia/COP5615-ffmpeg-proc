defmodule Folder_Watch do
    use GenServer

    def start_link(vid_names) do
        GenServer.start_link(__MODULE__, vid_names)
    end

    def init(vid_names) do
        {:ok, vid_names}
    end

    def pop(list) do
        List.pop_at(list, 0)
    end

    def get_work(pid) do
        GenServer.call(pid, {:get_work})
    end

    def handle_call({:get_work}, _frompid, currentstate) do
        if length(currentstate) == 0 do
            {:reply, nil, currentstate}
        end
        
        {new_work, new_lsit} = pop(currentstate)

        {:reply, new_work, new_list}
    end
end