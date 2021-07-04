class MovimentoEstoquesController < ApplicationController
  before_action :set_estoque

  # GET /movimento_estoques or /movimento_estoques.json
  def index
    @movimento_estoques = MovimentoEstoque.where(estoque_id: @estoque.id)
  end

  private
    def set_estoque
      @estoque = Estoque.find(params[:estoque_id])
    end
end
