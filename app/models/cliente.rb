class Cliente < ApplicationRecord
  belongs_to :empresa
  has_many :contatos, class_name: "ClienteContato", dependent: :delete_all
  has_many :nota_fiscais, dependent: :delete_all

  default_scope { order('nome asc') }

  def self.importar_linha(empresa_id, linha)
    id = 0
    pessoa = 1
    nome = 2
    rg = 3
    cpf = 4
    ie = 5
    cnpj = 6
    endereco = 7
    bairro = 8
    cidade = 9
    uf = 10
    cep = 11
    telefone = 12
    telefone_alternativo = 13
    codcidade_ibge = 14
    telefone_nf = 15
    email = 16
    id_vendedor = 17
    id_terceiro = 18
    empresa_governo = 19

    empresa = Empresa.find(empresa_id)
    cliente = empresa.clientes.new
    cliente.id = linha[id].to_i
    cliente.nome = linha[nome].strip rescue linha[nome]
    cliente.pessoa = linha[pessoa].strip rescue linha[pessoa]
    cliente.cpf = linha[cpf].strip if linha[cpf].to_i != 0
    cliente.rg = linha[rg].strip if linha[rg].to_i != 0
    cliente.cnpj = linha[cnpj] if linha[cnpj].to_i != 0
    cliente.ie = linha[ie] if linha[ie].to_i != 0
    cliente.endereco = linha[endereco].strip rescue linha[endereco] 
    cliente.bairro = linha[bairro].strip rescue linha[bairro]
    cliente.cidade = linha[cidade].strip rescue linha[cidade]
    cliente.cep = linha[cep].strip rescue linha[cep]
    cliente.uf = linha[uf].strip rescue linha[uf]
    cliente.telefone = linha[telefone].strip rescue linha[telefone]  
    cliente.telefone_alternativo = linha[telefone_alternativo].strip rescue linha[telefone_alternativo]  
    cliente.telefone_nf = linha[telefone_nf].strip rescue linha[telefone_nf]
    cliente.email = linha[email].strip rescue linha[email]
    cliente.codcidade_ibge = linha[codcidade_ibge].strip rescue linha[codcidade_ibge]
    cliente.empresa_governo = true if linha[empresa_governo].include?('S')

    vendedor = linha[id_vendedor].to_i
    cliente.vendedor_id = Vendedor.find_or_create_by(id: vendedor, empresa_id: empresa.id).id unless vendedor.zero?
    
    terceiro = linha[id_terceiro].to_i
    cliente.terceiro_id = Terceiro.find_or_create_by(id: terceiro, empresa_id: empresa.id).id unless terceiro.zero?

    cliente.save
  rescue => e
    puts e.to_s
  end
end
