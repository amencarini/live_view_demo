defmodule LiveViewDemo.Orders.LineItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "line_items" do
    field :price, :decimal
    field :quantity, :integer
    belongs_to :product, LiveViewDemo.Orders.Product
    belongs_to :order, LiveViewDemo.Orders.Order

    timestamps()
  end

  @doc false
  def changeset(line_item, attrs) do
    line_item
    |> cast(attrs, [:price, :quantity])
    |> validate_required([:price, :quantity])
  end
end
