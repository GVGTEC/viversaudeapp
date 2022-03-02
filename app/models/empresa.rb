class Empresa < ApplicationRecord
  has_many :administradores, dependent: :delete_all 
  has_many :arquivo_importados, dependent: :delete_all
  has_many :cfop, dependent: :delete_all 
  has_many :clientes, dependent: :delete_all 
  has_many :contas_pag, dependent: :delete_all 
  has_many :contas_rec, dependent: :delete_all 
  has_many :estoques, dependent: :delete_all 
  has_many :fornecedores, dependent: :delete_all 
  has_many :localizacao_estoques, dependent: :delete_all 
  has_many :nota_fiscais, dependent: :delete_all 
  has_many :plano_contas, dependent: :delete_all 
  has_many :produtos, dependent: :delete_all 
  has_many :terceiros, dependent: :delete_all 
  has_many :transportadoras, dependent: :delete_all 
  has_many :vendedores, dependent: :delete_all
end
