defmodule LiveViewDemo.Orders.LineItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "line_items" do
    field :price, :decimal
    field :quantity, :integer
    field :product_id, :binary_id
    field :order_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(line_item, attrs) do
    line_item
    |> cast(attrs, [:price])
    |> validate_required([:price])
  end
end
