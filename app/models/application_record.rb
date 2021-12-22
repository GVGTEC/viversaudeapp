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
end
