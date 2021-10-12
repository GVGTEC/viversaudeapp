class LoginController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'login'

  def index; end

  def logar
    user = Administrador.where(email: params['login']['email'], senha: params['login']['senha'])
    if user.present?
      time = params['login']['lembrar'] == '1' ? 1.year.from_now : 30.minutes.from_now
      user = user.first
      value = {
        id: user.id,
        nome: user.nome,
        email: user.email
      }
      cookies[:admin_viver_saude] = { value: value.to_json, expires: time, httponly: true }

      redirect_to '/'
    else
      flash[:erro] = 'Email ou senha inválidos'
      redirect_to login_path
    end
  end

  def deslogar
    cookies[:admin_viver_saude] = nil
    redirect_to login_path
  end
end
