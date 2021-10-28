class AddNotaFiscalToMovimentoEstoque < ActiveRecord::Migration[5.2]
  def change
    add_column :movimento_estoques, :nota_fiscal_id, :bigint
  end
end
