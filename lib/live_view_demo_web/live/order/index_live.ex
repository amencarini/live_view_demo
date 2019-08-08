defmodule LiveViewDemoWeb.Order.IndexLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(LiveViewDemoWeb.OrderView, "index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end
end
