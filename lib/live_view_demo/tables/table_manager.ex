defmodule LiveViewDemo.Tables.TableManager do
  use GenServer

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def get_tables, do: GenServer.call(__MODULE__, :get_tables)

  def get_table(number), do: GenServer.call(__MODULE__, {:get_table, number})

  def set_table(number, table), do: GenServer.cast(__MODULE__, {:set_table, number, table})

  @impl true
  @spec init(integer) :: {:ok, %{integer => LiveViewDemo.Tables.Table.t()}}
  def init(tables_quantity) do
    table_map =
      for n <- 1..tables_quantity, into: %{} do
        table = LiveViewDemo.Tables.Table.new(n)
        {to_string(n), table}
      end

    {:ok, table_map}
  end

  @impl true
  def handle_call({:get_table, number}, _from, table_map) do
    {:reply, Map.get(table_map, number), table_map}
  end

  @impl true
  def handle_call(:get_tables, _from, table_map) do
    tables = Enum.map(table_map, fn {_n, t} -> t end)

    {:reply, tables, table_map}
  end

  @impl true
  def handle_cast({:set_table, number, table}, table_map) do
    {:noreply, %{table_map | number => table}}
  end
end
