class CreatePlanoContas < ActiveRecord::Migration[5.2]
  def change
    create_table :plano_contas do |t|
      t.string :conta
      t.string :descricao
      t.string :grau

      t.timestamps
    end
  end
end
