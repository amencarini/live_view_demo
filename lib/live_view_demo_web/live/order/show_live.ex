defmodule LiveViewDemoWeb.Order.ShowLive do
  use Phoenix.LiveView

  alias LiveViewDemo.Orders

  def mount(%{path_params: %{"order_id" => order_id}}, socket) do
    {:ok, assign(socket, order: refresh_order(order_id), products: products())}
  end

  def render(assigns) do
    Phoenix.View.render(LiveViewDemoWeb.OrderView, "show.html", assigns)
  end

  def handle_event("add_product", product_id, socket) do
    order = socket.assigns[:order]
    Orders.add_list_item_to_order(order, product_id)

    {:noreply, assign(socket, order: refresh_order(order.id))}
  end

  def handle_event("increment", line_item_id, socket) do
    order = socket.assigns[:order]
    Orders.increment_line_item_quantity(line_item_id)

    {:noreply, assign(socket, order: refresh_order(order.id))}
  end

  def handle_event("decrement", line_item_id, socket) do
    order = socket.assigns[:order]
    Orders.decrement_line_item_quantity(line_item_id)

    {:noreply, assign(socket, order: refresh_order(order.id))}
  end

  defp refresh_order(order_id) do
    Orders.get_order_with_line_items_and_products!(order_id)
  end

  defp products do
    Orders.list_products()
  end
end
