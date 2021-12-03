class ClientesController < ApplicationController
  before_action :set_cliente, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token, only: [:importar]

  def index
    @clientes = empresa.clientes
    @clientes = @clientes.where("lower(nome) ilike '%#{params[:nome]}%'") if params[:nome].present?

    options = { page: params[:page] || 1, per_page: 25 }
    @clientes = @clientes.paginate(options)
  end

  def importar
    if params[:arquivo].blank?
      flash[:error] = 'Selecione um arquivo .CSV'
      redirect_to '/clientes'
      return
    end

    if File.basename(params[:arquivo].tempfile).include?('.CSV')
      importar_csv
    else
      flash[:error] = 'Formato de arquivo não suportado. Selecione um arquivo com a extensão .CSV'
      redirect_to '/clientes'
      return
    end

    flash[:sucesso] = 'Clientes importados com sucesso'
    redirect_to '/clientes'
  rescue StandardError => e
    flash[:error] = e
    redirect_to '/clientes'
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
    id_vendedor = 17
    id_terceiro = 18
    empresa_governo = 19

    cliente = Cliente.new
    cliente.id = linha[id].to_i

    vendedor = linha[id_vendedor].to_i
    if vendedor != 0
      begin
        cliente.vendedor_id = Vendedor.find(vendedor).id
      rescue StandardError
        cliente.vendedor_id = Vendedor.create(id: vendedor, nome: "Vendendor #{vendedor}",
                                              empresa_id: @adm.empresa.id).id
      end
    end

    terceiro = linha[id_terceiro].to_i
    if terceiro != 0
      begin
        cliente.terceiro_id = Terceiro.find(terceiro).id
      rescue StandardError
        cliente.terceiro_id = Terceiro.create(id: terceiro, nome: "Terceiro #{terceiro}",
                                              empresa_id: @adm.empresa.id).id
      end
    end

    cliente.nome = linha[nome].strip
    cliente.pessoa = linha[pessoa].strip
    cliente.cpf = linha[cpf].strip if linha[cpf].to_i != 0
    cliente.rg = linha[rg].strip if linha[rg].to_i != 0
    cliente.cnpj = linha[cnpj] if linha[cnpj].to_i != 0
    cliente.ie = linha[ie] if linha[ie].to_i != 0
    cliente.endereco = linha[endereco].strip
    cliente.bairro = linha[bairro].strip
    cliente.cidade = linha[cidade].strip
    cliente.cep = linha[cep].strip
    cliente.uf = linha[uf].strip
    cliente.telefone = linha[telefone].strip
    cliente.telefone_alternativo = linha[telefone_alternativo].strip
    cliente.telefone_nf = linha[telefone_nf].strip
    cliente.email = linha[email].strip
    cliente.codcidade_ibge = linha[codcidade_ibge].strip
    cliente.empresa_governo = true if linha[empresa_governo].include?('S')
    cliente.empresa_id = @adm.empresa.id
    cliente.save
  end

  def show; end

  def new
    @cliente = Cliente.new
  end

  def edit; end

  def create
    @cliente = Cliente.new(cliente_params)
    @cliente.empresa_id = @adm.empresa.id

    respond_to do |format|
      if @cliente.save
        salvar_contatos
        format.html { redirect_to @cliente, notice: 'Cliente Cadastrado' }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cliente.update(cliente_params)
        salvar_contatos
        format.html { redirect_to @cliente, notice: 'Cliente Alterado' }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cliente.destroy
    salvar_contatos
    respond_to do |format|
      format.html { redirect_to clientes_url, notice: 'Cliente Excluído' }
      format.json { head :no_content }
    end
  end

  private

  def set_cliente
    @cliente = Cliente.find(params[:id])
  end

  def salvar_contatos
    if params[:cliente].present? && params[:cliente][:contato].present?
      @cliente.contatos.destroy_all if @cliente.contatos != []
      params[:cliente][:contato].each do |contato_cliente|
        next unless contato_cliente[:nome].present? || contato_cliente[:telefone].present?

        contato = Contato.new
        contato.nome = contato_cliente[:nome]
        contato.email = contato_cliente[:email]
        contato.telefone = contato_cliente[:telefone]
        contato.cargo = contato_cliente[:cargo]
        contato.departamento = contato_cliente[:departamento]
        contato.natureza = params[:controller]
        contato.natureza_id = @cliente.id
        contato.save!
      end
    end
  end

  def cliente_params
    params.require(:cliente).permit(:vendedor_id, :terceiro_id, :nome, :pessoa, :cpf, :rg, :cnpj, :ie, :endereco,
                                    :bairro, :cidade, :cep, :uf, :telefone, :email, :codcidade_ibge, :consumidor_final)
  end
end
