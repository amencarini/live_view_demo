defmodule LiveViewDemoWeb.Order.ShowLive do
  use Phoenix.LiveView

  alias LiveViewDemo.Orders

  def mount(%{path_params: %{"order_id" => order_id}}, socket) do
    order = Orders.get_order!(order_id)

    {:ok, assign(socket, order: order)}
  end

  def render(assigns) do
    IO.puts("show render")
    IO.inspect(assigns)

    Phoenix.View.render(LiveViewDemoWeb.OrderView, "show.html", assigns)
  end
end
