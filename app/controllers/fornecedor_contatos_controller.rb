class FornecedorContatosController < ApplicationController
  before_action :set_fornecedor_contato, only: %i[ show edit update destroy ]

  # GET /fornecedor_contatos or /fornecedor_contatos.json
  def index
    @fornecedor_contatos = FornecedorContato.all
  end

  # GET /fornecedor_contatos/1 or /fornecedor_contatos/1.json
  def show
  end

  # GET /fornecedor_contatos/new
  def new
    @fornecedor_contato = FornecedorContato.new
  end

  # GET /fornecedor_contatos/1/edit
  def edit
  end

  # POST /fornecedor_contatos or /fornecedor_contatos.json
  def create
    @fornecedor_contato = FornecedorContato.new(fornecedor_contato_params)

    respond_to do |format|
      if @fornecedor_contato.save
        format.html { redirect_to @fornecedor_contato, notice: "Fornecedor contato was successfully created." }
        format.json { render :show, status: :created, location: @fornecedor_contato }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fornecedor_contato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fornecedor_contatos/1 or /fornecedor_contatos/1.json
  def update
    respond_to do |format|
      if @fornecedor_contato.update(fornecedor_contato_params)
        format.html { redirect_to @fornecedor_contato, notice: "Fornecedor contato was successfully updated." }
        format.json { render :show, status: :ok, location: @fornecedor_contato }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fornecedor_contato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fornecedor_contatos/1 or /fornecedor_contatos/1.json
  def destroy
    @fornecedor_contato.destroy
    respond_to do |format|
      format.html { redirect_to fornecedor_contatos_url, notice: "Fornecedor contato was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fornecedor_contato
      @fornecedor_contato = FornecedorContato.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fornecedor_contato_params
      params.require(:fornecedor_contato).permit(:fornecedor_id, :nome, :telefone, :email)
    end
end
