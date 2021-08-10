class NotaFiscalDuplicatasController < ApplicationController
  before_action :set_nota_fiscal
  skip_before_action :verify_authenticity_token, only: [:create]

  def new
  end

  def create
    @nota_fiscal.valor_total_nota = params[:nota_fiscal][:valor_total_nota]
    @nota_fiscal.meio_pagamento = params[:nota_fiscal][:meio_pagamento]
    @nota_fiscal.tipo_pagamento = params[:nota_fiscal][:tipo_pagamento]
    @nota_fiscal.numero_parcelas_pagamento = params[:nota_fiscal][:numero_parcelas_pagamento]
    @nota_fiscal.distancia_parcelas = params[:nota_fiscal][:distancia_parcelas]
    @nota_fiscal.save

    salvar_vencimento_parcelas
  rescue => exception
    flash[:error] = "Erro no cadastramento. Verifique se todos os campos estão prenchidos corretamente."
    redirect_to "/nota_fiscais/#{@nota_fiscal.id}/nota_fiscal_faturamento_parcelas/new"
    nil
  end

  private

  # Only allow a list of trusted parameters through.
  def nota_fiscal_params
    params.require(:nota_fiscal).permit(:numero_nota, :numero_pedido, :cfop_id, :entsai, :cliente_id, :fornecedor_id, :vendedor_id, :data_emissao, :data_saida, :hora_saida, :valor_desconto, :valor_produtos, :valor_total_nota, :valor_frete, :valor_outras_despesas, :numero_pedido_compra, :tipo_pagamento, :meio_pagamento, :numero_parcelas_pagamento, :observacao, :chave_acesso_nfe, :nota_cancelada_sn)
  end

  def salvar_vencimento_parcelas
    if params[:nota_fiscal].has_key?(:nota_fiscal_faturamento_parcelas)
      NotaFiscalFaturamentoParcela.where(nota_fiscal: @nota_fiscal.id).destroy_all
      params[:nota_fiscal][:nota_fiscal_faturamento_parcelas].each do |faturamento_parcela|
        @nota_fiscal_faturamento_parcela = NotaFiscalFaturamentoParcela.new
        @nota_fiscal_faturamento_parcela.nota_fiscal = @nota_fiscal
        @nota_fiscal_faturamento_parcela.duplicata = "xxx"
        @nota_fiscal_faturamento_parcela.prazo_pagamento = faturamento_parcela[:prazo_pagamento]
        @nota_fiscal_faturamento_parcela.data_vencimento = faturamento_parcela[:data_vencimento]
        @nota_fiscal_faturamento_parcela.valor_parcela = faturamento_parcela[:valor_parcela]
        @nota_fiscal_faturamento_parcela.save
      end
    end

    respond_to do |format|
      format.html { redirect_to nota_fiscais_path, notice: "Nota fiscal item was successfully created." }
    end
  end

  def set_nota_fiscal
    @nota_fiscal = NotaFiscal.find(params[:nota_fiscal_id])
  end
end
