class NotaFiscal < ApplicationRecord  
  belongs_to :cfop
  belongs_to :cliente, optional: true
  belongs_to :fornecedor, optional: true
  belongs_to :vendedor, optional: true
  belongs_to :transportadora
  belongs_to :empresa

  has_one :nota_fiscal_transporta, dependent: :destroy
  has_one :imposto, class_name: :NotaFiscalImposto, dependent: :destroy
  has_many :nota_fiscal_itens, dependent: :delete_all
  has_many :nota_fiscal_faturamento_parcelas, dependent: :delete_all
  has_many :movimento_estoques, dependent: :delete_all

  def calculo_valor_total_nota
    valor_produtos + valor_frete + valor_outras_despesas - valor_desconto 
  end

  def calculo_imposto_nota
    imposto = self.imposto
    imposto ||= NotaFiscalImposto.new

    imposto.nota_fiscal_id = id
    imposto.valor_bc_icms = nota_fiscal_itens.sum(:valor_bc_icms)
    imposto.valor_icms = nota_fiscal_itens.sum(:valor_icms)
    imposto.valor_bc_icms_st = nota_fiscal_itens.sum(:valor_bc_icms_st)
    imposto.valor_icms_st = nota_fiscal_itens.sum(:valor_icms_st)
    imposto.valor_pis = nota_fiscal_itens.sum(:valor_pis)
    imposto.valor_cofins = nota_fiscal_itens.sum(:valor_cofins)
    imposto.valor_ipi = nota_fiscal_itens.sum(:valor_ipi)
    imposto.valor_difal = nota_fiscal_itens.sum(:valor_difal)
    imposto.valor_fcp = nota_fiscal_itens.sum(:valor_fcp)
    imposto.save
  end

  def salvar_movimento_estoque(movimentos)
    nota_fiscal_itens = self.nota_fiscal_itens
    produto_ids = nota_fiscal_itens.map(&:produto_id)

    MovimentoEstoque.where(nota_fiscal_id: id).destroy_all
    movimentos.each do |movimento|
      next unless produto_ids.include?(movimento['produto_id'].to_i)

      movimento_estoque = MovimentoEstoque.new(
        nota_fiscal_id: id,
        produto_id: movimento['produto_id'],
        estoque_id: movimento['estoque_id'],
        origem: movimento['origem'],
        data: movimento['data'].to_date,
        qtd: movimento['qtd'],
        estoque_inicial: movimento['estoque_inicial'],
        estoque_final: movimento['estoque_final'],
        preco_custo: Produto.find(movimento['produto_id']).preco_custo,
        empresa_id: empresa.id
      )
      
      next unless movimento_estoque.save

      estoque = Estoque.find(movimento['estoque_id'])
      estoque_atual_lote = estoque.estoque_atual_lote
      estoque.estoque_atual_lote = estoque_atual_lote - movimento['qtd'].to_f
      estoque.ultima_alteracao = Estoque::VENDA 
      estoque.save

      estoque.atualizar_produto_baixas({ qtd_baixa: movimento['qtd'].to_f })
    end
  end

  def salvar_nota_fiscal_item_lotes(movimentos)
    nota_fiscal_itens = self.nota_fiscal_itens
    nota_fiscal_iten_ids = nota_fiscal_itens.map(&:id)
    NotaFiscalItemLote.where(nota_fiscal_item_id: nota_fiscal_iten_ids).destroy_all
    
    movimentos.each do |movimento|
      nota_fiscal_item = nota_fiscal_itens.find_by(produto_id: movimento['produto_id'])
      next if nota_fiscal_item.blank?

      nota_fiscal_item_lote = NotaFiscalItemLote.new(
        nota_fiscal_item_id: nota_fiscal_item.id,
        estoque_id: movimento['estoque_id'],
        estoque_inicial: movimento['estoque_inicial'],
        qtd: movimento['qtd'],
        estoque_final: movimento['estoque_final']
      )
      
      nota_fiscal_item_lote.save
    end
  end

  def apagar_dados
    nota_fiscal_transporta.destroy
    imposto.destroy
    nota_fiscal_itens.map{|nfi| nfi.nota_fiscal_item_lotes.delete_all}

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
