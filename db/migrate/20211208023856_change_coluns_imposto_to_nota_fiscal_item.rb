class ChangeColunsImpostoToNotaFiscalItem < ActiveRecord::Migration[5.2]
  def change
    change_column :nota_fiscal_itens, :aliquota_icms, :float, default: 0
    change_column :nota_fiscal_itens, :valor_bc_icms, :float, default: 0
    change_column :nota_fiscal_itens, :valor_icms, :float, default: 0
    change_column :nota_fiscal_itens, :aliquota_icms_st, :float, default: 0
    change_column :nota_fiscal_itens, :valor_bc_icms_st, :float, default: 0
    change_column :nota_fiscal_itens, :valor_icms_st, :float, default: 0
    change_column :nota_fiscal_itens, :aliquota_ipi, :float, default: 0
    change_column :nota_fiscal_itens, :valor_ipi, :float, default: 0
    change_column :nota_fiscal_itens, :aliquota_pis, :float, default: 0
    change_column :nota_fiscal_itens, :valor_pis, :float, default: 0
    change_column :nota_fiscal_itens, :aliquota_cofins, :float, default: 0
    change_column :nota_fiscal_itens, :valor_cofins, :float, default: 0
    change_column :nota_fiscal_itens, :aliquota_difal, :float, default: 0
    change_column :nota_fiscal_itens, :valor_difal, :float, default: 0
    change_column :nota_fiscal_itens, :valor_fcp, :float, default: 0
    change_column :nota_fiscal_itens, :aliquota_fcp, :float, default: 0
  end
end
