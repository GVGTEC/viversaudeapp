class CreateEmpresas < ActiveRecord::Migration[5.2]
  def change
    create_table :empresas do |t|
      t.string :nome
      t.string :nome_fantasia
      t.string :cnpj
      t.string :inscricao_estadual
      t.string :inscricao_municipal
      t.string :endereco
      t.string :numero
      t.string :complemento
      t.string :bairro
      t.string :cidade
      t.string :cep
      t.string :uf
      t.string :telefone
      t.string :email
      t.string :codigo_uf_emitente
      t.string :codcid_ibge
      t.string :aliquota_pis
      t.string :aliquota_cofins
      t.string :serie-nfe
      t.string :cnae
      t.string :ambiente
      t.string :versao_layout
      t.string :regime_tributario
      t.string :emissor_nfe
      t.string :permite_credito_icms
      t.string :credito_icms_pc
      t.string :empresa_uninfe
      t.string :pasta_envio
      t.string :pasta_retorno
      t.string :senha

      t.timestamps
    end
  end
end
