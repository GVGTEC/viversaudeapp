class NotaFiscalItem < ApplicationRecord
  belongs_to :nota_fiscal
  belongs_to :produto

  has_many :nota_fiscal_item_lotes, dependent: :delete_all

  after_create :calculo_imposto_item, :verifica_cst, :verifica_cfop
  before_destroy :reverter_baixa_estoque

  def calculo_imposto_item
    return if produto.situacao_tributaria != 'T'

    cf = nota_fiscal.cfop.cliente_fornecedor_cf
    uf = 
      if cf == 'C'
        return if nota_fiscal.cliente.empresa_governo

        nota_fiscal.cliente.uf
      else
        nota_fiscal.fornecedor.uf
      end

    self.aliquota_icms = Icms.find_by(estado: uf).aliquota_icms
    self.valor_bc_icms = preco_total
    self.valor_icms = preco_total * aliquota_icms / 100

    self.aliquota_pis = nota_fiscal.empresa.aliquota_pis
    self.valor_pis = preco_total * aliquota_pis / 100

    self.aliquota_cofins = nota_fiscal.empresa.aliquota_cofins
    self.valor_cofins = preco_total * aliquota_cofins / 100
    save
  end

  def verifica_cst
    cf = nota_fiscal.cfop.cliente_fornecedor_cf

    if cf == 'C' && nota_fiscal.cliente.empresa_governo
      self.cst = '41'
      save
      return
    end

    situacao_tributaria = produto.situacao_tributaria
    self.cst = 
      case situacao_tributaria
      when 'T'
        '00' # Tributada integralmente
      when 'I'
        '40' # Isenta
      when 'S'
        '60' # ICMS cobrado anteriormente por substituição tributária
      else
        '41' # Não tributada
      end

    save
  end

  def informacoes_lote
    lotes = []
    nota_fiscal_item_lotes.each do |item_lote|
      lote = ""
      lote << "Lote: #{item_lote.estoque.lote} "
      lote << "Qtd: #{item_lote.qtd} "
      lote << "Val: #{item_lote.estoque.data_validade} "
      lote << "Local: #{produto.localizacao_estoque.local rescue ''}"

      lotes.push(lote)
    end

    lotes.join(" - ")
  end

  def verifica_cfop
    situacao_tributaria = produto.situacao_tributaria
    return if situacao_tributaria != 'S'

    informativo = nota_fiscal.cfop.informativo
    self.cfop = 
      if informativo.include?('de')
        Cfop.find_by(informativo: 'cfop_st_de').codigo
      else
        Cfop.find_by(informativo: 'cfop_fe_st').codigo
      end
      
    save
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

  def reverter_baixa_estoque
    movimento_estoques = nota_fiscal.movimento_estoques
    movimento_estoques.each do |movimento|
      produto = movimento.produto
      produto.estoque_atual += movimento.qtd
      produto.save

      estoque = movimento.estoque
      estoque.estoque_atual_lote += movimento.qtd
      estoque.save

      movimento.destroy
    end
  end
end
