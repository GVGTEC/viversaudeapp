class AddEmpresaToMovimentoEstoque < ActiveRecord::Migration[5.2]
  def change
    add_reference :movimento_estoques, :empresa, foreign_key: true
  end
end
