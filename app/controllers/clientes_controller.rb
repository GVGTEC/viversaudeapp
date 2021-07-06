class ClientesController < ApplicationController
  before_action :set_cliente, only: %i[ show edit update destroy ]

  # GET /clientes or /clientes.json
  def index
    @clientes = Cliente.all
    @clientes = @clientes.where("lower(nome) ilike '%#{params[:nome]}%'") if params[:nome].present?

    # paginação na view index (lista)
    options = {page: params[:page] || 1, per_page: 10} 
    @clientes = @clientes.paginate(options)
  end

  # GET /clientes/1 or /clientes/1.json
  def show
  end

  # GET /clientes/new
  def new
    @cliente = Cliente.new
  end

  # GET /clientes/1/edit
  def edit
  end

  # POST /clientes or /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)

    respond_to do |format|
      if @cliente.save
        salvar_contatos
        format.html { redirect_to @cliente, notice: "Cliente was successfully created." }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientes/1 or /clientes/1.json
  def update
    respond_to do |format|
      if @cliente.update(cliente_params)
        salvar_contatos
        format.html { redirect_to @cliente, notice: "Cliente was successfully updated." }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1 or /clientes/1.json
  def destroy
    @cliente.destroy
    salvar_contatos
    respond_to do |format|
      format.html { redirect_to clientes_url, notice: "Cliente was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    def salvar_contatos
      if params[:cliente].present? && params[:cliente][:contato].present?
        @cliente.contatos.destroy_all if @cliente.contatos != []
        params[:cliente][:contato].each do |contato_cliente|
          if contato_cliente[:nome].present? || contato_cliente[:telefone].present?
            contato = Contato.new
            contato.nome = contato_cliente[:nome]
            contato.email = contato_cliente[:email]
            contato.telefone = contato_cliente[:telefone]
            contato.natureza = params[:controller]
            contato.natureza_id = @cliente.id
            contato.save!
          end
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def cliente_params
      params.require(:cliente).permit(:vendedor_id, :terceiro_id,:nome, :pessoa, :cpf, :rg, :cnpj, :ie, :endereco, :bairro, :cidade, :cep, :uf, :telefone, :email, :codcidade_ibge)
    end
end
