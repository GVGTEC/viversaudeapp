class AddObservacoesToFornecedor < ActiveRecord::Migration[5.2]
  def change
    add_column :fornecedores, :observacoes, :text
  end
end
