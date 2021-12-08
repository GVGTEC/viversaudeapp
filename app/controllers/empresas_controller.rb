class EmpresasController < ApplicationController
  before_action :set_empresa, only: %i[show edit update destroy]

  def index
    @empresas = Empresa.all

    options = { page: params[:page] || 1, per_page: 50 }
    @empresas = @empresas.paginate(options)
  end

  def show; end

  def new
    @empresa = Empresa.new
  end

  def configuracoes
    @empresa = @adm.empresa
  end

  def edit; end

  def create
    @empresa = Empresa.new(empresa_params)

    respond_to do |format|
      if @empresa.save
        format.html { redirect_to @empresa, notice: 'Empresa Cadastrado' }
        format.json { render :show, status: :created, location: @empresa }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @empresa.update(empresa_params)
        format.html { redirect_to configuracoes_empresas_path, notice: 'Empresa Alterado' }
        format.json { render :show, status: :ok, location: @empresa }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @empresa.destroy
    respond_to do |format|
      format.html { redirect_to empresas_url, notice: 'Empresa Excluído' }
      format.json { head :no_content }
    end
  end

  private

  def set_empresa
    @empresa = Empresa.find(params[:id])
  end

  def empresa_params
    params.require(:empresa).permit(:nome, :nome_fantasia, :cnpj, :inscricao_estadual, :inscricao_municipal, :endereco,
                                    :numero, :complemento, :bairro, :cidade, :cep, :uf, :telefone, :email, :codigo_uf_emitente, :codcid_ibge, :aliquota_pis, :aliquota_cofins, :serie_nfe, :cnae, 
                                    :ambiente, :versao_layout, :regime_tributario, :emissor_nfe, :permite_credito_icms, :credito_icms_pc, :empresa_uninfe, :pasta_envio, :pasta_retorno, :senha)
  end
end
