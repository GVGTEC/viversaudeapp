class ImportarClientesController < ApplicationController
    skip_before_action :verify_authenticity_token, :only => [:importar_arquivo]
  
    def importar
    end
  
    def importar_arquivo
        begin
          if params[:arquivo].blank?
            flash[:error] = "Selecione um arquivo .CSV"
            redirect_to "/importar_cliente/importar"
            return
          end
      
          if File.basename(params[:arquivo].tempfile).include?(".CSV")
            importar_csv
          else
            flash[:error] = "Formato de arquivo não suportado. Selecione um arquivo com a extensão .CSV"
            redirect_to "/importar_cliente/importar"
            return
          end
      
          flash[:sucesso] = "Clientes importados com sucesso"
          redirect_to "/importar_cliente/importar"
        rescue => exception
          flash[:error] = exception
          redirect_to "/importar_cliente/importar"
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
        situacao = 1 #se branco ele esta ativo
        codigo_fabricante = 2
        codigo_barras = 3
        descricao = 4
        descricao_nfe = 5
        fornecedor_id = 6 
        situacao_tributaria = 10 
        ncm = 12
        unidade = 14
        preco_custo_medio = 15 # duas casas decimais
        preco_custo = 16 # duas casas decimais
        margem_lucro = 17 #4 casas decimais
        preco_venda = 18
        margem_lucro_oferta = 19
        preco_oferta = 20
        data_inicial_oferta = 21
        data_final_oferta = 22
        controlar_estoque = 23
        estoque_atual = 24
        estoque_minimo = 25
        data_ultimo_reajuste = 28
        comissao_pc = 31
        bloquear_preco = 32
        localizacao_estoque_id = 33
    
        begin
          cliente = cliente.new
          cliente.codprd_sac = linha[codprd_sac]
          cliente.situacao = linha[situacao].present?? false : true
          cliente.codigo_fabricante = linha[codigo_fabricante]
          cliente.codigo_barras = linha[codigo_barras]
          cliente.descricao = linha[descricao]
          cliente.descricao_nfe = linha[descricao_nfe]
    
          begin
            cliente.fornecedor_id = Fornecedor.find(linha[fornecedor_id].to_i).id
          rescue 
            cliente.fornecedor_id = Fornecedor.create(id: linha[fornecedor_id].to_i).id
          end
    
          cliente.situacao_tributaria = linha[situacao_tributaria]
          cliente.ncm = linha[ncm]
          cliente.unidade = linha[unidade]
          cliente.preco_custo_medio = separate_comma(linha[preco_custo_medio].to_i)
          cliente.preco_custo = separate_comma(linha[preco_custo].to_i) 
          cliente.margem_lucro = separate_margem(linha[margem_lucro].to_i) 
          cliente.preco_venda = separate_comma(linha[preco_venda].to_i)
          cliente.margem_lucro_oferta = separate_margem(linha[margem_lucro_oferta].to_i)
          cliente.preco_oferta = separate_comma(linha[preco_oferta].to_i)
          cliente.data_inicial_oferta = linha[data_inicial_oferta]
          cliente.controlar_estoque = linha[controlar_estoque]
          cliente.estoque_atual = linha[estoque_atual]
          cliente.estoque_minimo = linha[estoque_minimo]
          cliente.data_ultimo_reajuste = linha[data_ultimo_reajuste]
          cliente.comissao_pc = linha[comissao_pc]
          cliente.bloquear_preco = linha[bloquear_preco]
    
          begin
            cliente.localizacao_estoque_id = LocalizacaoEstoque.find(linha[localizacao_estoque_id].to_i).id
          rescue 
            cliente.localizacao_estoque_id = LocalizacaoEstoque.create(id: linha[localizacao_estoque_id].to_i).id
          end
    
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
  
