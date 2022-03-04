class ClientesController < ApplicationController
  before_action :set_cliente, only: %i[show edit update destroy observacoes]
  skip_before_action :verify_authenticity_token, only: [:importar]

  def index
    @clientes = empresa.clientes
    
    if params[:busca].present?
      @clientes = @clientes.where("
        (lower(nome) ilike '%#{params[:busca].downcase}%') OR
        (cpf ilike '%#{params[:busca].downcase}%') OR
        (cnpj ilike '%#{params[:busca].downcase}%')
      ")
    end

    options = { page: params[:page] || 1, per_page: 10 }
    @clientes = @clientes.paginate(options)
  end

  def importar
    if params[:arquivo].blank?
      flash[:error] = 'Selecione um arquivo .CSV'
      redirect_to '/clientes'
      return
    end

    if File.basename(params[:arquivo].tempfile).include?('.CSV')
      dir = Rails.root.join('public', 'uploads')
      Dir.mkdir(dir) unless Dir.exist?(dir)
      @incoming_file = params[:arquivo]
      file_name = "#{rand(34999999)}_file"

      File.open(dir.join(file_name), 'wb') do |file|
        file.write(@incoming_file.read)
      end

      FileImportJob.perform_later(dir.join(file_name).to_s, empresa.id)
    else
      flash[:error] = 'Formato de arquivo não suportado. Selecione um arquivo com a extensão .CSV'
      redirect_to '/clientes'
      return
    end

    flash[:sucesso] = 'Em instantes seus clientes estarão importantes'
    redirect_to '/clientes'
  rescue => e
    flash[:error] = e
    redirect_to '/clientes'
    nil
  end
  
  def observacoes; end

  def show
    if params[:format] == "pdf"
      render pdf: "Cliente id: #{@cliente.id}", 
             template: "clientes/relatorio.pdf.html.erb"
    end
  end
  
  def new
    @cliente = Cliente.new
  end

  def edit; end

  def create
    @cliente = empresa.clientes.build(cliente_params)

    respond_to do |format|
      if @cliente.save
        format.html { redirect_to cliente_cliente_contatos_path(@cliente)} if params[:contatos].present?
        format.html { redirect_to observacoes_cliente_path(@cliente), notice: 'Cliente Cadastrado' } 
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
    respond_to do |format|
      format.html { redirect_to clientes_url, notice: 'Cliente Excluído' }
      format.json { head :no_content }
    end
  end

  private

  def set_cliente
    @cliente = empresa.clientes.find(params[:id])
  end

  def cliente_params
    params.require(:cliente).permit(:vendedor_id, :terceiro_id, :nome, :pessoa, :cpf, :rg, :cnpj, :ie, :endereco, :observacoes, :bairro, :cidade, :cep, :uf, :telefone, :email, :codcidade_ibge, :consumidor_final)
  end
end
