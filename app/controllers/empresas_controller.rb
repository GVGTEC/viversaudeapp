class EmpresasController < ApplicationController
  before_action :set_empresa, only: %i[ show edit update destroy ]

  # GET /empresas or /empresas.json
  def index
    @empresas = Empresa.all
  end

  # GET /empresas/1 or /empresas/1.json
  def show
  end

  # GET /empresas/new
  def new
    @empresa = Empresa.new
  end

  # GET /empresas/1/edit
  def edit
  end

  # POST /empresas or /empresas.json
  def create
    @empresa = Empresa.new(empresa_params)

    respond_to do |format|
      if @empresa.save
        format.html { redirect_to @empresa, notice: "Empresa was successfully created." }
        format.json { render :show, status: :created, location: @empresa }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empresas/1 or /empresas/1.json
  def update
    respond_to do |format|
      if @empresa.update(empresa_params)
        format.html { redirect_to @empresa, notice: "Empresa was successfully updated." }
        format.json { render :show, status: :ok, location: @empresa }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empresas/1 or /empresas/1.json
  def destroy
    @empresa.destroy
    respond_to do |format|
      format.html { redirect_to empresas_url, notice: "Empresa was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empresa
      @empresa = Empresa.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def empresa_params
      params.require(:empresa).permit(:nome, :nome_fantasia, :cnpj, :inscricao_estadual, :inscricao_municipal, :endereco, :numero, :complemento, :bairro, :cidade, :cep, :uf, :telefone, :email, :codigo_uf_emitente, :codcid_ibge, :aliquota_pis, :aliquota_cofins, :serie-nfe, :cnae, :ambiente, :versao_layout, :regime_tributario, :emissor_nfe, :permite_credito_icms, :credito_icms_pc, :empresa_uninfe, :pasta_envio, :pasta_retorno, :senha)
    end
end
