class FileImportJob < ApplicationJob
  queue_as :default

  def perform(arquivo_importado_id)
    arquivo = ArquivoImportado.find_by(id: arquivo_importado_id)

    if arquivo
      arquivo.update_attribute(:status, "Processing")
      arquivo.processar
    end
  end
end
