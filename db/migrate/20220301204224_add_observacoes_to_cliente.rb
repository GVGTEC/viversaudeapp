class AddObservacoesToCliente < ActiveRecord::Migration[5.2]
  def change
    add_column :clientes, :observacoes, :text
  end
end
