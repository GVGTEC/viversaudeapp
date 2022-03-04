class ClienteContatosController < ApplicationController
  before_action :set_cliente_contato, only: %i[ show edit update destroy ]
  before_action :set_cliente

  def index
    @cliente_contatos = @cliente.contatos
  end

  def show
  end

  def new
    @cliente_contato = @cliente.contatos.new
  end

  def edit
  end

  def create
    @cliente_contato = @cliente.contatos.build(cliente_contato_params)

    respond_to do |format|
      if @cliente_contato.save
        format.html { redirect_to cliente_cliente_contatos_url(@cliente), notice: "Cliente contato was successfully created." }
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
        format.html { redirect_to cliente_cliente_contatos_url(@cliente), notice: "Cliente contato was successfully updated." }
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
      format.html { redirect_to cliente_cliente_contatos_url(@cliente), notice: "Cliente contato was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_cliente_contato
      @cliente_contato = ClienteContato.find(params[:id])
    end

    def set_cliente
      @cliente = Cliente.find(params[:cliente_id])     
    end

    def cliente_contato_params
      params.require(:cliente_contato).permit(:cliente_id, :nome, :telefone, :email, :cargo, :departamento)
    end
end