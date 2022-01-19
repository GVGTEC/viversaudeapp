class AddSubTotalToOrcamento < ActiveRecord::Migration[5.2]
  def change
    add_column :orcamentos, :valor_sub_total, :float
    add_column :orcamentos, :valor_desconto, :float
  end
end
