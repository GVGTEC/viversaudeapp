class ClientesController < ApplicationController
  before_action :set_cliente, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, :only => [:importar]

  # GET /clientes or /clientes.json
  def index
    @clientes = Cliente.all
    @clientes = @clientes.where("lower(nome) ilike '%#{params[:nome]}%'") if params[:nome].present?

    # paginação na view index (lista)
    options = {page: params[:page] || 1, per_page: 10} 
    @clientes = @clientes.paginate(options)
  end


  def importar
    begin
      if params[:arquivo].blank?
        flash[:error] = "Selecione um arquivo"
        redirect_to "/clientes"
        return
      end
  
      if File.basename(params[:arquivo].tempfile).include?(".CSV")
        importar_csv
      else
        flash[:error] = "Formato de arquivo não suportado, por favor seleciona arquivos com a extenção csv"
        redirect_to "/clientes"
        return
      end
  
      flash[:sucesso] = "Dados importados com sucesso"
      redirect_to "/clientes"
    rescue => exception
      flash[:error] = exception
      redirect_to "/clientes"
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
      cliente = Cliente.new
      cliente.id = linha[id].to_i

      cliente.nome = linha[nome]
      cliente.pessoa = linha[pessoa]
      cliente.cpf = linha[cpf] if linha[cpf].to_i != 0
      cliente.rg = linha[rg] if linha[rg].to_i != 0
      cliente.cnpj = linha[cnpj] if linha[cnpj].to_i != 0
      cliente.ie = linha[ie] if linha[ie].to_i != 0
      cliente.endereco = linha[endereco] 
      cliente.bairro = linha[bairro] 
      cliente.cidade = linha[cidade] 
      cliente.cep = linha[cep] 
      cliente.uf = linha[uf] 
      cliente.telefone = linha[telefone] 
      cliente.telefone_alternativo = linha[telefone_alternativo] 
      cliente.telefone_nf = linha[telefone_nf] 
      cliente.email = linha[email] 
      cliente.codcidade_ibge = linha[codcidade_ibge] 
      cliente.empresa_governo = true if linha[empresa_governo].include?("S")
      cliente.save
    rescue Exception => err
      raise err
      Rails.logger.error err.message
    end
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
