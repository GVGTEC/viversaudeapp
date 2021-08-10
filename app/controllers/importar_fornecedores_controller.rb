class ImportarClientesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:importar_arquivo]

  def importar
  end

  def importar_arquivo
    if params[:arquivo].blank?
      flash[:error] = "Selecione um arquivo .CSV"
      redirect_to "/importar_cliente/importar"
      return
    end

    if File.basename(params[:arquivo].tempfile).include?(".CSV")
      importar_csv
    else
      flash[:error] = "Formato de arquivo não suportado. Selecione um arquivo com a extenção .CSV"
      redirect_to "/importar_cliente/importar"
      return
    end

    flash[:sucesso] = "Clientes importados com sucesso"
    redirect_to "/importar_cliente/importar"
  rescue => exception
    flash[:error] = exception
    redirect_to "/importar_cliente/importar"
    nil
  end

  def importar_csv
    File.foreach(params[:arquivo].tempfile) do |line|
      d = CharlockHolmes::EncodingDetector.detect(line)
      line = line.to_s.encode("UTF-8", d[:encoding], invalid: :replace, replace: "")
      if line.present?
        importar_linha(line.split(";"))
      end
    end
  end

  def importar_linha(linha)
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

    begin
      cliente = Cliente.new
      cliente.id = linha[id].to_i
      cliente.vendedor_id = 1
      cliente.terceiro_id = 1
      cliente.nome = linha[nome]
      cliente.pessoa = linha[pessoa]
      cliente.cpf = linha[cpf] if linha[cpf].to_i != 0
      cliente.rg = linha[rg] if linha[rg].to_i != 0
      cliente.cnpj = linha[cnpj] if linha[cnpj].to_i != 0
      cliente.ie = linha[ie] if linha[ie].to_i != 0
      cliente.endereco = linha[endereco]
      cliente.bairro = linha[bairro]
      cliente.cidade = linha[cidade]
      cliente.cep = linha[cep]
      cliente.uf = linha[uf]
      cliente.telefone = linha[telefone]
      cliente.telefone_alternativo = linha[telefone_alternativo]
      cliente.telefone_nf = linha[telefone_nf]
      cliente.email = linha[email]
      cliente.codcidade_ibge = linha[codcidade_ibge]
      cliente.empresa_governo = true if linha[empresa_governo].include?("S")
      cliente.save
    rescue Exception => err
      raise err
      Rails.logger.error err.message
    end
  end

  private

  def separate_comma(number)
    reverse_digits = number.to_s.chars.reverse
    reverse_digits.each_slice(2).map(&:join).join(",").reverse.to_f
  end

  def separate_margem(number)
    reverse_digits = number.to_s.chars.reverse
    reverse_digits.each_slice(4).map(&:join).join(",").reverse.to_f
  end
end
