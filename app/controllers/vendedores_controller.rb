class VendedoresController < ApplicationController
  before_action :set_vendedor, only: %i[show edit update destroy]

  def index
    @vendedores = empresa.vendedores

    options = { page: params[:page] || 1, per_page: 50 }
    @vendedores = @vendedores.paginate(options)
  end

  def show; end

  def new
    @vendedor = Vendedor.new
  end

  def edit; end

  def create
    @vendedor = Vendedor.new(vendedor_params)
    @vendedor.empresa_id = @adm.empresa.id

    respond_to do |format|
      if @vendedor.save
        format.html { redirect_to @vendedor, notice: 'Vendedor Cadastrado' }
        format.json { render :show, status: :created, location: @vendedor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vendedor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vendedor.update(vendedor_params)
        format.html { redirect_to @vendedor, notice: 'Vendedor Alterado' }
        format.json { render :show, status: :ok, location: @vendedor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vendedor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vendedor.destroy
    respond_to do |format|
      format.html { redirect_to vendedores_url, notice: 'Vendedor Excluído' }
      format.json { head :no_content }
    end
  end

  private

  def set_vendedor
    @vendedor = Vendedor.find(params[:id])
  end

  def vendedor_params
    params.require(:vendedor).permit(:nome, :pessoa, :cpf, :rg, :cnpj, :ie, :endereco, :bairro, :cidade, :cep, :uf,
                                     :telefone, :email)
  end
end
