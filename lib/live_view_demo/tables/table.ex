defmodule LiveViewDemo.Tables.Table do
  defstruct [:number, :status, :bill, :order_id]

  @spec new(integer) :: LiveViewDemo.Tables.Table.t()
  def new(number) do
    bill_amount = :rand.uniform(20) + 10
    %__MODULE__{number: number, status: :free, bill: "GBP #{bill_amount}"}
  end
end
