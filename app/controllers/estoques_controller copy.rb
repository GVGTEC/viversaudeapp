class EstoquesController < ApplicationController

  def ajuste
    format.html { redirect_to "/estoques/_form_ajuste"}
  end

  def show
  end
end
