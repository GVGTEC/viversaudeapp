class CreateArquivoImportados < ActiveRecord::Migration[5.2]
  def change
    create_table :arquivo_importados do |t|
      t.references :empresa,  foreign_key: true
      t.string :name,         :null => false
      t.binary :data,         :null => false
      t.string :filename
      t.string :mime_type
      t.string :status

      t.timestamps
    end
  end
end
