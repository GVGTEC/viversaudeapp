class AddConsumidorFinalToCliente < ActiveRecord::Migration[5.2]
  def change
    add_column :clientes, :consumidor_final, :string
  end
end
