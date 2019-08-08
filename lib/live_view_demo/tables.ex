defmodule LiveViewDemo.Tables do
  # alias LiveViewDemo.Tables.Table

  @spec list :: [LiveViewDemo.Tables.Table.t()]
  def list do
    LiveViewDemo.Tables.TableManager.get_tables()
  end

  def get(number) do
    LiveViewDemo.Tables.TableManager.get_table(number)
  end

  def set_table_status(number, status) do
    table = %{get(number) | status: status}
    LiveViewDemo.Tables.TableManager.set_table(number, table)
  end

  def set_table_order(number, order_id) do
    table = %{get(number) | order_id: order_id}
    LiveViewDemo.Tables.TableManager.set_table(number, table)
  end
end
