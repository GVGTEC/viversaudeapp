class FornecedoresController < ApplicationController
  before_action :set_fornecedor, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token, only: [:importar]

  def index
    @fornecedores = empresa.fornecedores
    @fornecedores = @fornecedores.order('nome asc')
    @fornecedores = @fornecedores.where("lower(nome) ilike '%#{params[:nome]}%'") if params[:nome].present?

    options = { page: params[:page] || 1, per_page: 10 }
    @fornecedores = @fornecedores.paginate(options)
  end

  def importar
    if params[:arquivo].blank?
      flash[:error] = 'Selecione um arquivo .CSV'
      redirect_to '/fornecedores'
      return
    end

    if File.basename(params[:arquivo].tempfile).include?('.CSV')
      importar_csv
    else
      flash[:error] = 'Formato de arquivo não suportado. Selecione um arquivo com a extensão .CSV'
      redirect_to '/fornecedores'
      return
    end

    flash[:sucesso] = 'Fornecedores importados com sucesso'
    redirect_to '/fornecedores'
  rescue StandardError => e
    flash[:error] = e
    redirect_to '/fornecedores'
    nil
  end

  def importar_csv
    File.foreach(params[:arquivo].tempfile) do |line|
      d = CharlockHolmes::EncodingDetector.detect(line)
      line = line.to_s.encode('UTF-8', d[:encoding], invalid: :replace, replace: '')
      importar_linha(line.split(';')) if line.present?
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

    begin
      fornecedor = Fornecedor.find(linha[id].to_i)
    rescue StandardError
      fornecedor = Fornecedor.new
      fornecedor.id = linha[id].to_i
    end

    fornecedor.pessoa = linha[pessoa].strip
    fornecedor.nome = linha[nome].strip
    fornecedor.cpf = linha[cpf].strip if linha[cpf].to_i != 0
    fornecedor.rg = linha[rg].strip if linha[rg].to_i != 0
    fornecedor.cnpj = linha[cnpj].strip if linha[cnpj].to_i != 0
    fornecedor.ie = linha[ie].strip if linha[ie].to_i != 0
    fornecedor.endereco = linha[endereco].strip
    fornecedor.bairro = linha[bairro].strip
    fornecedor.cidade = linha[cidade].strip
    fornecedor.cep = linha[cep].strip
    fornecedor.uf = linha[uf].strip
    fornecedor.telefone = linha[telefone].strip
    fornecedor.telefone_alternativo = linha[telefone_alternativo].strip
    fornecedor.telefone_nf = linha[telefone_nf].strip
    fornecedor.email = linha[email].strip
    fornecedor.codcidade_ibge = linha[codcidade_ibge].strip
    fornecedor.empresa_id = @adm.empresa.id
    fornecedor.save
  end

  def show; end

  def new
    @fornecedor = Fornecedor.new
  end

  def edit; end

  # POST /fornecedores or /fornecedores.json
  def create
    @fornecedor = Fornecedor.new(fornecedor_params)
    @fornecedor.empresa_id = @adm.empresa.id

    respond_to do |format|
      if @fornecedor.save
        salvar_contatos
        format.html { redirect_to @fornecedor, notice: 'Fornecedor Cadastrado' }
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
        format.html { redirect_to @fornecedor, notice: 'Fornecedor Alterado' }
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
      format.html { redirect_to fornecedores_url, notice: 'Fornecedor Excluído' }
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
        next unless contato_fornecedor[:nome].present? || contato_fornecedor[:telefone].present?

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

  def fornecedor_params
    params.require(:fornecedor).permit(:nome, :pessoa, :cpf, :rg, :cnpj, :ie, :endereco, :bairro, :cidade, :cep, :uf,
                                       :telefone, :email, :codcidade_ibge)
  end
end
