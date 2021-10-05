class OrcamentoItensController < ApplicationController
  before_action :set_orcamento_item, only: %i[ show edit update destroy ]
  before_action :set_orcamento

  # GET /orcamento_itens or /orcamento_itens.json
  def index
    @orcamento_itens = OrcamentoItem.all
  end

  # GET /orcamento_itens/1 or /orcamento_itens/1.json
  def show
  end

  # GET /orcamento_itens/new
  def new
    @orcamento_item = OrcamentoItem.new
  end

  # GET /orcamento_itens/1/edit
  def edit
  end

  # POST /orcamento_itens or /orcamento_itens.json
  def create
    @orcamento_item = OrcamentoItem.new(orcamento_item_params)

    respond_to do |format|
      if @orcamento_item.save
        format.html { redirect_to @orcamento_item, notice: "Orçamento Itens Cadastrado" }
        format.json { render :show, status: :created, location: @orcamento_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @orcamento_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orcamento_itens/1 or /orcamento_itens/1.json
  def update
    respond_to do |format|
      if @orcamento_item.update(orcamento_item_params)
        format.html { redirect_to @orcamento_item, notice: "Orçamento Itens Alterado" }
        format.json { render :show, status: :ok, location: @orcamento_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @orcamento_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orcamento_itens/1 or /orcamento_itens/1.json
  def destroy
    @orcamento_item.destroy
    respond_to do |format|
      format.html { redirect_to orcamento_itens_url, notice: "Orçamento Itens Excluído" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orcamento_item
      @orcamento_item = OrcamentoItem.find(params[:id])
    end

    def set_orcamento
      @orcamento = Orcamento.find(params[:orcamento_id])
    end
    # Only allow a list of trusted parameters through.
    def orcamento_item_params
      params.require(:orcamento_item).permit(:orcamento_id, :produto_id, :quantidade, :preco_unitario, :preco_total)
    end
end
