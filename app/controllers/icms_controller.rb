class IcmsController < ApplicationController
  before_action :set_icms, only: %i[show edit update destroy]

  def index
    @icms = Icms.all
  end

  def show; end

  def new
    @icms = Icms.new
  end

  def edit; end

  def create
    @icms = Icms.new(icms_params)

    respond_to do |format|
      if @icms.save
        format.html { redirect_to @icms, notice: 'Icms Cadastrado' }
        format.json { render :show, status: :created, location: @icms }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @icms.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @icms.update(icms_params)
        format.html { redirect_to @icms, notice: 'Icms Alterado' }
        format.json { render :show, status: :ok, location: @icms }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @icms.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @icms.destroy
    respond_to do |format|
      format.html { redirect_to icms_index_url, notice: 'Icms Excluído' }
      format.json { head :no_content }
    end
  end

  private

  def set_icms
    @icms = Icms.find(params[:id])
  end

  def icms_params
    params.require(:icms).permit(:estado, :aliquota_icms, :aliquota_icms_st, :mva_icms_st, :fcp_sn, :fcp_pc)
  end
end
