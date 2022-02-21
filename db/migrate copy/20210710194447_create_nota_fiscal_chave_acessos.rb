class CreateNotaFiscalChaveAcessos < ActiveRecord::Migration[5.2]
  def change
    create_table :nota_fiscal_chave_acessos do |t|
      t.references :nota_fiscal, foreign_key: true
      t.string :chave_acesso

      t.timestamps
    end
  end
end
