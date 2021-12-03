class TransportadorasController < ApplicationController
  before_action :set_transportadora, only: %i[show edit update destroy]

  def index
    @transportadoras = empresa.transportadoras

    options = { page: params[:page] || 1, per_page: 50 }
    @transportadoras = @transportadoras.paginate(options)
  end

  def show; end

  def new
    @transportadora = Transportadora.new
  end

  def edit; end

  def create
    @transportadora = Transportadora.new(transportadora_params)
    @transportadora.empresa_id = @adm.empresa.id

    respond_to do |format|
      if @transportadora.save
        salvar_contatos
        format.html { redirect_to @transportadora, notice: 'Transportadora Cadastrada' }
        format.json { render :show, status: :created, location: @transportadora }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transportadora.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @transportadora.update(transportadora_params)
        salvar_contatos
        format.html { redirect_to @transportadora, notice: 'Transportadora Alterada' }
        format.json { render :show, status: :ok, location: @transportadora }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transportadora.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transportadora.destroy
    salvar_contatos
    respond_to do |format|
      format.html { redirect_to transportadoras_url, notice: 'Transportadora Excluída' }
      format.json { head :no_content }
    end
  end

  private

  def set_transportadora
    @transportadora = Transportadora.find(params[:id])
  end

  def salvar_contatos
    if params[:transportadora].present? && params[:transportadora][:contato].present?
      @transportadora.contatos.destroy_all if @transportadora.contatos != []
      params[:transportadora][:contato].each do |contato_transportadora|
        next unless contato_transportadora[:nome].present? || contato_transportadora[:telefone].present?

        contato = Contato.new
        contato.nome = contato_transportadora[:nome]
        contato.email = contato_transportadora[:email]
        contato.telefone = contato_transportadora[:telefone]
        contato.natureza = params[:controller]
        contato.natureza_id = @transportadora.id
        contato.save!
      end
    end
  end

  def transportadora_params
    params.require(:transportadora).permit(:nome, :cnpj, :ie, :endereco, :bairro, :cidade, :cep, :uf)
  end
end
