class CreateNotaFiscalImpostos < ActiveRecord::Migration[5.2]
  def change
    create_table :nota_fiscal_impostos do |t|
      t.references :nota_fiscal, foreign_key: true
      t.float :valor_bc_icms
      t.float :valor_icms
      t.float :valor_bc_icms_st
      t.float :valor_icms_st
      t.float :valor_pis
      t.float :valor_cofins
      t.float :valor_ipi
      t.float :valor_difal
      t.float :valor_fcp

      t.timestamps
    end
  end
end
