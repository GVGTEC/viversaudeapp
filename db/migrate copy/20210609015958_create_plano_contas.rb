class CreatePlanoContas < ActiveRecord::Migration[5.2]
  def change
    create_table :plano_contas do |t|
      t.references :empresa, foreign_key: true
      t.string :conta
      t.string :descricao
      t.string :grau

      t.timestamps
    end
  end
end
