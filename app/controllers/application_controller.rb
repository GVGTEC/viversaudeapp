class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :administrador
  Struct = Micro::Struct.new(optional: [:id, :nome, :email])

  def authenticate_user!
    redirect_to '/login' if cookies[:admin_viver_saude].blank?
  end

  def administrador
    @adm ||= Administrador.find(admin_viver_saude.id) if cookies[:admin_viver_saude].present?
  end

  def empresa
    administrador.empresa
  end

  def admin_viver_saude
    admin = Struct.new
    JSON.parse(cookies[:admin_viver_saude]).each {|key, value| admin[key] = value }
    admin
  end
end
