class AddOrigemToClientes < ActiveRecord::Migration[5.2]
  def change
    add_column :clientes, :empresa_governo, :string
  end
end
