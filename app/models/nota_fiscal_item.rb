class NotaFiscalItem < ApplicationRecord
  belongs_to :nota_fiscal
  belongs_to :produto

  has_many :nota_fiscal_item_lotes, dependent: :delete_all

  def calculo_imposto_item(adm)
    cf = self.nota_fiscal.cfop.cliente_fornecedor_cf

    uf = if cf == 'C'
      self.nota_fiscal.cliente.uf
    else
      self.nota_fiscal.fornecedor.uf
    end

    self.aliquota_icms = Icms.find_by(estado: uf).aliquota_icms
    self.valor_bc_icms = self.preco_total
    self.valor_icms = self.preco_total * self.aliquota_icms / 100

    self.aliquota_icms_st = 0
    self.valor_bc_icms_st = 0
    self.valor_icms_st = 0

    self.aliquota_ipi = 0
    self.valor_ipi = 0

    self.aliquota_pis = adm.empresa.aliquota_pis
    self.valor_pis = self.preco_total * self.aliquota_pis / 100

    self.aliquota_cofins = adm.empresa.aliquota_cofins
    self.valor_cofins = self.preco_total * self.aliquota_cofins / 100

    self.aliquota_difal = 0
    self.valor_difal = 0

    self.valor_fcp = 0
    self.aliquota_fcp = 0
    self.save
  end

  def verifica_cst
    st = self.produto.situacao_tributaria

    case st
    when 'T'
      '00' # Tributada integralmente
    when 'I'
      '40' # Isenta
    when 'S'
      '60' # ICMS cobrado anteriormente por substituição tributária
    else
      '41' # Não tributada
    end

    # " 00 - Tributada integralmente
    #   10 - Tributada e com cobrança do ICMS por substituição tributária
    #   20 - Com redução da BC
    #   30 - Isenta / não tributada e com cobrança do ICMS por substituição tributária
    #   40 - Isenta
    #   41 - Não tributada
    #   50 - Com suspensão
    #   51 - Com diferimento
    #   60 - ICMS cobrado anteriormente por substituição tributária
    #   70 - Com redução da BC e cobrança do ICMS por substituição tributária
    #   90 - Outras
    # "
  end

  def verifica_cson
    " 101 - Tributada pelo Simples Nacional com permissão de crédito
      102 - Tributada pelo Simples Nacional sem permissão de crédito
      103 - Isenção do ICMS no Simples Nacional para faixa de receita bruta
      201 - Tributada pelo Simples Nacional com permissão de crédito e com cobrança do ICMS
    por substituição tributária
      202 - Tributada pelo Simples Nacional sem permissão de crédito e com cobrança do ICMS
    por substituição tributária
      203 - Isenção do ICMS no Simples Nacional para faixa de receita bruta e com cobrança do
    ICMS por substituição tributária
      300 - Imune
      400 - Não tributada pelo Simples Nacional
      500 - ICMS cobrado anteriormente por substituição tributária (substituído) ou por
    antecipação
      900 - Outros
    "
  end
end
