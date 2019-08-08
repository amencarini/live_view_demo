defmodule LiveViewDemoWeb.TableLive do
  use Phoenix.LiveView

  alias LiveViewDemoWeb.Router.Helpers, as: Routes

  def render(assigns) do
    Phoenix.View.render(LiveViewDemoWeb.TableView, "index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, selected_table: nil) |> refresh_list()}
  end

  def handle_params(%{"table_number" => table_number}, _uri, socket) do
    {:noreply, socket |> assign(:selected_table, LiveViewDemo.Tables.get(table_number))}
  end

  def handle_params(_params, _uri, socket), do: {:noreply, socket}

  def handle_event("occupy-table", _value, socket) do
    table = socket.assigns[:selected_table]
    table = set_table_status(table, :busy)

    {:ok, order} = LiveViewDemo.Orders.create_order()

    set_table_order(table, order.id)

    {:noreply, live_redirect(socket,
      to: Routes.live_path(socket, LiveViewDemoWeb.Order.ShowLive, order.id))
    }
  end

  def handle_event("free-table", _value, socket) do
    selected_table = set_table_status(socket.assigns[:selected_table], :free)
    {:noreply, assign(socket, :selected_table, selected_table) |> refresh_list()}
  end

  defp set_table_status(table, status) do
    LiveViewDemo.Tables.set_table_status(to_string(table.number), status)
    %{table | status: status}
  end

  defp set_table_order(table, order_id) do
    LiveViewDemo.Tables.set_table_order(to_string(table.number), order_id)
    %{table | order_id: order_id}
  end

  defp refresh_list(socket) do
    assign(socket, tables: LiveViewDemo.Tables.list())
  end
end
