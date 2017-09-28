defmodule Util do
    def get_nproc() do
        {nproc_raw, _} = System.cmd("nproc", [])
        num_cores = String.trim(nproc_raw)
        String.to_integer(num_cores)
    end

    def pop(list) do
        List.pop_at(list, 0)
    end

    def get_extension(str) when str != nil do
        [_ | ext ] = String.split(str, ".")
        ext
    end

    def get_base(str) when str != nil do 
        splits = String.split(str, ".")
        {_, splits} = List.pop_at(splits, length(splits) - 1)
        Enum.join(splits, "")
    end
end