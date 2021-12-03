class AdministradoresController < ApplicationController
  before_action :set_administrador, only: %i[show edit update destroy]

  def index
    @administradores = empresa.administradores

    options = { page: params[:page] || 1, per_page: 50 }
    @administradores = @administradores.paginate(options)
  end

  def show; end

  def new
    @administrador = Administrador.new
  end

  def edit; end

  def create
    @administrador = Administrador.new(administrador_params)

    respond_to do |format|
      if @administrador.save
        format.html { redirect_to @administrador, notice: 'Administrador Cadastrado' }
        format.json { render :show, status: :created, location: @administrador }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @administrador.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @administrador.update(administrador_params)
        format.html { redirect_to @administrador, notice: 'Administrador Alterado' }
        format.json { render :show, status: :ok, location: @administrador }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @administrador.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @administrador.destroy
    respond_to do |format|
      format.html { redirect_to administradores_url, notice: 'Administrador Excluído' }
      format.json { head :no_content }
    end
  end

  private

  def set_administrador
    @administrador = Administrador.find(params[:id])
  end

  def administrador_params
    params.require(:administrador).permit(:empresa_id, :nome, :email, :senha)
  end
end
