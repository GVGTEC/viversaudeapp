class AddContasReceberToNotaFiscais < ActiveRecord::Migration[5.2]
  def change
    add_column :nota_fiscais, :contas_rec_id, :interger
    t.references :contas_rec, foreign_key: true
  end
end

#Primeiro fiz este comando
#rails generate migration AddContasReceberToNotaFiscais contas_rec:references

#Segundo fiz este comando
#rails g migration AddContasReceberToNotaFiscais contas_rec_id:interger