class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.administrador_record=(administrador)
    @@administrador_record = administrador
  end

  def self.administrador_record
    @@administrador_record
  rescue StandardError
    nil
  end

  def salvar_empresa
    self.empresa_id = @@administrador_record.empresa.id
  end

  def formatar_data(data)
    dia = [0..1].to_i
    mes = [2..3].to_i
    ano = [4..7].to_i

    Date.new(ano, mes, dia)
  rescue
    data
  end
end
