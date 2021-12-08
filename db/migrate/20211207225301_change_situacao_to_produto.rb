class ChangeSituacaoToProduto < ActiveRecord::Migration[5.2]
  def change
    change_column :produtos, :situacao, :string
  end
end
