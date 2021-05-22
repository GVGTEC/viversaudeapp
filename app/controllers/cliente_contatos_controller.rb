class ClienteContatosController < ApplicationController
  before_action :set_cliente_contato, only: %i[ show edit update destroy ]

  # GET /cliente_contatos or /cliente_contatos.json
  def index
    @cliente_contatos = ClienteContato.all
  end

  # GET /cliente_contatos/1 or /cliente_contatos/1.json
  def show
  end

  # GET /cliente_contatos/new
  def new
    @cliente_contato = ClienteContato.new
  end

  # GET /cliente_contatos/1/edit
  def edit
  end

  # POST /cliente_contatos or /cliente_contatos.json
  def create
    @cliente_contato = ClienteContato.new(cliente_contato_params)

    respond_to do |format|
      if @cliente_contato.save
        format.html { redirect_to @cliente_contato, notice: "Cliente contato was successfully created." }
        format.json { render :show, status: :created, location: @cliente_contato }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cliente_contato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cliente_contatos/1 or /cliente_contatos/1.json
  def update
    respond_to do |format|
      if @cliente_contato.update(cliente_contato_params)
        format.html { redirect_to @cliente_contato, notice: "Cliente contato was successfully updated." }
        format.json { render :show, status: :ok, location: @cliente_contato }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cliente_contato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cliente_contatos/1 or /cliente_contatos/1.json
  def destroy
    @cliente_contato.destroy
    respond_to do |format|
      format.html { redirect_to cliente_contatos_url, notice: "Cliente contato was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente_contato
      @cliente_contato = ClienteContato.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cliente_contato_params
      params.require(:cliente_contato).permit(:cliente_id, :nome, :telefone, :email)
    end
end
