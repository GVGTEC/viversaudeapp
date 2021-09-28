class CreateOrcamentoItens < ActiveRecord::Migration[5.2]
  def change
    create_table :orcamento_itens do |t|
      t.references :orcamento, foreign_key: true
      t.references :produto, foreign_key: true
      t.float :quantidade
      t.float :preco_unitario
      t.float :preco_total

      t.timestamps
    end
  end
end
