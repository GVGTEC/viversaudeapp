class NotaFiscal < ApplicationRecord
  validates :transportadora_id, presence: true

  belongs_to :cfop, optional: true
  belongs_to :cliente, optional: true
  belongs_to :fornecedor, optional: true
  belongs_to :vendedor, optional: true
  belongs_to :transportadora, optional: true
  belongs_to :empresa

  before_validation :salvar_empresa

  has_one :nota_fiscal_transporta, dependent: :destroy
  has_one :nota_fiscal_imposto, dependent: :destroy
  has_many :nota_fiscal_itens, dependent: :delete_all
  has_many :nota_fiscal_faturamento_parcelas, dependent: :delete_all

  def calculo_valor_total_nota
    # preco_total - @nota_fiscal.valor_desconto + @nota_fiscal.valor_frete + @nota_fiscal.valor_outras_despesas
    self.valor_produtos
  end

  def calculo_imposto_nota
    nota_fiscal_imposto = self.nota_fiscal_imposto
    nota_fiscal_imposto ||= NotaFiscalImposto.new

    nota_fiscal_imposto.nota_fiscal_id = self.id
    nota_fiscal_imposto.valor_bc_icms = self.nota_fiscal_itens.sum(:valor_bc_icms)
    nota_fiscal_imposto.valor_icms = self.nota_fiscal_itens.sum(:valor_icms)
    nota_fiscal_imposto.valor_bc_icms_st = self.nota_fiscal_itens.sum(:valor_bc_icms_st)
    nota_fiscal_imposto.valor_icms_st = self.nota_fiscal_itens.sum(:valor_icms_st)
    nota_fiscal_imposto.valor_pis = self.nota_fiscal_itens.sum(:valor_pis)
    nota_fiscal_imposto.valor_cofins = self.nota_fiscal_itens.sum(:valor_cofins)
    nota_fiscal_imposto.valor_ipi = self.nota_fiscal_itens.sum(:valor_ipi)
    nota_fiscal_imposto.valor_difal = self.nota_fiscal_itens.sum(:valor_difal)
    nota_fiscal_imposto.valor_fcp = self.nota_fiscal_itens.sum(:valor_fcp)
    nota_fiscal_imposto.save
  end
end
