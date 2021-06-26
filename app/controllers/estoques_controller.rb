class EstoquesController < ApplicationController
  def index
    @estoques = Estoque.all
  end
  
  def ajuste
    @estoque = Estoque.new
  end

  def reposicao
    @estoque = Estoque.new
  end

  def baixa
    @estoque = Estoque.new
  end

  def show
  end
end
