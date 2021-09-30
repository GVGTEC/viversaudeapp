class FornecedoresController < ApplicationController
  before_action :set_fornecedor, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, :only => [:importar]

  # GET /fornecedores or /fornecedores.json
  def index
    @fornecedores = Fornecedor.where(empresa_id: @adm.empresa.id)
    @fornecedores = @fornecedores.order("nome asc")
    @fornecedores = @fornecedores.where("lower(nome) ilike '%#{params[:nome]}%'") if params[:nome].present?

    # paginação na view index (lista)
    options = {page: params[:page] || 1, per_page: 50} 
    @fornecedores = @fornecedores.paginate(options)
  end

  def importar
    begin
      if params[:arquivo].blank?
        flash[:error] = "Selecione um arquivo .CSV"
        redirect_to "/fornecedores"
        return
      end
  
      if File.basename(params[:arquivo].tempfile).include?(".CSV")
        importar_csv
      else
        flash[:error] = "Formato de arquivo não suportado. Selecione um arquivo com a extensão .CSV"
        redirect_to "/fornecedores"
        return
      end
  
      flash[:sucesso] = "Fornecedores importados com sucesso"
      redirect_to "/fornecedores"
    rescue => exception
      flash[:error] = exception
      redirect_to "/fornecedores"
      return
    end
  end

  def importar_csv
    File.foreach(params[:arquivo].tempfile) do |line|
      d = CharlockHolmes::EncodingDetector.detect(line)
      line = line.to_s.encode("UTF-8", d[:encoding], invalid: :replace, replace: "")
      if line.present?
        importar_linha(line.split(";"))
      end
    end
  end

  def importar_linha(linha)
    id = 0
    pessoa = 1
    nome = 2
    rg = 3
    cpf = 4
    ie = 5
    cnpj = 6
    endereco = 7
    bairro = 8
    cidade = 9
    uf = 10
    cep = 11
    telefone = 12
    telefone_alternativo = 13
    codcidade_ibge = 14
    telefone_nf = 15
    email = 16
    id_vendedor = 17
    id_terceiro = 18
    empresa_governo = 19
    
    begin
      #debugger
      fornecedor = Fornecedor.new
      fornecedor.id = linha[id].to_i
      fornecedor.pessoa = linha[pessoa]
      fornecedor.nome = linha[nome]
      fornecedor.cpf = linha[cpf] if linha[cpf].to_i != 0
      fornecedor.rg = linha[rg] if linha[rg].to_i != 0
      fornecedor.cnpj = linha[cnpj] if linha[cnpj].to_i != 0
      fornecedor.ie = linha[ie] if linha[ie].to_i != 0
      fornecedor.endereco = linha[endereco] 
      fornecedor.bairro = linha[bairro] 
      fornecedor.cidade = linha[cidade] 
      fornecedor.cep = linha[cep] 
      fornecedor.uf = linha[uf] 
      fornecedor.telefone = linha[telefone] 
      fornecedor.telefone_alternativo = linha[telefone_alternativo] 
      fornecedor.telefone_nf = linha[telefone_nf] 
      fornecedor.email = linha[email] 
      fornecedor.codcidade_ibge = linha[codcidade_ibge] 
      fornecedor.save
    rescue Exception => err
      raise err
      Rails.logger.error err.message
    end
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
    @fornecedor.empresa_id = @adm.empresa.id

    respond_to do |format|
      if @fornecedor.save
        salvar_contatos
        format.html { redirect_to @fornecedor, notice: "Fornecedor criado com sucesso." }
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
        format.html { redirect_to @fornecedor, notice: "Fornecedor atualizado com sucesso." }
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
      format.html { redirect_to fornecedores_url, notice: "Fornecedor excluído com sucesso.." }
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
