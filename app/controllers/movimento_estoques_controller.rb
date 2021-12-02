class MovimentoEstoquesController < ApplicationController
  # GET /movimento_estoques or /movimento_estoques.json
  def index
    @movimento_estoques = MovimentoEstoque.all
    @movimento_estoques = @movimento_estoques.where(produto_id: params[:produto_id]) if params[:produto_id].present?
    @movimento_estoques = @movimento_estoques.where(nota_fiscal_id: params[:nota_fiscal_id]) if params[:nota_fiscal_id].present?
    @movimento_estoques = @movimento_estoques.where(estoque_id: params[:estoque_id]) if params[:estoque_id].present?
    
    if params[:data_inicio].present? && params[:data_fim].present? 
      data_inicio = Time.zone.parse(params[:data_inicio]).beginning_of_day 
      data_fim = Time.zone.parse(params[:data_fim]).end_of_day 
      @movimento_estoques = @movimento_estoques.where('data BETWEEN ? AND ?', data_inicio, data_fim)
    end

    # paginação na view index (lista)
    if params[:format] != 'json'
      options = { page: params[:page] || 1, per_page: 10 }
      @movimento_estoques = @movimento_estoques.paginate(options)
    end
  end
end
