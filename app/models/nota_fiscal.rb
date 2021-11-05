class NotaFiscal < ApplicationRecord  
  belongs_to :cfop
  belongs_to :cliente, optional: true
  belongs_to :fornecedor, optional: true
  belongs_to :vendedor, optional: true
  belongs_to :transportadora
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

  def salvar_movimento_estoque(movimentos)
    nota_fiscal_itens = self.nota_fiscal_itens
    produto_ids = nota_fiscal_itens.map{|nfi| nfi.produto_id }

    MovimentoEstoque.where(nota_fiscal_id: self.id).destroy_all
    movimentos.each do |movimento|
      movimento = JSON.parse(movimento)
      if produto_ids.include?(movimento["produto_id"])
        movimento_estoque = MovimentoEstoque.new
        movimento_estoque.produto_id = movimento["produto_id"]
        movimento_estoque.estoque_id = movimento["estoque_id"]
        movimento_estoque.nota_fiscal_id = self.id
        movimento_estoque.origem = movimento["origem"]
        movimento_estoque.data = movimento["data"].to_date
        movimento_estoque.qtd = movimento["qtd"]
        movimento_estoque.estoque_inicial = movimento["estoque_inicial"]
        movimento_estoque.estoque_final = movimento["estoque_final"]
        movimento_estoque.preco_custo = Produto.find(movimento["produto_id"]).preco_custo
        movimento_estoque.save
      end
    end
  end

  def salvar_nota_fiscal_item_lotes(movimentos)
    nota_fiscal_itens = self.nota_fiscal_itens
    nota_fiscal_iten_ids = nota_fiscal_itens.map{|nfi| nfi.id }
    NotaFiscalItemLote.where(nota_fiscal_item_id: nota_fiscal_iten_ids).destroy_all
    
    movimentos.each do |movimento|
      movimento = JSON.parse(movimento)
      nota_fiscal_item_lote = NotaFiscalItemLote.new
      nota_fiscal_item_lote.nota_fiscal_item_id = nota_fiscal_itens.find_by(produto_id: movimento["produto_id"]).id
      nota_fiscal_item_lote.lote = Estoque.find(movimento["estoque_id"]).lote.strip()
      nota_fiscal_item_lote.estoque_inicial = movimento["estoque_inicial"]
      nota_fiscal_item_lote.qtd = movimento["qtd"]
      nota_fiscal_item_lote.estoque_final = movimento["estoque_final"]
      nota_fiscal_item_lote.save
    end
  end
end
