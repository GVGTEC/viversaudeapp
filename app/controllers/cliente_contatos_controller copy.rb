class ClienteContatosController < ApplicationController
  before_action :set_cliente
  before_action :set_cliente_contato, only: %i[show edit update destroy]
  
  # GET /cliente_contatos or /cliente_contatos.json
  def index
    #@cliente_contatos = ClienteContato.all
    @cliente_contatos = ClienteContato.where(cliente_id: @cliente.id)   
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

    #debugger

    respond_to do |format|
      #cliente_id: @cliente.id,
      #cliente_contato.cliente_id = @nota_fiscal.id
      @cliente_contato.cliente_id = @cliente.id

      if @cliente_contato.save
        #format.html { redirect_to cliente_cliente_contato_url(@cliente_contato), notice: "Cliente contato was successfully created." }
        #format.html { redirect_to cliente_cliente_contatos_path, notice: "" } // Go Show
        format.html { redirect_to cliente_cliente_contatos_path, notice: "" } // Go Index
        format.json { render :show, status: :created, location: @cliente_contato }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cliente_contato.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cliente_contato.update(cliente_contato_params)
        # (ORIGINAL) format.html { redirect_to cliente_cliente_contato_url(@cliente_contato), notice: "" }
        format.html { redirect_to cliente_cliente_contatos_path, notice: "" }
        format.json { render :show, status: :ok, location: @cliente_contato }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cliente_contato.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cliente_contato.destroy

    respond_to do |format|
      format.html { redirect_to cliente_contatos_url, notice: "" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente_contato
      @cliente_contato = ClienteContato.find(params[:id])
      #@cliente_contato = Cliente_ClienteContato.find(params[:id])
    end

    def set_cliente
      @cliente = Cliente.find(params[:cliente_id])     
    end

    # Only allow a list of trusted parameters through.
    def cliente_contato_params
      params.require(:cliente_contato).permit(:cliente_id, :nome, :telefone, :email, :cargo, :departamento)
    end
end
