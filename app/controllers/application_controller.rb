class ApplicationController < ActionController::Base
  before_action  :authenticate_user!

  def authenticate_user!
    if cookies[:admin_viver_saude].blank?
      redirect_to "/login"
    else
      ApplicationRecord.administrador_record=(administrador)
      administrador
    end
  end

  def administrador
    if cookies[:admin_viver_saude].present?
      return @adm if @adm.present?
      @adm = Administrador.find(JSON.parse(cookies[:admin_viver_saude])["id"])
      return @adm
    end
  end
end
