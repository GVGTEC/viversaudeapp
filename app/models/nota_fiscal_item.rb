class NotaFiscalItem < ApplicationRecord
  belongs_to :nota_fiscal
  belongs_to :produto

  has_many :nota_fiscal_item_lotes, dependent: :delete_all

  def calculo_imposto_item(adm)
    cf = nota_fiscal.cfop.cliente_fornecedor_cf

    uf = 
      if cf == 'C'
        nota_fiscal.cliente.uf
      else
        nota_fiscal.fornecedor.uf
      end

    self.aliquota_icms = Icms.find_by(estado: uf).aliquota_icms
    self.valor_bc_icms = preco_total
    self.valor_icms = preco_total * aliquota_icms / 100

    self.aliquota_pis = adm.empresa.aliquota_pis
    self.valor_pis = preco_total * aliquota_pis / 100

    self.aliquota_cofins = adm.empresa.aliquota_cofins
    self.valor_cofins = preco_total * aliquota_cofins / 100
    save
  end

  def verifica_cst
    st = produto.situacao_tributaria

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
