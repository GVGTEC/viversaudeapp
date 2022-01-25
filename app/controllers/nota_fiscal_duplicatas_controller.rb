class NotaFiscalDuplicatasController < ApplicationController
  before_action :set_nota_fiscal
  skip_before_action :verify_authenticity_token, only: [:create]

  def new; end

  def create
    @nota_fiscal.valor_total_nota = params[:nota_fiscal][:valor_total_nota]
    @nota_fiscal.meio_pagamento = params[:nota_fiscal][:meio_pagamento]
    @nota_fiscal.tipo_pagamento = params[:nota_fiscal][:tipo_pagamento]
    @nota_fiscal.numero_parcelas_pagamento = params[:nota_fiscal][:numero_parcelas_pagamento]
    @nota_fiscal.distancia_parcelas = params[:nota_fiscal][:distancia_parcelas]
    @nota_fiscal.save

    salvar_vencimento_parcelas
    salvar_contas_receber

    flash[:notice] = 'Nota Fiscal Duplicata Cadastrada' 
    redirect_to observacoes_nota_fiscal_path(@nota_fiscal)  
  end

  private

  def salvar_vencimento_parcelas
    if params[:nota_fiscal].key?(:nota_fiscal_faturamento_parcelas)
      NotaFiscalFaturamentoParcela.where(nota_fiscal: @nota_fiscal.id).destroy_all
      params[:nota_fiscal][:nota_fiscal_faturamento_parcelas].each_with_index do |faturamento_parcela, i|
        @nota_fiscal_faturamento_parcela = NotaFiscalFaturamentoParcela.new(
          nota_fiscal: @nota_fiscal,
          duplicata: formatar_numero_duplicata(i + 1),
          prazo_pagamento: faturamento_parcela[:prazo_pagamento],
          data_vencimento: faturamento_parcela[:data_vencimento],
          valor_parcela: faturamento_parcela[:valor_parcela].tr('.', '').tr(',', '.').to_f
        )
        
        @nota_fiscal_faturamento_parcela.save
      end
    end
  end

  def salvar_contas_receber
    contas_receber = ContasRec.find_by(documento: @nota_fiscal.numero_nota)
    contas_receber ||= ContasRec.new

    contas_receber.empresa_id = administrador.empresa_id
    contas_receber.cliente_id = @nota_fiscal.cliente_id
    contas_receber.documento = @nota_fiscal.numero_nota
    contas_receber.data_emissao = @nota_fiscal.data_emissao
    contas_receber.valor_total = @nota_fiscal.valor_total_nota
    contas_receber.save

    if params[:nota_fiscal].key?(:nota_fiscal_faturamento_parcelas)
      @parcelas = ContasRecParcela.where(contas_rec: contas_receber.id).destroy_all
      params[:nota_fiscal][:nota_fiscal_faturamento_parcelas].each_with_index do |parcela, i|
        @contas_rec_parcela = ContasRecParcela.new( 
          contas_rec_id: contas_receber.id,
          data_vencimento: parcela[:data_vencimento],
          documento: "TESTE",
          valor_parcela: formatar_valor_parcela(parcela[:valor_parcela])          
        )
        
        @contas_rec_parcela.save
      end
    end
  end

  def formatar_numero_duplicata(numero)
    format '%03d', numero
  end

  def formatar_valor_parcela(numero)
    numero.tr('.', '').tr(',', '.').to_f 
  end

  # Only allow a list of trusted parameters through.
  def nota_fiscal_params
    params.require(:nota_fiscal).permit(:numero_nota, :numero_pedido, :cfop_id, :entsai, :cliente_id, :fornecedor_id, :vendedor_id, :data_emissao, :data_saida, :hora_saida, :valor_desconto, :valor_produtos, :valor_total_nota, :valor_frete, 
                                        :valor_outras_despesas, :numero_pedido_compra, :tipo_pagamento, :meio_pagamento, :numero_parcelas_pagamento, :observacao, :chave_acesso_nfe, :nota_cancelada_sn)
  end

  def set_nota_fiscal
    @nota_fiscal = NotaFiscal.find(params[:nota_fiscal_id])
  end
end
