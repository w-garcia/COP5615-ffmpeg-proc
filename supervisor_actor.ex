defmodule SUPERVISOR do
    use Supervisor


    def start_link do
        Supervisor.start_link(__MODULE__, :ok)
    end

    def init(:ok) do
        children = []
        Supervisor.init(children, strategy: :one_for_one)
    end

    def go(args) do
        Node.set_cookie :nozomi

        SUPERVISOR.launch_as_master()
    end
end