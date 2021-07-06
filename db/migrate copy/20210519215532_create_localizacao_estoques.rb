class CreateLocalizacaoEstoques < ActiveRecord::Migration[5.2]
  def change
    create_table :localizacao_estoques do |t|
      t.string :local
      t.string :observacao

      t.timestamps
    end
  end
end
