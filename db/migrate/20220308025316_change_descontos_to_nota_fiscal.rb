class ChangeDescontosToNotaFiscal < ActiveRecord::Migration[5.2]
  def change
    change_column :nota_fiscais, :valor_desconto, :float, default: 0
    change_column :nota_fiscais, :valor_frete, :float, default: 0
    change_column :nota_fiscais, :valor_outras_despesas, :float, default: 0
  end
end
