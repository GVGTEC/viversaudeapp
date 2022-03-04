class FileImportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    require 'csv'

    CSV.foreach(args.first, col_sep: ';') do |line|
      sleep(3)
      Cliente.importar_linha(args.last, line)
    end 
    
    Dir.rmdir Rails.root.join('public', 'uploads')
  end
end
