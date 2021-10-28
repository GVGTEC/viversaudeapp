class MovimentoEstoquesController < ApplicationController
  # GET /movimento_estoques or /movimento_estoques.json
  def index
    @movimento_estoques = MovimentoEstoque.all
    @movimento_estoques = @movimento_estoques.where(produto_id: params[:produto_id]) if params[:produto_id].present?
    @movimento_estoques = @movimento_estoques.where(nota_fiscal_id: params[:nota_fiscal_id]) if params[:nota_fiscal_id].present?

    # paginação na view index (lista)
    if params[:format] != 'json'
      options = { page: params[:page] || 1, per_page: 50 }
      @movimento_estoques = @movimento_estoques.paginate(options)
    end
  end

end
