class AddOrigemToProdutos < ActiveRecord::Migration[5.2]
  def change
    add_column :produtos, :origem, :string
  end
end
