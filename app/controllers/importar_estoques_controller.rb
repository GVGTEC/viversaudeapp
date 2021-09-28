class ImportarEstoquesController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:importar_arquivo]

  def importar
  end

  def importar_arquivo
      begin
        if params[:arquivo].blank?
          flash[:error] = "Selecione um arquivo .CSV"
          redirect_to "/importar_estoque/importar"
          return
        end
    
        if File.basename(params[:arquivo].tempfile).include?(".CSV")
          importar_csv
        else
          flash[:error] = "Formato de arquivo não suportado. Selecione um arquivo com a extensão .CSV"
          redirect_to "/importar_estoque/importar"
          return
        end
    
        flash[:sucesso] = "Estoques importados com sucesso"
        redirect_to "/importar_estoque/importar"
      rescue => exception
        flash[:error] = exception
        redirect_to "/importar_estoque/importar"
        return
      end
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
      codprd_sac = 0
      lote = 1 #se branco ele esta ativo
      fornecedor_id = 2 
      #quantidade = 3  # duas casas decimais //NÃO IREMOS USAR
      estoque_atual_lote = 4 # duas casas decimais
      #saidas = 5 # duas casas decimais      //NÃO IREMOS USAR
      preco_custo_reposicao = 6 # duas casas decimais
      documento = 7
      data_reposicao = 8
      data_validade = 9
  
      begin
        estoque = Estoque.new
        estoque.codprd_sac = linha[codprd_sac]
        estoque.lote = linha[lote]

        begin
          estoque.fornecedor_id = Fornecedor.find(linha[fornecedor_id].to_i).id
        rescue 
          estoque.fornecedor_id = Fornecedor.create(id: linha[fornecedor_id].to_i).id
        end

       # estoque.quantidade = linha[quantidade]
        estoque.estoque_atual_lote = linha[estoque_atual_lote]
       # estoque.saidas = linha[saidas]
  
        estoque.preco_custo_reposicao = separate_comma(linha[preco_custo_reposicao].to_i)
        estoque.data_reposicao = linha[data_reposicao]
        estoque.data_validade = linha[data_validade]
  
        estoque.save
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
