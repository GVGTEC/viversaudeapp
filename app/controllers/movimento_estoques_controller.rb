class MovimentoEstoquesController < ApplicationController
  before_action :set_produto

  # GET /movimento_estoques or /movimento_estoques.json
  def index
    @movimento_estoques = MovimentoEstoque.where(produto_id: @produto.id)
  end

  private
    def set_produto
      @produto = Produto.find(params[:produto_id])
    end
end
