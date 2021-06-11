class TransportadoraContatosController < ApplicationController
  before_action :set_transportadora_contato, only: %i[ show edit update destroy ]

  # GET /transportadora_contatos or /transportadora_contatos.json
  def index
    @transportadora_contatos = TransportadoraContato.all
  end

  # GET /transportadora_contatos/1 or /transportadora_contatos/1.json
  def show
  end

  # GET /transportadora_contatos/new
  def new
    @transportadora_contato = TransportadoraContato.new
  end

  # GET /transportadora_contatos/1/edit
  def edit
  end

  # POST /transportadora_contatos or /transportadora_contatos.json
  def create
    @transportadora_contato = TransportadoraContato.new(transportadora_contato_params)

    respond_to do |format|
      if @transportadora_contato.save
        format.html { redirect_to @transportadora_contato, notice: "Transportadora contato was successfully created." }
        format.json { render :show, status: :created, location: @transportadora_contato }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transportadora_contato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transportadora_contatos/1 or /transportadora_contatos/1.json
  def update
    respond_to do |format|
      if @transportadora_contato.update(transportadora_contato_params)
        format.html { redirect_to @transportadora_contato, notice: "Transportadora contato was successfully updated." }
        format.json { render :show, status: :ok, location: @transportadora_contato }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transportadora_contato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transportadora_contatos/1 or /transportadora_contatos/1.json
  def destroy
    @transportadora_contato.destroy
    respond_to do |format|
      format.html { redirect_to transportadora_contatos_url, notice: "Transportadora contato was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transportadora_contato
      @transportadora_contato = TransportadoraContato.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transportadora_contato_params
      params.require(:transportadora_contato).permit(:transportadora_id, :nome, :telefone, :email)
    end
end
