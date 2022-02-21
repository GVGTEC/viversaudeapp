class CreateNotaFiscalItens < ActiveRecord::Migration[5.2]
  def change
    create_table :nota_fiscal_itens do |t|
      t.references :nota_fiscal, foreign_key: true
      t.references :produto, foreign_key: true
      t.text :descricao
      t.string :cfop
      # t.string :st
      t.string :ncm
      t.string :cst
      t.string :unidade
      t.float :quantidade
      t.float :preco_unitario
      t.float :preco_total
      t.float :aliquota_icms
      t.float :valor_bc_icms
      t.float :valor_icms
      t.float :aliquota_icms_st
      t.float :valor_bc_icms_st
      t.float :valor_icms_st
      t.float :aliquota_ipi
      t.float :valor_ipi
      t.float :aliquota_pis
      t.float :valor_pis
      t.float :aliquota_cofins
      t.float :valor_cofins
      t.float :aliquota_difal
      t.float :valor_difal
      t.float :valor_fcp
      t.float :aliquota_fcp
      t.string :local_estoque
      t.boolean :baixou_estoque
      t.string :pagar_comissao_sn
      t.float :comissao_ven_pc
      t.float :comissao_ven_vr
      t.float :comissao_ter_pc
      t.float :comissao_ter_vr

      t.timestamps
    end
  end
end
