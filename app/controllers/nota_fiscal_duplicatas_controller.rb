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
  rescue StandardError => e
    flash[:error] = 'Erro no cadastramento. Verifique se todos os campos estão prenchidos corretamente.'
    redirect_to new_nota_fiscal_nota_fiscal_duplicata_path(@nota_fiscal)
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
          valor_parcela: faturamento_parcela[:valor_parcela].gsub('R$', '').to_f
        )
        
        @nota_fiscal_faturamento_parcela.save
      end
    end

    flash[:notice] = 'Nota fiscal item Cadastrado' 
    redirect_to observacoes_nota_fiscal_path(@nota_fiscal)
  end

  def formatar_numero_duplicata(numero)
    format '%03d', numero
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
