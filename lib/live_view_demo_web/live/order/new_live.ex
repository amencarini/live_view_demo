defmodule LiveViewDemoWeb.Order.NewLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(LiveViewDemoWeb.OrderView, "new.html", assigns)
  end
end
