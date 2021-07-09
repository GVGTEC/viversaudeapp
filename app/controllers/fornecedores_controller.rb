class FornecedoresController < ApplicationController
  before_action :set_fornecedor, only: %i[ show edit update destroy ]

  # GET /fornecedores or /fornecedores.json
  def index
    @fornecedores = Fornecedor.all
    @fornecedores = @fornecedores.where("lower(nome) ilike '%#{params[:nome]}%'") if params[:nome].present?

    # paginação na view index (lista)
    options = {page: params[:page] || 1, per_page: 10} 
    @fornecedores = @fornecedores.paginate(options)
  end

  # GET /fornecedores/1 or /fornecedores/1.json
  def show
  end

  # GET /fornecedores/new
  def new
    @fornecedor = Fornecedor.new
  end

  # GET /fornecedores/1/edit
  def edit
  end

  # POST /fornecedores or /fornecedores.json
  def create
    @fornecedor = Fornecedor.new(fornecedor_params)

    respond_to do |format|
      if @fornecedor.save
        salvar_contatos
        format.html { redirect_to @fornecedor, notice: "Fornecedor was successfully created." }
        format.json { render :show, status: :created, location: @fornecedor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fornecedor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fornecedores/1 or /fornecedores/1.json
  def update
    respond_to do |format|
      if @fornecedor.update(fornecedor_params)
        salvar_contatos
        format.html { redirect_to @fornecedor, notice: "Fornecedor was successfully updated." }
        format.json { render :show, status: :ok, location: @fornecedor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fornecedor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fornecedores/1 or /fornecedores/1.json
  def destroy
    @fornecedor.destroy
    respond_to do |format|
      format.html { redirect_to fornecedores_url, notice: "Fornecedor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fornecedor
      @fornecedor = Fornecedor.find(params[:id])
    end

    def salvar_contatos
      if params[:fornecedor].present? && params[:fornecedor][:contato].present?
        @fornecedor.contatos.destroy_all if @fornecedor.contatos != []
        params[:fornecedor][:contato].each do |contato_fornecedor|
          if contato_fornecedor[:nome].present? || contato_fornecedor[:telefone].present?
            contato = Contato.new
            contato.nome = contato_fornecedor[:nome]
            contato.email = contato_fornecedor[:email]
            contato.telefone = contato_fornecedor[:telefone]
            contato.natureza = params[:controller]
            contato.natureza_id = @fornecedor.id
            contato.save!
          end
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def fornecedor_params
      params.require(:fornecedor).permit(:nome, :pessoa, :cpf, :rg, :cnpj, :ie, :endereco, :bairro, :cidade, :cep, :uf, :telefone, :email, :codcidade_ibge)
    end
end
